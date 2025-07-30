class Validator {
  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) return '请输入姓名';
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return '请输入用户名/邮箱';
    if (!value.contains('@')) return '请输入有效邮箱';
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.length < 6) return '密码至少6位';
    return null;
  }
}
