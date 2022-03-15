import 'package:flutter/material.dart';

class SheetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 60.0;
    double topRadius = 15.0;
    var controlPoint = Offset(size.width / 2, 0);
    var endPoint = Offset(size.width - radius, topRadius);

    Path path = Path()
      ..moveTo(0, radius + topRadius)
      ..arcToPoint(Offset(radius, topRadius), radius: Radius.circular(radius))
      ..quadraticBezierTo(
          controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..arcToPoint(Offset(size.width, radius + topRadius),
          radius: Radius.circular(radius))
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 40.0;
    double topRadius = 10.0;
    var controlPoint = Offset(size.width / 2, 0);
    var endPoint = Offset(size.width - radius, topRadius);

    var controlPoint2 = Offset(size.width / 2, size.height - topRadius);
    var endPoint2 = Offset(radius, size.height);

    Path path = Path()
      ..moveTo(0, radius + topRadius)
      ..arcToPoint(Offset(radius, topRadius), radius: Radius.circular(radius))
      ..quadraticBezierTo(
          controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..arcToPoint(Offset(size.width, radius + topRadius),
          radius: Radius.circular(radius))
      ..lineTo(size.width, size.height - radius)
      ..arcToPoint(Offset(size.width - radius, size.height),
          radius: Radius.circular(radius))
      ..quadraticBezierTo(
          controlPoint2.dx, controlPoint2.dy, endPoint2.dx, endPoint2.dy)
      ..arcToPoint(Offset(0, size.height - radius),
          radius: Radius.circular(radius))
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ReceiptClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 10.0;
    double topRadius = 5.0;
    var controlPointTL = Offset(radius, radius);
    var endPointTL = Offset(radius, 0);

    var controlPointTP = Offset(size.width - radius, radius);
    var endPointTP = Offset(size.width, radius);

    var controlPointBR = Offset(size.width - radius, size.height - radius);
    var endPointBR = Offset(size.width - radius, size.height);

    var controlPointBL = Offset(radius, size.height - radius);
    var endPointBL = Offset(0, size.height - radius);

    Path path = Path()
      ..moveTo(0, radius)
      ..quadraticBezierTo(
          controlPointTL.dx, controlPointTL.dy, endPointTL.dx, endPointTL.dy)
      ..lineTo(size.width - radius, 0)
      ..quadraticBezierTo(
          controlPointTP.dx, controlPointTP.dy, endPointTP.dx, endPointTP.dy)
      ..lineTo(size.width, size.height - radius)
      ..quadraticBezierTo(
          controlPointBR.dx, controlPointBR.dy, endPointBR.dx, endPointBR.dy)
      ..lineTo(radius, size.height)
      ..quadraticBezierTo(
          controlPointBL.dx, controlPointBL.dy, endPointBL.dx, endPointBL.dy)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class AddButtonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 20.0;
    double distance = 4.0;

    Path path = Path()
      ..moveTo(0, radius)
      ..arcToPoint(Offset(radius, 0), radius: Radius.circular(radius))
      ..lineTo(size.width - radius, distance)
      ..arcToPoint(Offset(size.width, radius + distance),
          radius: Radius.circular(radius))
      ..lineTo(size.width, size.height - radius)
      ..arcToPoint(Offset(size.width - radius, size.height),
          radius: Radius.circular(radius))
      ..lineTo(radius, size.height - distance)
      ..arcToPoint(Offset(0, size.height - radius),
          radius: Radius.circular(radius))
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class DecreaseButtonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 20.0;
    double distance = 4.0;

    Path path = Path()
      ..moveTo(0, radius + distance)
      ..arcToPoint(Offset(radius, distance), radius: Radius.circular(radius))
      ..lineTo(size.width - radius, 0)
      ..arcToPoint(Offset(size.width, radius + distance),
          radius: Radius.circular(radius))
      ..lineTo(size.width, size.height - radius - distance)
      ..arcToPoint(Offset(size.width - radius, size.height - distance),
          radius: Radius.circular(radius))
      ..lineTo(radius, size.height)
      ..arcToPoint(Offset(0, size.height - radius),
          radius: Radius.circular(radius))
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class FabClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double radius = 15.0;
    var controlPoint1 = Offset(size.width - radius, size.height - radius);
    var controlPoint2 = Offset(radius, size.height - radius);
    var endPoint1 = Offset(size.width, size.height);
    var endPoint2 = Offset(radius, size.height / 2);

    Path path = Path()
      ..moveTo(radius, size.height / 2)
      ..arcToPoint(Offset(size.width - radius, size.height / 2),
          radius: Radius.circular(radius))
      ..quadraticBezierTo(
          controlPoint1.dx, controlPoint1.dy, endPoint1.dx, endPoint1.dy)
      ..lineTo(0, size.height)
      ..quadraticBezierTo(
          controlPoint2.dx, controlPoint2.dy, endPoint2.dx, endPoint2.dy)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
