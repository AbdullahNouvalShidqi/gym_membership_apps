import 'package:flutter/cupertino.dart';
import 'package:gym_membership_apps/model/article_model.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/model/instructor_model.dart';

class HomeViewModel with ChangeNotifier{
  final List<ClassModel> _classes = [
    ClassModel(
      idClass: 0,
      name: 'Weight Lifting',
      description: 'Weightlifting is the sport of Strength, Power, Speed and Precision. In competition, the lifts are comprised of the Snatch and the Clean & Jerk – both of which are efforts to lift the maximum amount of weight from ground to overhead in two distinct ways. In training, weightlifting and accessory exercises challenge the mind and body to grow strong and powerful through repetition after repetition of the basics.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(days: 1)),
      qtyUser: 25,
      type: 'Offline',
      image: 'assets/weightlifting.png',
      instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 1,
      name: 'Body Building',
      description: 'Bodybuilding is a specific and interesting sport that requires determination and strong discipline. What makes bodybuilding so different is that unlike most sports, in bodybuilding, competitors are judged by the way they look, not the way they perform.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(days: 1)),
      qtyUser: 25,
      type: 'Offline',
      image: 'assets/bodybuilding.png',
      instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 2,
      name: 'Yoga',
      description: 'Yoga is a mind and body practice. Various styles of yoga combine physical postures, breathing techniques, and meditation or relaxation. Yoga is an ancient practice that may have originated in India. It involves movement, meditation, and breathing techniques to promote mental and physical well-being.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(days: 1)),
      qtyUser: 25,
      type: 'Offline',
      image: 'assets/yoga.png',
      instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 3,
      name: 'Weight Loss',
      description: 'Weight loss is a decrease in body weight resulting from either voluntary (diet, exercise) or involuntary (illness) circumstances. Most instances of weight loss arise due to the loss of body fat, but in cases of extreme or severe weight loss, protein and other substances in the body can also be depleted.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(days: 1)),
      qtyUser: 25,
      type: 'Offline',
      image: 'assets/weightloss.png',
      instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 4,
      name: 'Zumba',
      description: 'A fitness program which is inspired by music and dance, which were earlier just Latin in nature, now it has got all world wide dance forms and music into its fitness regime.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(days: 1)),
      qtyUser: 25,
      type: 'Offline',
      image: 'assets/zumba.png',
      instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 5,
      name: 'Cardio',
      description: 'Cardio is defined as any type of exercise that gets your heart rate up and keeps it up for a prolonged period of time. Your respiratory system will start working harder as you begin to breathe faster and more deeply.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(days: 1)),
      qtyUser: 25,
      type: 'Offline',
      image: 'assets/cardio.png',
      instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 0,
      name: 'Weight Lifting',
      description: 'Weightlifting is the sport of Strength, Power, Speed and Precision. In competition, the lifts are comprised of the Snatch and the Clean & Jerk – both of which are efforts to lift the maximum amount of weight from ground to overhead in two distinct ways. In training, weightlifting and accessory exercises challenge the mind and body to grow strong and powerful through repetition after repetition of the basics.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(days: 1)),
      qtyUser: 25,
      type: 'Online',
      image: 'assets/weightlifting.png',
      instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 1,
      name: 'Body Building',
      description: 'Bodybuilding is a specific and interesting sport that requires determination and strong discipline. What makes bodybuilding so different is that unlike most sports, in bodybuilding, competitors are judged by the way they look, not the way they perform.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(days: 1)),
      qtyUser: 25,
      type: 'Online',
      image: 'assets/bodybuilding.png',
      instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 2,
      name: 'Yoga',
      description: 'Yoga is a mind and body practice. Various styles of yoga combine physical postures, breathing techniques, and meditation or relaxation. Yoga is an ancient practice that may have originated in India. It involves movement, meditation, and breathing techniques to promote mental and physical well-being.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(days: 1)),
      qtyUser: 25,
      type: 'Online',
      image: 'assets/yoga.png',
      instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 3,
      name: 'Weight Loss',
      description: 'Weight loss is a decrease in body weight resulting from either voluntary (diet, exercise) or involuntary (illness) circumstances. Most instances of weight loss arise due to the loss of body fat, but in cases of extreme or severe weight loss, protein and other substances in the body can also be depleted.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(days: 1)),
      qtyUser: 25,
      type: 'Online',
      image: 'assets/weightloss.png',
      instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 4,
      name: 'Zumba',
      description: 'A fitness program which is inspired by music and dance, which were earlier just Latin in nature, now it has got all world wide dance forms and music into its fitness regime.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(days: 1)),
      qtyUser: 25,
      type: 'Online',
      image: 'assets/zumba.png',
      instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
    ClassModel(
      idClass: 5,
      name: 'Cardio',
      description: 'Cardio is defined as any type of exercise that gets your heart rate up and keeps it up for a prolonged period of time. Your respiratory system will start working harder as you begin to breathe faster and more deeply.',
      startAt: DateTime.now(),
      endAt: DateTime.now().add(const Duration(days: 1)),
      qtyUser: 25,
      type: 'Online',
      image: 'assets/cardio.png',
      instructor: InstructorModel(idInstructor: 0, name: 'Aldi Amal', contact: '087823232237', email: 'aldiamal@gmail.com')
    ),
  ];

  List<ClassModel> get classes => _classes;

  final List<ArticleModel> _articles = [
    ArticleModel(
      imageUrl: 'https://gethealthyu.com/wp-content/uploads/2021/11/fitness-tips-500x500.png.webp',
      title: "101 Fitness Tips That Rock (From a Personal Trainer!)",
      url: 'https://gethealthyu.com/101-fitness-tips-that-rock/'
    ),
    ArticleModel(
      imageUrl: 'https://www.mensjournal.com/wp-content/uploads/mf/1280-improve-performance.jpg?w=900&quality=86&strip=all',
      title: "25 Expert Fitness Tips and Strategies Every Lifter Should Know",
      url: 'https://www.mensjournal.com/health-fitness/25-expert-fitness-tips-and-strategies-every-lifter-should-know/'
    ),
  ];

  List<ArticleModel> get articles => _articles;


}