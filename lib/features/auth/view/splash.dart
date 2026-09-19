import 'package:bible_study_app/features/student/student_shell.dart';
import 'package:flutter/material.dart';
import 'package:bible_study_app/core/widgets/app_text.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
	void initState(){
		super.initState();
		Timer(const Duration(seconds: 5),(){
			Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>const HomeScreen(),));
		});
	}

  Widget build(BuildContext context) {
		return Scaffold(
			body: Container(
				child: SafeArea(
					child: Center(
						child: Column(
							mainAxisAlignment: MainAxisAlignment.center,
							children: [
								Container(
									decoration: BoxDecoration(
										color: Colors.white,
										//border: Border.all(color: Colors.white24, width: 1.5),
									),
									child:
									Image.asset(
										'assets/app_icon.jpg',
										width: 350,
										height: 350,
										fit: BoxFit.cover,
									),

								),
								const SizedBox(height: 28),
								AppText(
									text: 'مدرسة الكتاب المقدس',
									fontSize: 36.0,
									fontWeight: FontWeight.bold,
								),
								const SizedBox(height: 20),
								const SizedBox(
									width: 24,
									height: 24,
									child: CircularProgressIndicator(
										strokeWidth: 3.0,
										valueColor: AlwaysStoppedAnimation<Color>( Color.fromARGB(255, 1, 44, 34),),
									),
								),
							],
						),
					),
				),
			),
		);
	}
}
