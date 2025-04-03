class Validators {
  static String? mandatoryField(String? text) {
    if (text == '' || text == null) {
      return 'Mandatory field!';
    } else {
      return null;
    }
  }
}