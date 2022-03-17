import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  CardsBloc() : super(CardsEmptyState()) {
    on<CardsEvent>((event, emit) {
      //
    });
  }
}
