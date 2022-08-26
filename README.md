# virtual_cursor
### Control the cursor via Win32 API.

## Features
- Simulate cursor moves.
- Press and hold mouse buttons.
- Create complex moves with ```MultiForce```

## Dependencies
- [win32](https://pub.dev/packages/win32)
- [ffi](https://pub.dev/packages/ffi)

## Examples
This simple example shows how to move the cursor and press a mouse button.
```dart
import 'package:virtual_cursor/virtual_cursor.dart';

void main() {
  Cursor cursor = Cursor();
  cursor.setForce(10, MouseAxis.X, MouseVariableButton.CURSOR);
  cursor.press(MouseButton.LEFT);
}
```
This example shows how to create complex cursor moves with ```MultiForce```.
```dart
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
```
## Documentation
> Soon