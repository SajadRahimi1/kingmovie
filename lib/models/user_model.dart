class UserModel {
  String? name, mobile, token,image;
  Map<String, dynamic> toJson() => {
    'name':name,
    'mobile':mobile,
    'userSalt':token
  };
}
