import 'enum.dart';

class ViewStatus {
  ViewState state;
  String _error;
  String successMsg;
  String loadingMsg;
  Function()? onRetry;
  String? retryButtonText;

  String get error => _error;

  set error(String? val) {
    _error = exceptionString(val ?? "");
  }

  ViewStatus({
    this.state = ViewState.READY,
    String error = "",
    this.onRetry,
    this.successMsg = "",
    this.loadingMsg = "",
  }) : _error =exceptionString(error);

 static  String exceptionString(String st) {
    return st.replaceFirst("Exception: ", "");
  }
}
