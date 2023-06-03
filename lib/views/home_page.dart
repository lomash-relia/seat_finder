import 'package:flutter/material.dart';
import 'package:seat_finder/views/components/seat_tile.dart';
import 'dart:developer' as devtools show log;

class HomeScreen extends StatefulWidget {
  // final String title;
  final int seatCount;

  const HomeScreen({Key? key, required this.seatCount}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController seatInputController;
  late int selectedSeat;

  @override
  void initState() {
    selectedSeat = 0;
    seatInputController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    seatInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Seat Finder'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              ListTile(
                title: TextField(
                  controller: seatInputController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      if (seatInputController.text.isNotEmpty) {
                        selectedSeat = int.parse(seatInputController.text);
                        devtools.log('home set state called --');
                        devtools.log(selectedSeat.toString());
                        seatInputController.clear();
                      }
                    });
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 4,
                  children: List.generate(widget.seatCount, (index) {
                    devtools.log('from home list view $index --');
                    return SeatTile(
                      seatNo: index + 1,
                      selectedSeat: selectedSeat,
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
