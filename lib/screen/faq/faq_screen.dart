import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';

class FaqScreen extends StatefulWidget {
  static String routeName = '/faq';
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> with SingleTickerProviderStateMixin {
  late final controller1 = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  bool isShown = false;
  String initialValue = 
  '1. Select another Menu > Transfer \n2. Select the origin account and select the destination account to MANDIRI account \n3. Enter the account number 12345678910 and select correct \n4. Enter the payment amount Rp.300.000 and select correct \n5. Check the data on the screen. Make sure the name is the recipient’s name and the amount is correct. if so, select Yes.';
final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ', style: Utilities.appBarTextStyle,),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 35),
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, i){
            return Column(
              children: [
                InkWell(
                  onTap: onTap(i),
                  child: Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(blurRadius: 8, color: Color.fromARGB(255, 240, 240, 240))
                      ]
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('How to do the payment?', style: GoogleFonts.roboto(fontSize: 16),),
                          RotationTransition(
                            turns: Tween(begin: 0.0, end: 0.25).animate(controller1),
                            child: Icon(Icons.arrow_forward_ios, color: Utilities.primaryColor,)
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: isShown ? 10 : 5),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: MediaQuery.of(context).size.width,
                    height: isShown ? 150 : 0,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 232, 232, 232),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10,),
                      child: Scrollbar(
                        thumbVisibility: true,
                        controller: _scrollController,
                        child: TextFormField(
                          scrollController: _scrollController,
                          initialValue: initialValue,
                          keyboardType: TextInputType.multiline,
                          maxLines: 10,
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.all(10),
                          ),
                          style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      )
                    ),
                  ),
                ),
                Container(
                  height: 48,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(blurRadius: 8, color: Color.fromARGB(255, 240, 240, 240))
                    ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Is the trainer a professional', style: GoogleFonts.roboto(fontSize: 16),),
                        Icon(Icons.arrow_forward_ios, color: Utilities.primaryColor,),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }

  void Function() onTap(int i){
    return (){
      if(i == 0){
        setState(() {
          isShown = !isShown;
        });
        controller1.isCompleted ?
        controller1.reverse() : 
        controller1.forward();  
      }
    };
  }
}