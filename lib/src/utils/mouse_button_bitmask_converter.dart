import 'package:virtual_cursor/src/enums/mouse_button.dart';
import 'package:win32/win32.dart';

class MouseButtonBitmaskConverter {
  static int convertButtonBitmask(MouseButton button) {
    switch (button) {
      case MouseButton.LEFT:
        return MOUSEEVENTF_LEFTDOWN;
      case MouseButton.RIGHT:
        return MOUSEEVENTF_RIGHTDOWN;
      case MouseButton.WHEEL:
        return MOUSEEVENTF_MIDDLEDOWN;
    }
  }

  static int revertConvertButtonBitmask(MouseButton button) {
    switch (button) {
      case MouseButton.LEFT:
        return MOUSEEVENTF_LEFTUP;
      case MouseButton.RIGHT:
        return MOUSEEVENTF_RIGHTUP;
      case MouseButton.WHEEL:
        return MOUSEEVENTF_MIDDLEUP;
    }
  }
}
