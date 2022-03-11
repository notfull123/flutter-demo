import 'package:bloc/bloc.dart';
import 'package:coffee_rosie/model/coffee.dart';
import 'package:coffee_rosie/model/load_status.dart';
import 'package:coffee_rosie/repositories/coffee_repository.dart';
import 'package:coffee_rosie/ui/detail_coffee.dart';
import 'package:equatable/equatable.dart';

part 'detail_coffee_state.dart';

class DetailCoffeeCubit extends Cubit<DetailCoffeeState> {
  CoffeeRepository coffeeRepository;

  DetailCoffeeCubit(this.coffeeRepository) : super(DetailCoffeeState());

  void init() async {
    emit(state.copyWith(loadStatus: LoadStatus.LOADING));
    try {
      final result = await coffeeRepository.getDetailCoffee();
      if (result != null) {
        emit(state.copyWith(result: result, loadStatus: LoadStatus.SUCCESS));
      } else {
        emit(state.copyWith(loadStatus: LoadStatus.FAILURE));
      }
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.FAILURE));
    }
  }

  void onPlus(int count) {
    count++;
    emit(state.copyWith(count: count));
  }

  void onMinus(int count) {
    count--;
    emit(state.copyWith(count: count, priceTopping: count == 0 ? 0 : state.priceTopping));
  }

  void onChooseTopping({required int price, ToppingCharacter? toppingCharacter}) {
    emit(state.copyWith(toppingCharacter: toppingCharacter, priceTopping: price));
  }
}
