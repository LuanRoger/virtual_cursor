import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

class CursorPosition {
  final int x;
  final int y;

  CursorPosition(this.x, this.y);

  factory CursorPosition.fromCurrentPosition() {
    final Pointer<POINT> point = calloc<POINT>();
    GetCursorPos(point);
    final int x = point.ref.x;
    final int y = point.ref.y;
    free(point);
    return CursorPosition(x, y);
  }
}