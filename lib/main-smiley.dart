import 'package:flutter/material.dart';
import 'dart:math';
import 'package:collection/collection.dart';

void main() {
  runApp(const ShapesDemoApp());
}

class ShapesDemoApp extends StatefulWidget {
  const ShapesDemoApp({super.key});
  @override
  State<ShapesDemoApp> createState() => _ShapesDemoAppState();
}

Column smiley() {
  return Column(
    children: [
      Text(
        'Smiley Face',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      SizedBox(
        height: 200,
        child: CustomPaint(
          painter: SmileyPainter(),
          size: const Size(double.infinity, 200),
        ),
      ),
    ],
  );
}

Column frowny() {
  return Column(
    children: [
      Text(
        'Frowny Face',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      SizedBox(
        height: 200,
        child: CustomPaint(
          painter: FrownyPainter(),
          size: const Size(double.infinity, 200),
        ),
      ),
    ],
  );
}

Column party() {
  return Column(
    children: [
      Text(
        'Party Face',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 50),
      SizedBox(
        height: 200,
        child: CustomPaint(
          painter: PartyPainter(),
          size: const Size(double.infinity, 200),
        ),
      ),
    ],
  );
}

Column angry() {
  return Column(
    children: [
      Text(
        'Angry Face',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      SizedBox(
        height: 200,
        child: CustomPaint(
          painter: AngryPainter(),
          size: const Size(double.infinity, 200),
        ),
      ),
    ],
  );
}

Column heart() {
  return Column(
    children: [
      Text(
        'Heart Emoji',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 10),
      SizedBox(
        height: 200,
        child: CustomPaint(
          painter: HeartPainter(),
          size: const Size(double.infinity, 200),
        ),
      ),
    ],
  );
}

// Define dropdown menu
typedef IconEntry = DropdownMenuEntry<IconLabel>;

enum IconLabel {
  smiley('Smiley Face', Icons.sentiment_satisfied_outlined),
  frowny('Frowny Face', Icons.sentiment_dissatisfied),
  party('Party Face', Icons.celebration),
  angry('Angry Face', Icons.sentiment_very_dissatisfied),
  heart('Heart', Icons.favorite);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;

  static final List<IconEntry> entries = UnmodifiableListView<IconEntry>(
    values.map<IconEntry>(
      (IconLabel icon) => IconEntry(
        value: icon,
        label: icon.label,
        leadingIcon: Icon(icon.icon),
      ),
    ),
  );
}

class _ShapesDemoAppState extends State<ShapesDemoApp> {
  final TextEditingController iconController = TextEditingController();
  IconLabel? selectedIcon;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shapes Drawing Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(title: const Text('Shapes Drawing Demo')),
        body: Align(
          alignment: AlignmentGeometry.topCenter,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        DropdownMenu<IconLabel>(
                          controller: iconController,
                          enableFilter: false,
                          requestFocusOnTap: true,
                          leadingIcon: Icon(selectedIcon?.icon),
                          label: const Text('Icon'),
                          inputDecorationTheme: const InputDecorationTheme(
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          onSelected: (IconLabel? icon) {
                            setState(() {
                              selectedIcon = icon;
                            });
                          },
                          dropdownMenuEntries: IconLabel.entries,
                        ),
                      ],
                    ),
                  ),
                ),
                if (selectedIcon?.label == 'Smiley Face') smiley(),
                if (selectedIcon?.label == 'Frowny Face') frowny(),
                if (selectedIcon?.label == 'Party Face') party(),
                if (selectedIcon?.label == 'Angry Face') angry(),
                if (selectedIcon?.label == 'Heart') heart(),
                if (selectedIcon == null) const Text('Select an emoji above'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SmileyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.width, size.height) / 2;
    final center = Offset(size.width / 2, size.height / 2);

    // Draw the body
    final bodyPaint = Paint()..color = Colors.yellow;
    canvas.drawCircle(center, radius, bodyPaint);

    // Draw the mouth
    final mouthPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius / 2),
      0,
      pi,
      false,
      mouthPaint,
    );

    // Draw the eyes
    canvas.drawCircle(
      Offset(center.dx - radius / 2.5, center.dy - radius / 2.5),
      10, // size
      Paint(),
    );
    canvas.drawCircle(
      Offset(center.dx + radius / 2.5, center.dy - radius / 2.5),
      10,
      Paint(),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class FrownyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.width, size.height) / 2;
    final center = Offset(size.width / 2, size.height / 2);
    final mouthOffset = Offset(size.width / 2, size.height / 1.4);

    // Draw the body
    final bodyPaint = Paint()..color = Colors.yellow;
    canvas.drawCircle(center, radius, bodyPaint);

    // Draw the frowny mouth
    final mouthPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    canvas.drawArc(
      Rect.fromCircle(center: mouthOffset, radius: radius / 2),
      pi,
      pi,
      false,
      mouthPaint,
    );

    // Draw the eyes
    canvas.drawCircle(
      Offset(center.dx - radius / 2.5, center.dy - radius / 2.5),
      10, // size
      Paint(),
    );
    canvas.drawCircle(
      Offset(center.dx + radius / 2.5, center.dy - radius / 2.5),
      10,
      Paint(),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class PartyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.width, size.height) / 2.25;
    final center = Offset(size.width / 2, size.height / 2);

    // Draw the body
    final bodyPaint = Paint()..color = Colors.yellow;
    canvas.drawCircle(center, radius, bodyPaint);

    // Draw the mouth
    final mouthPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius / 1.8),
      0,
      pi,
      false,
      mouthPaint,
    );

    // Draw the eyes
    canvas.drawCircle(
      Offset(center.dx - radius / 2.5, center.dy - radius / 2.5),
      10, // size
      Paint(),
    );
    canvas.drawCircle(
      Offset(center.dx + radius / 2.5, center.dy - radius / 2.5),
      10,
      Paint(),
    );

    // Draw the party hat
    // Define gradient
    final hatGradient = RadialGradient(
      center: Alignment.center,
      radius: 0.75,
      colors: [Colors.red, Colors.red, Colors.purple],
    );
    // Define painter
    final hatPaint = Paint()
      ..shader = hatGradient.createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );
    // Define path
    final hatPath = Path()
      ..moveTo(center.dx - 50, center.dy - 70) // bottom left point
      ..lineTo(center.dx + 40, center.dy - 70) // bottom right point
      ..lineTo(center.dx - 20, center.dy - 150) // top point
      ..close();
    canvas.drawPath(hatPath, hatPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class HeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;

    final outlinePaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final dim = min(size.width, size.height);
    final cx = size.width / 2;
    final cy = size.height / 2;

    final r = dim / 4; 
    final bottomY = cy + r * 2; 
    final notchY = cy - r * 0.6; 

    final path = Path();

    path.moveTo(cx, bottomY);

    // Left lobe 
    path.cubicTo(
      cx - r * 2, cy + r,   
      cx - r * 2, cy - r,  
      cx, notchY,         
    );

    // Right lobe 
    path.cubicTo(
      cx + r * 2, cy - r,  
      cx + r * 2, cy + r,   
      cx, bottomY,          
    );

    path.close();

    // Draw heart
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, outlinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}


class AngryPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.width, size.height) / 2;
    final center = Offset(size.width / 2, size.height / 2);

    // Face
    final facePaint = Paint()..color = Colors.red;
    canvas.drawCircle(center, radius, facePaint);

    // Angry mouth
    final mouthPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..color = Colors.black;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(center.dx, center.dy + radius * 0.25),
        width: radius,
        height: radius,
      ),
      pi,
      pi,
      false,
      mouthPaint,
    );

    // Eyes
    final eyePaint = Paint()..color = Colors.black;
    final leftEye = Offset(center.dx - radius / 2, center.dy - radius / 3);
    final rightEye = Offset(center.dx + radius / 2, center.dy - radius / 3);
    canvas.drawCircle(leftEye, 10, eyePaint);
    canvas.drawCircle(rightEye, 10, eyePaint);

    // Eyebrows (angled lines)
    final browPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
      Offset(leftEye.dx - 15, leftEye.dy - 20), // outer edge
      Offset(leftEye.dx + 15, leftEye.dy - 10), // inner edge
      browPaint,
    );

    canvas.drawLine(
      Offset(rightEye.dx - 15, rightEye.dy - 10), // inner edge
      Offset(rightEye.dx + 15, rightEye.dy - 20), // outer edge
      browPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class BasicShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Determine the center of the canvas
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final squareOffset = Offset(centerX - 80, centerY);
    final circleOffset = Offset(centerX, centerY);
    final arcOffset = Offset(centerX + 80, centerY);
    final rectOffset = Offset(centerX - 160, centerY);
    final lineStart = Offset(centerX - 200, centerY - 50);
    final lineEnd = Offset(centerX - 140, centerY + 50);
    final ovalOffset = Offset(centerX + 160, centerY);
    // Draw a square
    final squarePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromCenter(center: squareOffset, width: 60, height: 60),
      squarePaint,
    );
    // Draw a circle
    final circlePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(circleOffset, 30, circlePaint);
    // Draw an arc
    final arcPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    canvas.drawArc(
      Rect.fromCenter(center: arcOffset, width: 60, height: 60),
      0, // start angle in radians
      2.1, // sweep angle in radians (about 120 degrees)
      false, // whether to use center
      arcPaint,
    );
    // Draw a rectangle
    final rectPaint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromCenter(center: rectOffset, width: 80, height: 40),
      rectPaint,
    );
    // Draw a line
    final linePaint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 3;
    canvas.drawLine(lineStart, lineEnd, linePaint);
    // Draw an oval
    final ovalPaint = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(center: ovalOffset, width: 80, height: 40),
      ovalPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class CombinedShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    // Background gradient
    final backgroundGradient = RadialGradient(
      center: Alignment.center,
      radius: 0.8,
      colors: [Colors.blue.shade100, Colors.white],
    );
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..shader = backgroundGradient.createShader(
          Rect.fromLTWH(0, 0, size.width, size.height),
        ),
    );
    // Draw a sun (circle with rays)
    final sunPaint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX, centerY - 40), 40, sunPaint);
    // Sun rays (lines)
    final rayPaint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 3;
    for (int i = 0; i < 8; i++) {
      final angle = i * (pi / 4); // Use pi from dart:math
      final dx = cos(angle) * 60;
      final dy = sin(angle) * 60;
      canvas.drawLine(
        Offset(centerX, centerY - 40),
        Offset(centerX + dx, centerY - 40 + dy),
        rayPaint,
      );
    }
    // Draw a house (square with triangle roof)
    final housePaint = Paint()
      ..color = Colors.brown
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(centerX, centerY + 40),
        width: 80,
        height: 80,
      ),
      housePaint,
    );
    final roofPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    final roofPath = Path()
      ..moveTo(centerX - 60, centerY)
      ..lineTo(centerX + 60, centerY)
      ..lineTo(centerX, centerY - 60)
      ..close();
    canvas.drawPath(roofPath, roofPaint);
    // Draw a door (rectangle)
    final doorPaint = Paint()
      ..color = Colors.blueGrey
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(centerX, centerY + 60),
        width: 30,
        height: 50,
      ),
      doorPaint,
    );
    // Draw windows (squares)
    final windowPaint = Paint()
      ..color = Colors.blue.shade200
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(centerX - 25, centerY + 20),
        width: 20,
        height: 20,
      ),
      windowPaint,
    );
    canvas.drawRect(
      Rect.fromCenter(
        center: Offset(centerX + 25, centerY + 20),
        width: 20,
        height: 20,
      ),
      windowPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class StyledShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    // Draw a gradient-filled rectangle
    final rectGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Colors.red, Colors.blue],
    );
    final rect = Rect.fromCenter(
      center: Offset(centerX, centerY - 100),
      width: 200,
      height: 60,
    );
    canvas.drawRect(
      rect,
      Paint()
        ..shader = rectGradient.createShader(rect)
        ..style = PaintingStyle.fill,
    );
    // Draw a circle with a border
    final circlePaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    final circleBorderPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(Offset(centerX - 80, centerY), 40, circlePaint);
    canvas.drawCircle(Offset(centerX - 80, centerY), 40, circleBorderPaint);
    // Draw a transparent oval
    final ovalPaint = Paint()
      ..color = Colors.purple.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(centerX + 80, centerY),
        width: 100,
        height: 60,
      ),
      ovalPaint,
    );
    // Draw a dashed line using a custom path effect
    final dashPaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    // We draw a series of short lines and spaces
    final path = Path();
    double startX = centerX - 100;
    const dashLength = 10.0;
    const spaceLength = 5.0;
    while (startX < centerX + 100) {
      path.moveTo(startX, centerY + 80);
      path.lineTo(min(startX + dashLength, centerX + 100), centerY + 80);
      startX += dashLength + spaceLength;
    }
    canvas.drawPath(path, dashPaint);
    // Draw a gradient arc
    final arcGradient = SweepGradient(
      center: Alignment.centerRight,
      startAngle: 0,
      endAngle: pi, // Use pi from dart:math
      colors: [Colors.red, Colors.yellow, Colors.green],
    );
    final arcRect = Rect.fromCenter(
      center: Offset(centerX, centerY + 100),
      width: 120,
      height: 120,
    );
    final arcPaint = Paint()
      ..shader = arcGradient.createShader(arcRect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(centerX, centerY + 100),
        width: 100,
        height: 100,
      ),
      0, // start angle
      2.5, // sweep angle
      false,
      arcPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
