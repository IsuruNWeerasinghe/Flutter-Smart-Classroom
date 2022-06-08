import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:littleclassroom/routes.dart';
import 'package:littleclassroom/screens/alphabet/alphabet_screen.dart';
import 'package:littleclassroom/screens/alphabet/alphabet_song.dart';
import 'package:littleclassroom/screens/alphabet/letter_practice_screen.dart';
import 'package:littleclassroom/screens/alphabet/lowercase_screen.dart';
import 'package:littleclassroom/screens/alphabet/phonics_screen.dart';
import 'package:littleclassroom/screens/alphabet/phonics_song_screen.dart';
import 'package:littleclassroom/screens/alphabet/uppercase_quiz_screen.dart';
import 'package:littleclassroom/screens/alphabet/lowercase_quiz_screen.dart';
import 'package:littleclassroom/screens/alphabet/uppercase_screen.dart';
import 'package:littleclassroom/screens/animals/animals_home_screen.dart';
import 'package:littleclassroom/screens/animals/animals_quiz_screen.dart';
import 'package:littleclassroom/screens/animals/animals_screen.dart';
import 'package:littleclassroom/screens/colors/colors_home_screen.dart';
import 'package:littleclassroom/screens/colors/colors_quiz_screen.dart';
import 'package:littleclassroom/screens/colors/colors_screen.dart';
import 'package:littleclassroom/screens/forgot_password_screen.dart';
import 'package:littleclassroom/screens/fruits/fruits_home_screen.dart';
import 'package:littleclassroom/screens/fruits/fruits_quiz_screen.dart';
import 'package:littleclassroom/screens/fruits/fruits_screen.dart';
import 'package:littleclassroom/screens/home_screen.dart';
import 'package:littleclassroom/screens/login_screen.dart';
import 'package:littleclassroom/screens/numbers/counting_1_screen.dart';
import 'package:littleclassroom/screens/numbers/numbers_count_screen.dart';
import 'package:littleclassroom/screens/numbers/numbers_screen.dart';
import 'package:littleclassroom/screens/numbers/numbers_quiz_screen.dart';
import 'package:littleclassroom/screens/register_screen.dart';
import 'package:littleclassroom/screens/scores/scores_screen.dart';
import 'package:littleclassroom/screens/shapes/shapes_home_screen.dart';
import 'package:littleclassroom/screens/shapes/shapes_quiz_screen.dart';
import 'package:littleclassroom/screens/shapes/shapes_screen.dart';
import 'package:littleclassroom/screens/vegetables/vegetables_home_screen.dart';
import 'package:littleclassroom/screens/vegetables/vegetables_quiz_screen.dart';
import 'package:littleclassroom/screens/vegetables/vegetables_screen.dart';
import 'package:littleclassroom/screens/vehicles/vehicles_home_screen.dart';
import 'package:littleclassroom/screens/vehicles/vehicles_quiz_screen.dart';
import 'package:littleclassroom/screens/vehicles/vehicles_screen.dart';
import 'package:littleclassroom/screens/welcome_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  );

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => const WelcomeScreen(),

      Routes.login_page: (context) => const LogInScreen(),
      Routes.register_page: (context) => const RegisterScreen(),
      Routes.forgot_password_page: (context) => const ForgotPasswordScreen(),
      Routes.welcome_page: (context) => const WelcomeScreen(),
      Routes.home_page: (context) => const HomeScreen(),

      Routes.alphabet_page: (context) => const AlphabetScreen(),
      Routes.lowercase_page: (context) => const LowercaseScreen(),
      Routes.uppercase_page: (context) => const UppercaseScreen(),
      Routes.alphabet_song_page: (context) => const AlphabetSongScreen(),
      Routes.phonics_page: (context) => const PhonicsScreen(),
      Routes.phonics_song_page: (context) => const PhonicsSongScreen(),
      Routes.uppercase_quiz_page: (context) => const UppercaseQuizScreen(),
      Routes.lowercase_quiz_page: (context) => const LowercaseQuizScreen(),
      Routes.letter_practice_page: (context) => const LetterPracticeScreen(),

      Routes.numbers_page: (context) => const NumbersScreen(),
      Routes.numbers_count_page: (context) => const NumbersCountScreen(),
      Routes.counting1_page: (context) => const Counting1Screen(),
      Routes.numbers_quiz_page: (context) => const NumbersQuizScreen(),

      Routes.animals_home_page: (context) => const AnimalsHomeScreen(),
      Routes.animals_page: (context) => const AnimalsScreen(),
      Routes.animals_quiz_page: (context) => const AnimalsQuizScreen(),

      Routes.fruits_home_page: (context) => const FruitsHomeScreen(),
      Routes.fruits_page: (context) => const FruitsScreen(),
      Routes.fruits_quiz_page: (context) => const FruitsQuizScreen(),

      Routes.vegetables_home_page: (context) => const VegetablesHomeScreen(),
      Routes.vegetables_page: (context) => const VegetablesScreen(),
      Routes.vegetables_quiz_page: (context) => const VegetablesQuizScreen(),

      Routes.vehicles_home_page: (context) => const VehiclesHomeScreen(),
      Routes.vehicles_page: (context) => const VehiclesScreen(),
      Routes.vehicles_quiz_page: (context) => const VehiclesQuizScreen(),

      Routes.shapes_home_page: (context) => const ShapesHomeScreen(),
      Routes.shapes_page: (context) => const ShapesScreen(),
      Routes.shapes_quiz_page: (context) => const ShapesQuizScreen(),

      Routes.colors_home_page: (context) => const ColorsHomeScreen(),
      Routes.colors_page: (context) => const ColorsScreen(),
      Routes.colors_quiz_page: (context) => const ColorsQuizScreen(),

      Routes.scores_page: (context) => const ScoresScreen(),
    },
  ));

  }