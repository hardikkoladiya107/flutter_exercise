import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension extOnWidget on Widget {
  Widget get center {
    return Center(
      child: this,
    );
  }

  Widget get safeArea {
    return SafeArea(child: this);
  }

  Widget onClick(GestureTapCallback ontap) {
    return GestureDetector(
      onTap: ontap,
      child: this,
    );
  }

  Widget onTap(GestureTapCallback ontap) {
    return GestureDetector(
      onTap: ontap,
      child: this,
    );
  }

  Widget positioned(
      {double? left, double? right, double? top, double? bottom}) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: this,
    );
  }

  Widget padding({
    double? left,
    double? right,
    double? top,
    double? bottom,
    double? all,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: all ?? left ?? 0,
        right: all ?? right ?? 0,
        top: all ?? top ?? 0,
        bottom: all ?? bottom ?? 0,
      ),
      child: this,
    );
  }
}

extension extOnDynamic on dynamic {
  get debugPrint {
    if (kDebugMode) {
      print("--->(@) ${this.toString()}");
    }
  }

  get printLine {
    if (kDebugMode) {
      print(
          "--------------------------------------------------------------------------------------------->(*)");
    }
  }
}

extension extOnString on String? {
  bool isJson() {
    bool status = false;
    if ((json.decode(this!) is Map)) {
      status = true;
    } else if ((json.decode(this!) is List)) {
      status = true;
    }
    return status;
  }

  bool get isHttpUrl {
    if (this != null && this!.isNotEmpty) {
      return this?.substring(0, 4) == "http";
    }
    return false;
  }

  Widget text(
      {Color? textColor,
      double? fontSize,
      FontWeight? weight,
      TextOverflow? overFlow,
      int? maxLines,
      TextAlign? align,
      FontStyle? style}) {
    return Text(
      this ?? "",
      maxLines: maxLines,
      textAlign: align,
      style: TextStyle(
        overflow: overFlow,
        color: textColor,
        fontSize: fontSize,
        fontStyle: style,
        fontWeight: weight,
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
    );
  }
}

var searchDropDownTextStyle =
    TextStyle(fontFamily: GoogleFonts.roboto().fontFamily, fontSize: 13);
