import 'package:flutter/material.dart';
import 'colors.dart';
import 'spacing.dart';

// Modern Border Radius
const double borderRadiusSmall = 8.0;
const double borderRadiusMedium = 12.0;
const double borderRadiusLarge = 16.0;
const double borderRadiusExtraLarge = 24.0;

// Modern Elevation
const double elevationLow = 2.0;
const double elevationMedium = 4.0;
const double elevationHigh = 8.0;
const double elevationMax = 16.0;

// Modern Shapes
const RoundedRectangleBorder cardShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(borderRadiusMedium)),
);

const RoundedRectangleBorder buttonShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(borderRadiusMedium)),
);

const RoundedRectangleBorder chipShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(borderRadiusExtraLarge)),
);

const RoundedRectangleBorder dialogShape = RoundedRectangleBorder(
  borderRadius: BorderRadius.all(Radius.circular(borderRadiusLarge)),
);

// Modern Box Shadows
const List<BoxShadow> cardShadow = [
  BoxShadow(
    color: shadowLight,
    offset: Offset(0, 1),
    blurRadius: 3,
    spreadRadius: 0,
  ),
  BoxShadow(
    color: shadowMedium,
    offset: Offset(0, 1),
    blurRadius: 2,
    spreadRadius: 0,
  ),
];

const List<BoxShadow> elevatedShadow = [
  BoxShadow(
    color: shadowMedium,
    offset: Offset(0, 2),
    blurRadius: 8,
    spreadRadius: 0,
  ),
  BoxShadow(
    color: shadowLight,
    offset: Offset(0, 1),
    blurRadius: 4,
    spreadRadius: 0,
  ),
];

const List<BoxShadow> buttonShadow = [
  BoxShadow(
    color: shadowLight,
    offset: Offset(0, 1),
    blurRadius: 2,
    spreadRadius: 0,
  ),
];

// Modern Input Decoration
const InputDecoration modernInputDecoration = InputDecoration(
  filled: true,
  fillColor: gray50,
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(borderRadiusMedium)),
    borderSide: BorderSide(color: gray300, width: 1),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(borderRadiusMedium)),
    borderSide: BorderSide(color: gray300, width: 1),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(borderRadiusMedium)),
    borderSide: BorderSide(color: primaryBlue, width: 2),
  ),
  errorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(borderRadiusMedium)),
    borderSide: BorderSide(color: errorRed, width: 1),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(borderRadiusMedium)),
    borderSide: BorderSide(color: errorRed, width: 2),
  ),
  contentPadding: EdgeInsets.symmetric(
    horizontal: space16,
    vertical: space12,
  ),
);