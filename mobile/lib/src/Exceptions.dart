class BadResponse implements Exception {
  String reason;
  BadResponse(this.reason);
}

class NoToken implements Exception {
  String reason = 'Missing Token';
}