import 'package:paynote_app/Api/Data.dart';
import 'package:paynote_app/utils/serverError.dart';
import 'package:paynote_app/Api/BResponse.dart';

class BaseModel<BResponse> {
  ServerError _error;
  BResponse data;
  Data responseObject;

  setException(ServerError error) {
    _error = error;
  }

  setData(Data data) {
    //handle all local error codes here
    this.data =data as BResponse;
  }

  get getException {
    return _error;
  }
}