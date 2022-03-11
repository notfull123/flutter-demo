part of 'detail_coffee_cubit.dart';

class DetailCoffeeState extends Equatable {
  LoadStatus? loadStatus;
  Coffee? result;
  int count;
  ToppingCharacter toppingCharacter;
  int priceTopping;

  DetailCoffeeState({
    this.loadStatus,
    this.result,
    this.count = 1,
    this.priceTopping = 0,
    this.toppingCharacter = ToppingCharacter.non,
  });

  DetailCoffeeState copyWith({
    LoadStatus? loadStatus,
    Coffee? result,
    int? count,
    int? priceTopping,
    ToppingCharacter? toppingCharacter,
  }) {
    return DetailCoffeeState(
      loadStatus: loadStatus ?? this.loadStatus,
      result: result ?? this.result,
      count: count ?? this.count,
      priceTopping: priceTopping ?? this.priceTopping,
      toppingCharacter: toppingCharacter ?? this.toppingCharacter,
    );
  }

  @override
  List<Object?> get props => [
        loadStatus,
        result,
        count,
        priceTopping,
        toppingCharacter,
      ];
}
