import 'dart:math';

import 'package:flutter/material.dart';

class ClockPainter extends CustomPainter {
  Color circleColor1;
  Color circleColor2;
  Color circleColor3;
  Color circleColor4;
  Color circleColor5;
  Color borderColor;
  Color hoursTickColor;
  Color minutesTickColor;
  Color hoursNeedleColor;
  Color minutesNeedleColor;
  Color secondsNeedleColor;
  DateTime now;
  String textInClock;

  ClockPainter(
      {required this.now,
      this.circleColor1 = Colors.black,
      this.circleColor2 = Colors.red,
      this.circleColor3 = Colors.amber,
      this.circleColor4 = Colors.red,
      this.circleColor5 = Colors.black,
      this.borderColor = Colors.black,
      this.hoursTickColor = Colors.white,
      this.minutesTickColor = Colors.grey,
      this.hoursNeedleColor = Colors.white,
      this.minutesNeedleColor = Colors.black,
      this.secondsNeedleColor = Colors.teal,
      this.textInClock = ""});

  @override
  void paint(Canvas canvas, Size size) {
    final Size(:width, :height) = size;
    final radius = min(width, height) / 2;
    final center = Offset(width / 2, height / 2);
    final borderRadius = radius + 3;

    //hour and minute tick length and width
    final hoursTickLength = radius * 0.15;
    final hoursTickwidth = radius * 0.05;
    final minutesTickLength = radius * 0.1;
    final minutesTickWidth = radius * 0.025;

    // // hour and minute tick in circle radius
    // final hourTickRadius = radius * 0.04;
    // final secondTickRadius = radius * 0.02;

    //hour  and minute , seconds needle base radius
    final hoursNeedleBaseRadius = radius * 0.2;
    final minutesNeedleBaseRadius = radius * 0.15;
    final secondsNeedleBaseRadius = radius * 0.09;

    //hour and minute needle length and width
    final hoursNeedleLength = radius * 0.7;
    final minutesNeedleLength = radius * 0.8;
    final secondsNeedleLength = radius * 0.8;
    final secondsNeedleWidth = radius * 0.04;
    final hoursNeedleWidth = radius * 0.07;
    final minutesNeedleWidth = radius * 0.06;

    //text
    var numbers = [
      "12",
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
      '10',
      '11'
    ];
    const roman = [
      "XII",
      'I',
      'II',
      'III',
      'IV',
      'V',
      'VI',
      'VII',
      'VIII',
      'IX',
      'X',
      'XI'
    ];

    //clock paint
    final clockPaint = Paint()
      ..shader = RadialGradient(colors: [
        circleColor1,
        circleColor2,
        circleColor3,
        circleColor4,
        circleColor5
      ], stops: const [
        0.2,
        0.4,
        0.6,
        0.8,
        1
      ]).createShader(Rect.fromLTWH(0, 0, width, height));
    //border paint
    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    //hours tick paint
    final hoursTickPaint = Paint()
      ..color = hoursTickColor
      ..strokeWidth = hoursTickwidth;
    //minute tick paint
    final minutesTickPaint = Paint()
      ..color = minutesTickColor
      ..strokeWidth = minutesTickWidth;

    //hour base and needle paint
    final hoursNeedlePaint = Paint()
      ..color = hoursNeedleColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = hoursNeedleWidth;
    //minute  base  and  needle paint
    final minutesNeedlePaint = Paint()
      ..color = minutesNeedleColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = minutesNeedleWidth;
    //seconds  base  and  needle paint
    final secondsNeedlePaint = Paint()
      ..color = secondsNeedleColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = secondsNeedleWidth;

    //draw clock
    canvas.drawCircle(center, radius, clockPaint);
    //draw border of clock
    canvas.drawCircle(center, borderRadius, borderPaint);
    //draw hour  needle base
    canvas.drawCircle(center, hoursNeedleBaseRadius, hoursNeedlePaint);
    //draw minute needle  base
    canvas.drawCircle(center, minutesNeedleBaseRadius, minutesNeedlePaint);
    //draw second needle  base
    canvas.drawCircle(center, secondsNeedleBaseRadius, secondsNeedlePaint);

    //text  painter
    TextSpan textSpan = TextSpan(text: textInClock);
    TextPainter textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, center);

    // now make ticks in clock
    //first rotate the origin  from topleft to center
    canvas.translate(center.dx, center.dy);
    //save each layer
    canvas.save();

    //rotate at every angle
    const angle = 2 * pi / 60;
    for (var i = 0; i < 60; i++) {
      var isHour = i % 5 == 0;
      // we can also use conditional statement instead of if else
      canvas.drawLine(
          Offset(0, -radius),
          Offset(0, -radius + (isHour ? hoursTickLength : minutesTickLength)),
          isHour ? hoursTickPaint : minutesTickPaint);

      // if (isHour) {
      //   canvas.drawCircle(Offset(0, -radius),Offset(0, -radius + hoursTickLength), , hoursTickPaint);
      // } else {
      //   canvas.drawLine(Offset(0, -radius),
      //       Offset(0, -radius + minutesTickLength), minutesTickPaint);
      // }
      //tick shape in  circle
      // if (isHour) {
      //   canvas.drawCircle(Offset(0, -radius), hourTickRadius, hoursTickPaint);
      // } else {
      //   canvas.drawCircle(
      //       Offset(0, -radius), secondTickRadius, minutesTickPaint);
      // }

      // draw seconds needle
      if (now.second == i) {
        canvas.drawLine(Offset(0, -secondsNeedleBaseRadius),
            Offset(0, -secondsNeedleLength), secondsNeedlePaint);
      }

      // draw minute needle
      if (now.minute == i) {
        canvas.drawLine(Offset(0, -minutesNeedleBaseRadius),
            Offset(0, -minutesNeedleLength), minutesNeedlePaint);
      }
      // draw hour needle
      if ((now.hour % 12) * 5 == i) {
        canvas.drawLine(Offset(0, -hoursNeedleBaseRadius),
            Offset(0, -hoursNeedleLength), hoursNeedlePaint);
      }
      //rotate canvas at every angle
      canvas.rotate(angle);
    }
    //restore each layer
    canvas.restore();
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) => oldDelegate.now != now;
}
