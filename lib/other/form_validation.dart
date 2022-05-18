class FormValidation {

  static bool isEmail(String email){
    Pattern  pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern.toString());
    return regExp.hasMatch(email);
  }

  static bool isName(String name){
    Pattern  pattern = r'^[a-zA-Z0-9]+$';
    RegExp regExp = RegExp(pattern.toString());
    return regExp.hasMatch(name);
  }

  static bool isMobile(String mobile){
    Pattern  pattern = r'070+[0-9]{0}\d{7}|071+[0-9]{0}\d{7}|072+[0-9]{0}\d{7}|074+[0-9]{0}\d{7}|075+[0-9]{0}\d{7}|076+[0-9]{0}\d{7}|077+[0-9]{0}\d{7}|078+[0-9]{0}\d{7}';
    RegExp regExp = RegExp(pattern.toString());
    return regExp.hasMatch(mobile);
  }

}