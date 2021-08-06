import 'package:flutter/material.dart';

class MarkerGenerator {
  final OverlayEntry entry;
  // ignore: sort_constructors_first
  MarkerGenerator(this.entry);
  void generate(BuildContext context) {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => afterFirstLayout(context));
  }

  void afterFirstLayout(BuildContext context) {
    addOverlay(context);
  }

  void addOverlay(BuildContext context) {
    var overlayState = Overlay.of(context);
    overlayState.insert(entry);
  }
}

