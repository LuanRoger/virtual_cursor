import 'package:virtual_cursor/virtual_cursor.dart';

///Define informations about cursor movement to be applied in ```Cursor.setMultiForce```.
class CursorForce {
  ///Amount of the movement.
  int force;
  ///Axis of the force.
  MouseAxis axis;
  ///Variable mouse button where the force will be applied.
  MouseVariableButton button;

  CursorForce({required this.force, required this.axis, required this.button});
}
