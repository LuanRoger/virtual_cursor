import 'package:virtual_cursor/src/models/cursor_force.dart';
import 'package:virtual_cursor/virtual_cursor.dart';

void main() async {
  Cursor cursor = Cursor();
  PressingToken token = cursor.pressAndHold(MouseButton.LEFT);
  await cursor.setMultiForce([
    CursorForce(
        force: -50, axis: MouseAxis.Y, button: MouseVariableButton.CURSOR),
    CursorForce(
        force: 50, axis: MouseAxis.X, button: MouseVariableButton.CURSOR),
    CursorForce(
        force: 50, axis: MouseAxis.Y, button: MouseVariableButton.CURSOR),
    CursorForce(
        force: -50, axis: MouseAxis.X, button: MouseVariableButton.CURSOR),
    CursorForce(
        force: -50, axis: MouseAxis.Y, button: MouseVariableButton.CURSOR)
  ], delay: Duration(seconds: 1));
  cursor.release(token);
}
