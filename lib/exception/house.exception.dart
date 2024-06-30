class HouseException implements Exception {
  final String code;
  final String message;

  HouseException(this.code, this.message);

  @override
  String toString() {
    return 'HouseException: ($code) $message';
  }
}
