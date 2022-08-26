import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

class MouseInput {
  late Pointer<INPUT> _input;
  Pointer<INPUT> get rawInput => _input;
  INPUT get inputInfo => _input.ref;

  MouseInput() {
    _input = calloc<INPUT>();
    ZeroMemory(_input, sizeOf<INPUT>());
    _input.ref.type = INPUT_MOUSE;
  }

  void dispose() {
    ZeroMemory(_input, sizeOf<INPUT>());
    free(_input);
  }
}
