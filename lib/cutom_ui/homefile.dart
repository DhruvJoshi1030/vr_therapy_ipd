
import 'package:flutter/widgets.dart';
import 'package:vr_therapy_ipd/design/introanimation/components/intro.dart';
import 'package:vr_therapy_ipd/patient/features/simulation.dart';

class HomeList {
  HomeList({
    this.navigateScreen,
    this.imagePath = '',
  });

  Widget? navigateScreen;
  String imagePath;

  static List<HomeList> homeList = [
    HomeList(
      imagePath: 'assets/introduction_animation/introduction_animation.png',
      navigateScreen: IntroductionAnimationScreen(),
    ),
    HomeList(
      imagePath: 'assets/hotel/hotel_booking.png',
      navigateScreen: VideoListScreen(),
    ),
    HomeList(
      imagePath: 'assets/fitness_app/fitness_app.png',
      navigateScreen: VideoListScreen(),
    ),
    HomeList(
      imagePath: 'assets/design_course/design_course.png',
      navigateScreen: VideoListScreen(),
    ),
  ];
}
