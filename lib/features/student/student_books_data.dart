import 'package:flutter/material.dart';
import 'package:bible_study_app/core/widgets/app_text.dart';
import '/core/widgets/Books_card.dart';

class BooksData extends StatefulWidget {
  const new({super.key});

  @override
  State<BooksData> createState() => _BooksDataState();
}

class _BooksDataState extends State<BooksData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      centerTitle: true,
     title: AppText(
      text:'سفر التكوين',
     ),
    ),
      body: SafeArea(
        child: SingleChildScrollView(
        child: ListView(
          shrinkWrap: true,
          children: [
            ListView.builder(
                    shrinkWrap: true,
                    itemCount: 6,
                    itemBuilder:(context,index){
                      return ListTile(
                          leading: const Icon(Icons.check_circle),
                          title: const Text('الجلسة الاولى'),
                          subtitle: const Text('الاصحاحات 1 - 3'),
                          trailing: const Icon(Icons.arrow_forward_ios),
                          onTap: () {
                            // Action on tap
                          },
                        );
                    }
                  )
          ],
        
      )),
      ),
    );
  }
}