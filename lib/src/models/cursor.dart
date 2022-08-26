import 'package:ffi/ffi.dart';
import 'package:virtual_cursor/src/enums/mouse_axis.dart';
import 'package:virtual_cursor/src/enums/mouse_button.dart';
import 'package:virtual_cursor/src/enums/mouse_variable_button.dart';
import 'package:virtual_cursor/src/models/cursor_force.dart';
import 'package:virtual_cursor/src/models/pressing_token.dart';
import 'package:virtual_cursor/src/models/mouse_input.dart';
import 'package:virtual_cursor/src/models/pressing_request.dart';
import 'package:virtual_cursor/src/utils/mouse_button_bitmask_converter.dart';
import 'package:win32/win32.dart';
import 'dart:ffi';

///Simulate a mouse/cursor inputs and movements.
class Cursor {
  static const int _INPUT_MOUSE_HARDWARE = INPUT_HARDWARE;

  ///Set force to a variable mouse button.
  ///```force``` - Amount of the movement.
  ///```axis``` - Axis of the movement.
  ///```button``` - Mouse variable button that will be affected by the force.
  void setForce(int force, MouseAxis axis, MouseVariableButton button) {
    Pointer<INPUT> input = calloc<INPUT>();
    ZeroMemory(input, sizeOf<INPUT>());

    input.ref.type = INPUT_MOUSE;
    switch (button) {
      case MouseVariableButton.CURSOR:
        input.ref.mi.dwFlags = MOUSEEVENTF_MOVE;
        switch (axis) {
          case MouseAxis.X:
            input.ref.mi.dx = force;
            break;
          case MouseAxis.Y:
            input.ref.mi.dy = force;
            break;
        }
        break;
      case MouseVariableButton.WHEEL:
        input.ref.mi.dwFlags =
            axis == MouseAxis.Y ? MOUSEEVENTF_WHEEL : MOUSEEVENTF_HWHEEL;
        input.ref.mi.mouseData = force;
        break;
    }
    SendInput(INPUT_KEYBOARD, input, sizeOf<INPUT>());
    free(input);
  }

  ///Set multiple forces to run in sequence.
  ///```List<CursorForce> cursorForces``` - Forces to apply to cursor.
  ///```Duration? delay``` - Define a delay between each ```CursorForce```.
  Future setMultiForce(List<CursorForce> cursorForces,
      {Duration? delay}) async {
    MouseInput mouseInput = MouseInput();
    List<Future> cursorActionList = List.empty(growable: true);

    int increaserMultiplier = 1;
    for (var cursorAction in cursorForces) {
      final Duration interval =
          delay != null ? delay * increaserMultiplier : Duration.zero;

      Future action = Future.delayed(
          interval,
          () => setForce(
              cursorAction.force, cursorAction.axis, cursorAction.button));
      cursorActionList.add(action);
      increaserMultiplier++;
    }

    await Future.wait(cursorActionList);
    mouseInput.dispose();
  }

  ///Simulate a press and release in a mouse button.
  ///```button``` - Mouse button.
  void press(MouseButton button) {
    Pointer<INPUT> input = calloc<INPUT>();
    ZeroMemory(input, sizeOf<INPUT>());

    input.ref.type = INPUT_MOUSE;
    input.ref.mi.dwFlags =
        MouseButtonBitmaskConverter.convertButtonBitmask(button);

    SendInput(INPUT_HARDWARE, input, sizeOf<INPUT>());
    _release(input, button);

    free(input);
  }

  ///Press and hold in a mouse button.
  ///```MouseButton button``` - Mouse button to press.
  ///Return: Return the action reference, use it to release the button.
  PressingToken pressAndHold(MouseButton button) {
    MouseInput mouseInput = MouseInput();

    mouseInput.inputInfo.type = INPUT_MOUSE;
    mouseInput.inputInfo.mi.dwFlags =
        MouseButtonBitmaskConverter.convertButtonBitmask(button);

    SendInput(_INPUT_MOUSE_HARDWARE, mouseInput.rawInput, sizeOf<INPUT>());

    return PressingToken()
      ..setPressingRequest(
          PressingRequest(mouseInput, button, isPressing: true));
  }

  ///Release a holding button using ```PressingToken```.
  ///```PressingToken pressingToken``` - Reference to a ```pressAndHold``` action to be released.
  void release(PressingToken pressingToken) {
    PressingRequest pressingRequest = pressingToken.getPressingRequest();
    pressingRequest
        .deconstruct((dInput, dButton) => _release(dInput.rawInput, dButton));
    pressingRequest.isPressing = false;
  }

  void _release(Pointer<INPUT> input, MouseButton button) {
    input.ref.mi.dwFlags =
        MouseButtonBitmaskConverter.revertConvertButtonBitmask(button);
    SendInput(_INPUT_MOUSE_HARDWARE, input, sizeOf<INPUT>());
  }
}
