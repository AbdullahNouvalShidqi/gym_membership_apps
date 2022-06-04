import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';

class FaqScreen extends StatefulWidget {
  static String routeName = '/faq';
  const FaqScreen({Key? key}) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> with TickerProviderStateMixin {
  late final controller1 = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  late final controller2 = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));

  late final List<AnimationController> controllers = [
    controller1,
    controller2
  ];

  bool isShown1 = false;
  bool isShown2 = false;

  late final List<bool> isShows = [
    isShown1,
    isShown2
  ];
  
  final _scrollController1 = ScrollController();
  final _scrollController2 = ScrollController();

  late final List<ScrollController> scrollControllers = [
    _scrollController1,
    _scrollController2
  ];

  @override
  void dispose() {
    super.dispose();
    controller1.dispose();
    controller2.dispose();
    _scrollController1.dispose();
    _scrollController2.dispose();
  }

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
          itemCount: 2,
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
                            turns: Tween(begin: 0.0, end: 0.25).animate(controllers[i]),
                            child: Icon(Icons.arrow_forward_ios, color: Utilities.primaryColor,)
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: isShows[i] ? 10 : 5),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: MediaQuery.of(context).size.width,
                    height: isShows[i] ? 150 : 0,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 232, 232, 232),
                      borderRadius: BorderRadius.circular(8)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10,),
                      child: Scrollbar(
                        thumbVisibility: true,
                        controller: scrollControllers[i],
                        child: SingleChildScrollView(
                          controller: scrollControllers[i],
                          child: RichText(
                            text: TextSpan(
                              text: '1. Select another Menu > Transfer \n2. Select the origin account and select the destination account to MANDIRI account \n3. Enter the account number ',
                              style: GoogleFonts.roboto(fontSize: 10, color: Colors.black),
                              children: [
                                TextSpan(
                                  text: '12345678910 ',
                                  style: GoogleFonts.roboto(fontSize: 10, color: Utilities.primaryColor),
                                ),
                                TextSpan(
                                  text: 'and select correct \n4. Enter the payment amount ',
                                  style: GoogleFonts.roboto(fontSize: 10, color: Colors.black),
                                ),
                                TextSpan(
                                  text: 'Rp.300.000',
                                  style: GoogleFonts.roboto(fontSize: 10, color: Utilities.primaryColor),
                                ),
                                TextSpan(
                                  text: ' and select correct \n5. Check the data on the screen. Make sure the name is the recipient’s name and the amount is correct. if so, select Yes.',
                                  style: GoogleFonts.roboto(fontSize: 10, color: Colors.black),
                                ),             
                              ]
                            ),
                          ),
                        )
                      )
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
      setState(() {
        isShows[i] = !isShows[i];
      });
      controllers[i].isCompleted ?
      controllers[i].reverse():
      controllers[i].forward();
    };
  }
}