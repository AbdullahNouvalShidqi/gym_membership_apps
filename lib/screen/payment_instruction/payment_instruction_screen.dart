import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';

class PaymentInstructionScreen extends StatefulWidget {
  static String routeName = '/paymentInstruction';
  const PaymentInstructionScreen({Key? key}) : super(key: key);

  @override
  State<PaymentInstructionScreen> createState() => _PaymentInstructionScreenState();
}

class _PaymentInstructionScreenState extends State<PaymentInstructionScreen> with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  final _scrollController = ScrollController();
  bool _isShown = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Instruction', style: Utilities.appBarTextStyle,),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios)
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [
            Container(
              height: 48,
              width: double.infinity,
              alignment: Alignment.center,
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
                    Text('Total Payment', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),),
                    Text('Rp. 300.000', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500, color: const Color.fromRGBO(34, 85, 156, 1)))
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15,),
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(blurRadius: 8, color: Color.fromARGB(255, 240, 240, 240))
                ]
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SvgPicture.asset('assets/icons/mandiri.svg'),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Payment Method', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),),
                        const SizedBox(height: 10,),
                        Text('No. Rekening:', style: GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w500, color: const Color.fromRGBO(188, 188, 188, 1)),),
                        const SizedBox(height: 5,),
                        Text('1234 5678 910', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700),)
                      ],
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: () async {

                        },
                        child: Text('Copy', style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w700, color: Utilities.primaryColor),),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15,),
            costumMainCard(),
            costumSubCard()
          ],
        ),
      ),
    );
  }

  Widget costumMainCard(){
    return InkWell(
      onTap: onTap,
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
              Text('ATM Transfer Instruction', style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500)),
              RotationTransition(
                turns: Tween(begin: 0.0, end: 0.25).animate(_animationController),
                child: Icon(Icons.arrow_forward_ios, color: Utilities.primaryColor,)
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget costumSubCard(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: _isShown ? 10 : 5),
      child: SlideTransition(
        position: Tween(begin: const Offset(0.0, -0.2), end: Offset.zero).animate(_animationController),
        child: FadeTransition(
          opacity: _animationController,
          child: AnimatedContainer(
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 200),
            width: MediaQuery.of(context).size.width,
            height: _isShown ? 113 : 0,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(232, 232, 232, 1),
              borderRadius: BorderRadius.circular(8)
            ),
            child: Scrollbar(
              controller: _scrollController,
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: RichText(
                    text: TextSpan(
                      text: '1. Select another Menu > Transfer\n2. Select the origin account and select the destination account to MANDIRI account\n3. Enter the account number ',
                      style: GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black),
                      children: [
                        TextSpan(
                          text: '12345678910 ',
                          style: GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w400, color: Utilities.primaryColor)
                        ),
                        TextSpan(
                          text: 'and select correct\n4. Enter the payment amount ',
                          style: GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black)
                        ),
                        TextSpan(
                          text: 'Rp.300.000 ',
                          style: GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w400, color: Utilities.primaryColor)
                        ),
                        TextSpan(
                          text: "and select correct\n5. Check the data on the screen. Make sure the name is the recipient's name, and the amount is correct. If so, select Yes.",
                          style: GoogleFonts.roboto(fontSize: 10, fontWeight: FontWeight.w400, color: Colors.black)
                        ),
                      ]
                    )
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTap(){
    setState(() {
        _isShown = !_isShown;
      });
    if(_animationController.status == AnimationStatus.forward){
      _animationController.reverse();  
    }
    else if(_animationController.status == AnimationStatus.reverse){
      _animationController.forward();
    }
    else{
      _animationController.isCompleted ?
      _animationController.reverse():
      _animationController.forward();
    }
  }
}