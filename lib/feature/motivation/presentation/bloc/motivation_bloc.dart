import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motivation_notification/core/response/my_response.dart';
import 'package:motivation_notification/feature/motivation/domain/entity/motivation_entity.dart';
import 'package:motivation_notification/feature/motivation/domain/use_case/get_random_quote_use_case.dart';
import 'package:motivation_notification/feature/motivation/presentation/bloc/motivation_event.dart';
import 'package:motivation_notification/feature/motivation/presentation/bloc/motivation_state.dart';

class MotivationBloc extends Bloc<MotivationEvent, MotivationState> {
  final GetRandomQuoteUseCase _getRandomQuoteUseCase;

  MotivationBloc(this._getRandomQuoteUseCase)
    : super(const InitialMotivationState()) {
    on<GetRandomQuoteEvent>(_onGetRandomQuote);
  }

  void _onGetRandomQuote(
    MotivationEvent event,
    Emitter<MotivationState> emit,
  ) async {
    final response = await _getRandomQuoteUseCase.call();
    if (response is Success<MotivationEntity>) {
      emit(GetRandomQuoteSuccess(response.data!));
    } else {
      emit(GetRandomQuoteError(response.dio!));
    }
  }
}
