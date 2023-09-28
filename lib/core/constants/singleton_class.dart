import 'package:king_movie/models/home_model.dart';
import 'package:media_kit_video/media_kit_video.dart';

class SingletonClass {
  // Private constructor
  SingletonClass._();

  // Singleton instance
  static final SingletonClass _instance = SingletonClass._();

  // Public getter to get instance
  static SingletonClass get instance => _instance;

  User? user;

  SubtitleViewConfiguration subtitleViewConfiguration =
      SubtitleViewConfiguration();

}
