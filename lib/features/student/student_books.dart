import 'package:bible_study_app/core/widgets/app_text.dart';
import 'package:bible_study_app/features/student/student_books_data.dart' show BooksData;
import 'package:flutter/material.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import '/core/widgets/Books_card.dart';




class student_book extends StatefulWidget {
  const new({super.key});
  @override
  State<student_book> createState() => _student_bookState();
}
class _student_bookState extends State<student_book> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    body: Center(
      child: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding:EdgeInsets.only(top:30,) ,
                child: Center(
              child: AppText(text:  'الأسفار', fontSize: 24, fontWeight: FontWeight.bold),
            ),
            ),
            ListView.builder(
                    shrinkWrap: true,
                    itemCount: 7,

                    itemBuilder:(context,index){
                      return BookCard(
                      
                        //here to add the routing to books data
                       margin:const EdgeInsets.all(30),
                        elevation: 0,
                        color: Color.fromARGB(255, 22, 192, 98).withOpacity( 0.4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:[
                            Column(
                              
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    AppText(
                                      text: 'سفر التكوين',
                                       fontSize: 18,
                                        fontWeight: FontWeight.bold
                                        
                                        ),
                                
                                  IconButton(
                                    icon: const Icon(Icons.arrow_forward_ios_outlined),
                                 iconSize: 30.0,
                                    tooltip: 'Add to favorites',
                                   onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BooksData(),
                                          ),
                                        );
                                      },
                                    )
                                                                    
                                ],
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                               LinearProgressBar(
                                  maxSteps: 10,
                                  progressType: ProgressType.linear,
                                  currentStep: 3,
                                  progressColor: Color.fromARGB(255, 1, 44, 34),
                                  backgroundColor: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                   animateProgress: true,
                                )
                              ],
                            ),
                            SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Column(
                                children: [
                                   AppText(text: '3 - 10 جلسات')
                                ],
                               ),   
                                Column(
                                  children: [
                                    AppText(text: '30%')
                                  ],
                                ),
                              ],
                            ), 
                          ]
                        )
                      );
                    }
                  )
          ],
        
      )),
    )
   );
  }
}