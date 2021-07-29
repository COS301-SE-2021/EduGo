class BadResponse implements Exception {
  String reason;
  BadResponse(this.reason);
}