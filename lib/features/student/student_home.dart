import 'package:flutter/material.dart';
import '../../core/widgets/app_text.dart';
import '../../core/widgets/app_base_card.dart';
import '../../core/widgets/auth_button.dart';
class StudentHomePage extends StatelessWidget {
	const StudentHomePage({super.key});

	@override
	Widget build(BuildContext context) {
		return  Scaffold(
			body:Center(
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start ,
          children: [
             const SizedBox(height: 20.0),
            AppText(
              text: 'السنة الدراسية 2026/2027 ',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 10.0),
            AppText(
              text: 'مرحبا بك',
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 10.0),
            AppText(
              text: 'معا في رحلة تعلم كلمة الله ',
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(
              child:  AppBaseCard(
              margin: const EdgeInsets.only(top: 20, left: 20,right: 20),
              padding: const EdgeInsets.all(16),
              borderRadius: BorderRadius.circular(12),
              elevation: 0,
             color: Color.fromARGB(255, 22, 192, 98).withOpacity( 0.4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [      
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Padding(
                            padding: EdgeInsets.only(top: 16.0,left: 16.0,right: 16.0,bottom: 16.0),
                            child: Icon(
                            Icons.menu_book,
                            size: 90,
                            color: Color.fromARGB(255, 1, 44, 34),
                          ),
                          ),
                          
                        ],
                      ),
                      SizedBox(width: 25),
                      const SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start ,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: const [
                          AppText(
                            text: 'السفر الحالي',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 4),
                          AppText(
                            text: 'سفر التكوين',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        AppText(
                            text: ' الجلسه الحاليه',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          SizedBox(height: 4),
                          AppText(
                            text: 'الأصحاحات 4 - 6',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        SizedBox(height: 4),
                        // LinearProgressIndicator(
                        //    minHeight: 4,
                        //   borderRadius: BorderRadius.all( Radius.circular(8)),
                        //   value: 0.5,
                        //   backgroundColor: Colors.red,
                        //   valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        // ),
                        AppText(
                            text: ' تم اكمال 3 من 10 جلسات  ',
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ],
                      ),


                    ],
                 
                  
                  

              ),
            )
            ),
           SizedBox(
            child:AppBaseCard(
              margin:  EdgeInsets.only(top: 20, left: 20,right: 20),
              elevation: 0,
              //Color.fromARGB(255, 22, 192, 98).withOpacity( 0.4)
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          // Handle button press
                        },
                        child:  Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 1, 44, 34),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                          'ابدأ الواجب',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        ),
                      )
                    ],
                  ),
                Column(
                 crossAxisAlignment: CrossAxisAlignment.end ,
                 mainAxisAlignment: MainAxisAlignment.start ,
                children: [
                  AppText(
                    text: 'الواجب القادم',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8),
                  AppText(
                    text: ' واجب سفر التكوين 4 - 6',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(height: 8),
                  AppText(
                    text: 'تاريخ التسليم: 2026-10-30',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
              //here the button should be added
              
              ],)
            )
           ),
            SizedBox(
              child:AppBaseCard(
              margin: const EdgeInsets.only(top: 20, left: 20,right: 20),
              elevation: 0,
              child: Column(
              children:[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                      AppText(
                        text: 'الحضور',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                  ],
                ),
                SizedBox(height: 10.0),
                Row(
                mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        AppText(
                          text: 'النسبة',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        AppText(
                          text: ' 70%',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      width: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      color: Colors.black,
                    ),
                    Divider(
                      thickness: 5,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Column(
                      children: [
                        AppText(
                          text: 'حضور',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        AppText(
                          text: ' 3',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      width: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      color: Colors.black,
                    ),
                    Divider(
                      thickness: 5,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Column(
                      children: [
                        AppText(
                          text: 'غياب',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        AppText(
                          text: '4',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      width: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      color: Colors.black,
                    ),
                    Divider(
                      thickness: 5,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Column(

                      children: [
                        AppText(
                          text: 'اجمالي',
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        AppText(
                          text: ' 7',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                    Divider(
                      thickness: 5,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Container(
                      height: 40,
                      width: 1,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      color: Colors.black,
                    ),
                    Column(
                      children: [
                        Icon(Icons.assignment_outlined, size: 40, color: Color.fromARGB(255, 1, 44, 34)),
                      ],
                    ),
                  ],
                ),
              ],
            )
              )
            )
        
          ],

        ),),
			
		);
	}
}
