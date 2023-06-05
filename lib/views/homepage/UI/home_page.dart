import 'package:flutter/material.dart';
import 'package:seat_finder/views/utils/seat_tile.dart';
import 'dart:developer' as devtools show log;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seat_finder/views/homepage/bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  final int seatCount;

  const HomeScreen({Key? key, required this.seatCount}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeBloc homeBloc = HomeBloc();
  late final TextEditingController seatInputController;
  late int selectedSeat;

  @override
  void initState() {
    seatInputController = TextEditingController();
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  void dispose() {
    seatInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seat Finder'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: BlocConsumer<HomeBloc, HomeState>(
          bloc: homeBloc,
          listenWhen: (previous, current) => current is HomeActionState,
          buildWhen: (previous, current) => current is! HomeActionState,
          listener: (context, state) {
            if (state is HomeShowSnackBarState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please Enter Valid Seat Number')),
              );
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case HomeLoadingState:
                return const Center(child: CircularProgressIndicator());
              case HomeLoadedState:
                final successState = state as HomeLoadedState;
                final widthValue = MediaQuery.of(context).size.width;
                int count = 4;
                if (widthValue > 450) {
                  count = 6;
                  if (widthValue > 800) {
                    count = 8;
                  }
                }
                return Column(
                  children: [
                    ListTile(
                      title: TextField(
                        controller: seatInputController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Enter Seat Number...',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          if (seatInputController.text.isNotEmpty) {
                            selectedSeat = int.parse(seatInputController.text);
                            if (selectedSeat >= 0 && selectedSeat <= 72) {
                              homeBloc.add(HomeSearchSeatEvent(
                                  selectedSeat: selectedSeat));
                            } else {
                              homeBloc.add(HomeInvalidSeatEvent());
                              seatInputController.clear();
                            }
                          }
                        },
                        child: const Text('Find'),
                      ),
                    ),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: count,
                        children: List.generate(widget.seatCount, (index) {
                          devtools.log('from home list view $index --');
                          return SeatTile(
                            seatNo: index + 1,
                            selectedSeat: successState.selectedSeat,
                          );
                        }),
                      ),
                    ),
                  ],
                );
              case HomeErrorState:
                return const Text('Errors');
              default:
                return const Text('default');
            }
          },
        ),
      ),
    );
  }
}
