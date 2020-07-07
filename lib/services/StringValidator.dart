abstract class StringValidator {

  bool isValid(String mText);
}

class NotEmptyString implements StringValidator {
  @override
  bool isValid(String mText) {
    return mText.isNotEmpty;
  }

}
class EmailPasswordValidator{

  final StringValidator emailValidator = NotEmptyString();
  final StringValidator passwordValidator = NotEmptyString();
  final String invalidEmailMsg = " Email can\'t be empty.";
  final String invalidPasswordMsg = "Password can\'t be empty.";
}