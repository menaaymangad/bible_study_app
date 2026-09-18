import 'package:flutter/material.dart';
import 'package:bible_study_app/core/widgets/app_text.dart';
import '/core/widgets/Books_card.dart';


class HomeWork extends StatefulWidget {
  const new({super.key});
  @override
  State<HomeWork> createState() => _HomeWorkState();
}
class _HomeWorkState extends State<HomeWork> {
  // متغير لتخزين خيار الاختيار من متعدد
  int selectedOption = 0; // 0: ستة أيام, 1: سبعة أيام, 2: ثمانية أيام
  // متحكم بحقل النص للإجابة المقالية
  final TextEditingController textAnswerController = TextEditingController();
  @override
  void dispose() {
    textAnswerController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const AppText(
          text: 'تفاصيل الواجب',
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SafeArea(
        //this cames from admin addings to the homework data
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // العناوين الرئيسية
                      const Text(
                        'سفر التكوين',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'الجلسة الثانية - الإصحاحات ٤ - ٦',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Divider(thickness: 1, color: Color(0xFFEEEEEE)),
                      const SizedBox(height: 16),

                      // --- السؤال الأول ---
                      const Text(
                        'السؤال الأول (٢ درجة)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'كم يوما استغرق الخلق؟',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // حاوية خيارات الإجابة متعددة الخيارات
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            _buildRadioOption('ستة أيام', 0, Colors.redAccent),
                            const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
                            _buildRadioOption('سبعة أيام', 1, Colors.redAccent),
                            const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
                            _buildRadioOption('ثمانية أيام', 2, Colors.redAccent),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      // --- السؤال الثاني ---
                      const Text(
                        'السؤال الثاني (٨ درجات)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'اكتب ما تعلمته من الإصحاح الأول',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // حقل إدخال النص للأجوبة المقالية
                      Container(
                        height: 120,
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: textAnswerController,
                          maxLines: 120,
                          decoration: const InputDecoration(
                            hintText: 'اكتب إجابتك هنا ...',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // زر الإرسال في أسفل الصفحة
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 1, 44, 34),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    // إجراء عند ضغط زر الإرسال
                  },
                  child: const Text(
                    'إرسال',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  
  Widget _buildRadioOption(String title, int value, Color activeColor) {
    return RadioListTile<int>(
      title: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      value: value,
      groupValue: selectedOption,
      activeColor: activeColor,
      controlAffinity: ListTileControlAffinity.trailing, // وضع الدائرة على اليمين
      onChanged: (val) {
        setState(() {
          selectedOption = val!;
        });
      },
    );
    }
}