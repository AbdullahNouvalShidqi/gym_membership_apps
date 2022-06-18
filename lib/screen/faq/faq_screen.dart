import 'package:flutter/material.dart';
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
  late final List<ScrollController> _scrollControllers = [];
  late final List<AnimationController> _animationControllers = [];
  late final List<bool> _isShown = [];

  @override
  void initState() {
    super.initState();
    int length = Provider.of<FaqViewModel>(context, listen: false).mainData.length;
    for(var i = 0; i < length; i++){
      _scrollControllers.add(
        ScrollController()       
      );
      _animationControllers.add(
        AnimationController(vsync: this, duration: const Duration(milliseconds: 200))
      );
      _isShown.add(
        false
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    for(var i = 0; i < _scrollControllers.length; i++){
      _scrollControllers[i].dispose();
      _animationControllers[i].dispose();
    }
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
                costumSubCard(i: i, faqViewModel: faqScreenModel)
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
                turns: Tween(begin: 0.0, end: 0.25).animate(_animationControllers[i]),
                child: Icon(Icons.arrow_forward_ios, color: Utilities.primaryColor,)
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget costumSubCard({required int i, required FaqViewModel faqViewModel}){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: _isShown[i] ? 10 : 5),
      child: SlideTransition(
        position: Tween(begin: const Offset(0.0, -0.2), end: Offset.zero).animate(_animationControllers[i]),
        child: FadeTransition(
          opacity: _animationControllers[i],
          child: AnimatedContainer(
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 200),
            width: MediaQuery.of(context).size.width,
            height: _isShown[i] ? 60 : 0,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(232, 232, 232, 1),
              borderRadius: BorderRadius.circular(8)
            ),
            child: Padding(
              padding: const EdgeInsets.all(10,),
              child: Scrollbar(
                thumbVisibility: true,
                controller: _scrollControllers[i],
                child: SingleChildScrollView(
                  controller: _scrollControllers[i],
                  child: faqViewModel.mainData[i]['value'],
                )
              )
            ),
          ),
        ),
      ),
    );
  }

  void Function() onTap(int i){
    return (){
      setState(() {
          _isShown[i] = !_isShown[i];
        });
      if(_animationControllers[i].status == AnimationStatus.forward){
        _animationControllers[i].reverse();  
      }
      else if(_animationControllers[i].status == AnimationStatus.reverse){
        _animationControllers[i].forward();
      }
      else{
        _animationControllers[i].isCompleted ?
        _animationControllers[i].reverse():
        _animationControllers[i].forward();
      }
    };
  }
}