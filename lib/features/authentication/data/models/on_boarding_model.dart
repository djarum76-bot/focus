import 'package:focus/features/authentication/domain/entities/on_boarding.dart';

class OnBoardingModel extends OnBoarding{
  OnBoardingModel({required super.title, required super.description});

  OnBoardingModel copyWith({
    String? title,
    String? description,
  }) =>
      OnBoardingModel(
        title: title ?? this.title,
        description: description ?? this.description,
      );
}

final onBoardingPages = <OnBoardingModel>[
  OnBoardingModel(
    title: "Your Ultimate Pomodoro Productivity Assistant",
    description: "Focus help you stay on track, manage tasks, and work efficiently. Let's get started with Focus right now!"
  ),
  OnBoardingModel(
      title: "Effortless Organization - All in One Place",
      description: "Easily categorize your work, stay organized, and conquer tasks with Focus's intuitive project and tag system."
  ),
  OnBoardingModel(
    title: "Track Your Progress & Visualize Your Success",
    description: "Track your productivity over time, gain insights, and level up your efficiency. It's time to achieve your goals."
  ),
];