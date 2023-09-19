class SignupModel {
  String? email, mobile, name, password, repassword;

  Map<String, dynamic> toJson() => {
    "email":email,
    "mobile":mobile,
    "name":name,
    "password":password,
    "repassword":repassword
  };
}
