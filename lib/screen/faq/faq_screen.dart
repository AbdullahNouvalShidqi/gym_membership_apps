import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/screen/faq/faq_view_model.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

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
    final faqScreenModel = Provider.of<FaqViewModel>(context);
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
          itemCount: faqScreenModel.mainData.length,
          itemBuilder: (context, i){
            return Column(
              children: [
                costumMainCard(i: i, titleWidget: faqScreenModel.mainData[i]['title']!),
                costumSubCard(i: i, value: faqScreenModel.mainData[i]['value']!)
              ],
            );
          }
        ),
      ),
    );
  }

  Widget costumMainCard({required int i, required Widget titleWidget}){
    return InkWell(
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
              titleWidget,
              RotationTransition(
                turns: Tween(begin: 0.0, end: 0.25).animate(controllers[i]),
                child: Icon(Icons.arrow_forward_ios, color: Utilities.primaryColor,)
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget costumSubCard({required int i, required Widget value}){
    return Padding(
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
              child: value,
            )
          )
        ),
      ),
    );
  }

  void Function() onTap(int i){
    return (){
      setState(() {
          isShows[i] = !isShows[i];
        });
      if(controllers[i].status == AnimationStatus.forward){
        controllers[i].reverse();  
      }
      else if(controllers[i].status == AnimationStatus.reverse){
        controllers[i].forward();
      }
      else{
        controllers[i].isCompleted ?
        controllers[i].reverse():
        controllers[i].forward();
      }
    };
  }
}