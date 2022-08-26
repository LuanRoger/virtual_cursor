import 'package:virtual_cursor/src/models/pressing_request.dart';

///Reference to a pressing and hold action on cursor.
///Use it to release the button.
class PressingToken {
  late PressingRequest _pressingRequest;
  ///Return ```true``` if the button is still being pressed, otherwise ```false```.
  bool get isPressing => _pressingRequest.isPressing;
}

extension PressingTokenInternals on PressingToken {
  PressingRequest getPressingRequest() => _pressingRequest;
  void setPressingRequest(PressingRequest pressingRequest) =>
      _pressingRequest = pressingRequest;
}
