import 'package:virtual_cursor/src/models/pressing_request.dart';

class PressingToken {
  late PressingRequest _pressingRequest;
  bool get isPressing => _pressingRequest.isPressing;
}

extension PressingTokenInternals on PressingToken {
  PressingRequest getPressingRequest() => _pressingRequest;
  void setPressingRequest(PressingRequest pressingRequest) =>
      _pressingRequest = pressingRequest;
}
