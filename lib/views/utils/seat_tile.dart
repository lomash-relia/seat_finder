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
    if (seatNo % 8 == 7) {
      seatType = 'Side Lower';
    } else if (seatNo % 8 == 0) {
      seatType = 'Side Upper';
    } else if (seatNo % 4 == 1 || seatNo % 4 == 0) {
      seatType = 'Lower';
    } else if (seatNo % 2 == 0) {
      seatType = 'Middle';
    } else if (seatNo % 4 == 3 || seatNo % 4 == 2) {
      seatType = 'Upper';
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
                color: isSelected ? Colors.red : Colors.blue[700],
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
            Text(
              seatType,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: isSelected ? Colors.red : Colors.blue[700],
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
