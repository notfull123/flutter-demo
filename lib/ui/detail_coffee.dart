import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_rosie/bloc/detail_coffee_cubit.dart';
import 'package:coffee_rosie/common/app_images.dart';
import 'package:coffee_rosie/model/load_status.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailCoffeeScreen extends StatefulWidget {
  DetailCoffeeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _DetailCoffeeScreenState createState() => _DetailCoffeeScreenState();
}

class _DetailCoffeeScreenState extends State<DetailCoffeeScreen> {
  ToppingCharacter? _character = ToppingCharacter.non;
  late final DetailCoffeeCubit _cubit;

  @override
  void initState() {
    _cubit = BlocProvider.of<DetailCoffeeCubit>(context);
    super.initState();
    _cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        child: BlocConsumer<DetailCoffeeCubit, DetailCoffeeState>(
          bloc: _cubit,
          listenWhen: (prev, current) => prev.loadStatus != current.loadStatus,
          listener: (context, state) {},
          buildWhen: (prev, current) => prev.loadStatus != current.loadStatus,
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CachedNetworkImage(
                          progressIndicatorBuilder: (context, url, progress) {
                            return const SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                              ),
                            );
                          },
                          imageUrl: state.result?.avatar ?? "",
                          fit: BoxFit.fitWidth,
                          errorWidget: (context, url, error) {
                            return Container(
                              alignment: Alignment.center,
                              child: Text(state.loadStatus == LoadStatus.LOADING ? "" : "Error load image!!!"),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Spacer(),
                          Center(
                            child: Text(
                              state.result?.name ?? "--",
                              style:
                                  const TextStyle(color: Color(0xff636362), fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Center(
                              child: Text(
                                state.result?.description ?? "--",
                                style: const TextStyle(
                                    color: Color(0xff999999), fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ),
                          ),
                          const Spacer(),
                          const Divider(
                            height: 1,
                            color: Color(0xFFBDBDBD),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 16,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$ ${state.result?.price ?? "--"}",
                                  style: const TextStyle(
                                      color: Color(0xff585858), fontSize: 18, fontWeight: FontWeight.w500),
                                ),
                                BlocBuilder<DetailCoffeeCubit, DetailCoffeeState>(
                                  buildWhen: (prev, current) =>
                                      prev.count != current.count || prev.loadStatus != current.loadStatus,
                                  builder: (context, state) {
                                    return Row(
                                      children: [
                                        _itemEditCountButton(
                                            icon: AppImages.icMinus,
                                            onTap: () {
                                              if (state.count >= 1) {
                                                _onTapMinus(state.count);
                                              }
                                            },
                                            iconSize: 28,
                                            color: state.count == 0 ? Colors.grey : const Color(0xff996D4A)),
                                        SizedBox(
                                          width: 50,
                                          child: Center(
                                              child: Text(state.count.toString(),
                                                  style: const TextStyle(
                                                      color: Color(0xff585858),
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w500))),
                                        ),
                                        _itemEditCountButton(
                                          icon: AppImages.icPlus,
                                          onTap: () {
                                            _onTapPlus(state.count);
                                          },
                                          iconSize: 25,
                                          color: const Color(0xff996D4A),
                                        ),
                                      ],
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                          Container(
                            color: const Color(0xffF2F3F3),
                            width: double.infinity,
                            padding: const EdgeInsets.only(left: 15),
                            alignment: Alignment.centerLeft,
                            height: MediaQuery.of(context).size.height / 15,
                            child: RichText(
                              text: const TextSpan(
                                text: 'MILK OPTION ',
                                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Color(0xff5C5C5E)),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '(REQUIRED)',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Color(0xffA9AAAA)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height / 20,
                            padding: const EdgeInsets.only(left: 15),
                            alignment: Alignment.centerLeft,
                            color: const Color(0xffE4E3E4),
                            child: const Text(
                              "Please select 1 item",
                              style: TextStyle(color: Color(0xff656565), fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: ListView.builder(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        shrinkWrap: true,
                        itemCount: state.result?.toppings?.length ?? 0,
                        itemBuilder: (context, index) {
                          return _itemTopping(
                            name: state.result?.toppings?[index].name ?? "",
                            price: state.result?.toppings?[index].price ?? "",
                            type: state.result?.toppings?[index].getDestinationType ?? ToppingCharacter.fullMilk,
                          );
                        },
                      ),
                    ),
                    BlocBuilder<DetailCoffeeCubit, DetailCoffeeState>(
                      buildWhen: (prev, current) =>
                          prev.count != current.count ||
                          prev.loadStatus != current.loadStatus ||
                          prev.toppingCharacter != current.toppingCharacter,
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 25.0, right: 25.0, bottom: 15),
                          child: ElevatedButton(
                            onPressed: () {
                              _onAddToCart(context,
                                  price: state.count == 0
                                      ? "0"
                                      : ((int.parse(state.result?.price ?? "0") + state.priceTopping) * state.count)
                                          .toString());
                            },
                            style: ElevatedButton.styleFrom(primary: const Color(0xff362722)),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height / 20,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 20,
                                    child: Image.asset(
                                      AppImages.icCart,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    "ADD ${state.count} TO CART",
                                    style: const TextStyle(
                                        color: Color(0xFFBDBDBD), fontWeight: FontWeight.bold, fontSize: 18),
                                  ),
                                  Text(
                                    "\$ ${state.count == 0 ? "0" : ((int.parse(state.result?.price ?? "0") + state.priceTopping) * state.count).toString()}",
                                    style: const TextStyle(
                                        color: Color(0xFFBDBDBD), fontWeight: FontWeight.bold, fontSize: 18),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
                Positioned(
                  top: kIsWeb ? 10 : 20,
                  left: 0,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 5, 8, 5),
                      child: Image.asset(
                        AppImages.icBack,
                        scale: 0.7,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _itemEditCountButton(
      {required String icon, required VoidCallback onTap, required double iconSize, required Color color}) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: SizedBox(
        height: iconSize,
        child: Image.asset(
          icon,
          color: color,
        ),
      ),
    );
  }

  Widget _itemTopping({required String name, required String price, required ToppingCharacter type}) {
    return BlocBuilder<DetailCoffeeCubit, DetailCoffeeState>(
      buildWhen: (prev, current) => prev.toppingCharacter != current.toppingCharacter || prev.count != current.count,
      builder: (context, state) {
        if (state.count == 0) {
          _character = ToppingCharacter.non;
        }
        return ListTile(
          title: RichText(
            text: TextSpan(
              text: name,
              style: const TextStyle(color: Color(0xff585858), fontSize: 15, fontWeight: FontWeight.w500),
              children: <TextSpan>[
                TextSpan(
                  text: price.isEmpty ? "" : '(\$$price)',
                  style: const TextStyle(color: Colors.grey, fontSize: 15),
                ),
              ],
            ),
          ),
          trailing: Radio<ToppingCharacter>(
            value: type,
            groupValue: _character,
            onChanged: (ToppingCharacter? value) {
              _character = value;
              _cubit.onChooseTopping(price: int.parse(price.isEmpty ? "0" : price), toppingCharacter: value);
            },
          ),
        );
      },
    );
  }

  void _onTapPlus(int count) {
    _cubit.onPlus(count);
  }

  void _onTapMinus(int count) {
    _cubit.onMinus(count);
  }

  void _onAddToCart(BuildContext context, {required String price}) {
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    AlertDialog alertSuccess = AlertDialog(
      title: const Center(child: Text("Congratulations!")),
      content: RichText(
        text: TextSpan(
          text: "You have successfully added to cart with the amount of ",
          style: const TextStyle(color: Color(0xff585858), fontSize: 15),
          children: <TextSpan>[
            TextSpan(
              text: "$price\$",
              style: const TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      actions: [
        okButton,
      ],
    );

    AlertDialog alertError = AlertDialog(
      title: const Center(child: Text("Warning!")),
      content: const Text(
        "Please add product quantity to cart!",
        style: TextStyle(color: Color(0xff585858), fontSize: 15),
      ),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return price == "0" ? alertError : alertSuccess;
      },
    );
  }
}

enum ToppingCharacter { fullMilk, skimMilk, soyMilk, non }

extension ToppingCharacterExtension on ToppingCharacter {
  static ToppingCharacter? fromType(String? type) {
    if (type == "FULLMILK") {
      return ToppingCharacter.fullMilk;
    } else if (type == "SKIMMILK") {
      return ToppingCharacter.skimMilk;
    } else if (type == "SOYMILK") {
      return ToppingCharacter.soyMilk;
    }
    return null;
  }
}
