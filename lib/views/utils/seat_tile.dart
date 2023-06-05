import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

class SeatTile extends StatefulWidget {
  final int seatNo;
  final int selectedSeat;

  const SeatTile({Key? key, required this.seatNo, required this.selectedSeat})
      : super(key: key);

  @override
  State<SeatTile> createState() => _SeatTileState();
}

class _SeatTileState extends State<SeatTile> {
  bool isSelected = false;

  late String seatType;

  void calculateSeatType(int seatNo) {
    int seatTypeNumber = seatNo % 8;

    if (seatTypeNumber == 1 || seatTypeNumber == 4) {
      seatType = 'Lower';
    } else if (seatTypeNumber == 2 || seatTypeNumber == 5) {
      seatType = 'Middle';
    } else if (seatTypeNumber == 3 || seatTypeNumber == 6) {
      seatType = 'Upper';
    } else if (seatTypeNumber == 7) {
      seatType = 'Side Lower';
    } else if (seatTypeNumber == 0) {
      seatType = 'Side Upper';
    }
  }

  @override
  void initState() {
    calculateSeatType(widget.seatNo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isSelected = false;
    if (widget.seatNo == widget.selectedSeat) {
      devtools.log('seat tile build called --');
      devtools.log(widget.selectedSeat.toString());
      setState(() {
        isSelected = true;
      });
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.white,
          border: Border.all(
            width: 3,
          ),
          borderRadius: BorderRadius.circular(13),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              (widget.seatNo).toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 19,
              ),
            ),
            Text(
              seatType,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.blue,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
