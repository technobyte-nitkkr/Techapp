class AppException implements Exception {
  final message;
  final int? code;
  AppException([this.message, this.code]);
  String toString() {
    return "$message:$code";
  }
}
