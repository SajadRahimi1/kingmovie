import 'package:king_movie/models/home_model.dart';

class SingletonClass {
  // Private constructor
  SingletonClass._();

  // Singleton instance
  static final SingletonClass _instance = SingletonClass._();

  // Public getter to get instance
  static SingletonClass get instance => _instance;


  User? user;
}
