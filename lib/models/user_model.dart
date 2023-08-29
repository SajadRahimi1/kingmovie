class UserModel {
  String? name, mobile, token;
  Map<String, dynamic> toJson() => {
    'name':name,
    'mobile':mobile,
    'userSalt':token
  };
}
