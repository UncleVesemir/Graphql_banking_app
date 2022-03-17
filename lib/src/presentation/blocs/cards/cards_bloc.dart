import 'package:banking/src/data/network/graphql_repository.dart';
import 'package:banking/src/domain/entities/card.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  final GraphQLRepositiry graphQLRepositiry;
  CardsBloc({required this.graphQLRepositiry}) : super(CardsEmptyState()) {
    on<CardsEvent>((event, emit) {
      on<AddCardEvent>((event, emit) async {
        emit(CardsLoadingState());
        try {
          final Card card = await graphQLRepositiry.addCard(event);
          print(card.name);
          emit(CardsLoadedState(card: card));
        } catch (e) {
          print(e);
          emit(CardsErrorState(error: e));
        }
      });
    });
  }
}
