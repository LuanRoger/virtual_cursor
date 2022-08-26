import 'package:virtual_cursor/src/models/mouse_input.dart';
import 'package:virtual_cursor/virtual_cursor.dart';

class PressingRequest {
  bool isPressing;
  final MouseInput _mouseInput;
  final MouseButton _button;

  PressingRequest(this._mouseInput, this._button, {required this.isPressing});
  void deconstruct(void Function(MouseInput, MouseButton) deconstructor) =>
      deconstructor(_mouseInput, _button);
}
