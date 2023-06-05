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
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: BlocBuilder<HomeBloc, HomeState>(
          bloc: homeBloc,
          buildWhen: (previous, current) => current is! HomeActionState,
          builder: (context, state) {
            switch (state.runtimeType) {
              case HomeLoadingState:
                return const Center(child: CircularProgressIndicator());
              case HomeLoadedState:
                final successState = state as HomeLoadedState;
                return Column(
                  children: [
                    ListTile(
                      title: TextField(
                        controller: seatInputController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          hintText: 'Enter Seat Number',
                          label: Icon(Icons.search),
                        ),
                      ),
                      trailing: ElevatedButton(
                        onPressed: () {
                          if (seatInputController.text.isNotEmpty) {
                            selectedSeat = int.parse(seatInputController.text);
                            homeBloc.add(HomeSearchSeatEvent(
                                selectedSeat: selectedSeat));
                            seatInputController.clear();
                          }
                        },
                        child: const Text('Search'),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 3,
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
