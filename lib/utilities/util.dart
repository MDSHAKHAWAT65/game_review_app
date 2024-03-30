class Util {
  static String errorsToString(Map errors) {
    String s = '';
    for (var v in errors.values) {
      s += v[0] + '\n';
    }
    return s;
  }
}
