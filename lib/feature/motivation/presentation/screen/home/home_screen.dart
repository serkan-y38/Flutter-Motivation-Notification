import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motivation_notification/feature/motivation/domain/entity/motivation_entity.dart';
import 'package:motivation_notification/feature/motivation/presentation/bloc/motivation_bloc.dart';
import 'package:motivation_notification/feature/motivation/presentation/bloc/motivation_event.dart';
import 'package:motivation_notification/feature/motivation/presentation/bloc/motivation_state.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workmanager/workmanager.dart';
import '../../../../../core/task_manager/task_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  MotivationEntity _motivationEntity = MotivationEntity(quote: "", author: "");

  bool _isLoading = false;
  bool _isTaskRegistered = false;

  @override
  void initState() {
    Workmanager()
        .isScheduledByUniqueName(scheduleMotivationNotification)
        .then((onValue) => setState(() => _isTaskRegistered = onValue));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBloc(),
    );
  }

  Widget _buildBloc() {
    return BlocBuilder<MotivationBloc, MotivationState>(
      builder: (context, state) {
        if (state is GetRandomQuoteSuccess) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            setState(() {
              _motivationEntity = state.entity!;
              _isLoading = false;
            });
          });
        } else if (state is GetRandomQuoteError) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _motivationEntity = MotivationEntity(
              author: state.exception!.stackTrace.toString(),
              quote: state.exception!.message,
            );
            _isLoading = false;
          });
        }
        return _buildScreen();
      },
    );
  }

  Widget _buildScreen() {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        _motivationEntity.quote.toString(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Text(
                        _motivationEntity.author.toString(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 16,
              ),
              ElevatedButton(
                child: Text("Get Random Quote"),
                onPressed: () {
                  _isLoading = true;
                  context.read<MotivationBloc>().add(GetRandomQuoteEvent());
                },
              ),
              ElevatedButton(
                child: _isTaskRegistered
                    ? Text("Cancel Motivation Notification")
                    : Text("Schedule Motivation Notification"),
                onPressed: () async {
                  await Permission.notification.isGranted
                      ? _scheduleOrCancelTask()
                      : await Permission.notification.request();
                },
              ),
            ],
          ),
        ),
        if (_isLoading) Center(child: CircularProgressIndicator()),
      ],
    );
  }

  void _scheduleOrCancelTask() {
    _isTaskRegistered
        ? Workmanager().cancelByUniqueName(scheduleMotivationNotification)
        : Workmanager().registerPeriodicTask(
            scheduleMotivationNotification,
            scheduleMotivationNotification,
            frequency: Duration(hours: 24),
            constraints: Constraints(
              networkType: NetworkType.connected,
              requiresCharging: false,
              requiresBatteryNotLow: false,
              requiresDeviceIdle: false,
            ),
          );

    setState(() => _isTaskRegistered = !_isTaskRegistered);
  }
}
