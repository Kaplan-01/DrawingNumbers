import 'package:flutter/material.dart';
import 'constants.dart';

class painter extends CustomPainter{
  painter({this.offsetPoints});
  List<Offset> offsetPoints;
  @override
  void paint(Canvas canvas, Size size) {
    for(int i =0 ; i < this.offsetPoints.length-1;i++){
      if(offsetPoints[i] != null && offsetPoints[i+1]!= null){
        canvas.drawLine(offsetPoints[i], offsetPoints[i+1], kDrawingPaint);

      }

    }
    // TODO: implement paint
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true ;


}