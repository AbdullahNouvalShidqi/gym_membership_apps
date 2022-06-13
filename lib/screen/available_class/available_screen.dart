import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/screen/available_class/available_class_view_model.dart';
import 'package:gym_membership_apps/screen/schedule/schedule_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_card.dart';
import 'package:gym_membership_apps/utilitites/listview_shimmer_loading.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AvailableClassScreen extends StatefulWidget {
  static String routeName = '/availableClass';
  const AvailableClassScreen({Key? key}) : super(key: key);

  @override
  State<AvailableClassScreen> createState() => _AvailableClassScreenState();
}

class _AvailableClassScreenState extends State<AvailableClassScreen> with SingleTickerProviderStateMixin {

  final ScrollController _listViewController = ScrollController();
  final ScrollController _singleListController = ScrollController();
  late final tabController = TabController(length: 7, vsync: this);
  double lastOffset = 0;

  @override
  void initState() {
    _listViewController.addListener(costumScroll);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _listViewController.dispose();
    _singleListController.dispose();
    tabController.dispose();
  }

  void costumScroll() async {
    if(_listViewController.position.userScrollDirection == ScrollDirection.reverse){
      if(_singleListController.offset + _listViewController.offset - lastOffset <= _singleListController.position.maxScrollExtent && _singleListController.offset + _listViewController.offset - lastOffset >= _singleListController.position.minScrollExtent){
        _singleListController.jumpTo(_singleListController.offset +  _listViewController.offset - lastOffset);
      }
    }
    if(_listViewController.position.userScrollDirection == ScrollDirection.forward){
      if(_singleListController.offset + _listViewController.offset - lastOffset <= _singleListController.position.maxScrollExtent && _singleListController.offset + _listViewController.offset - lastOffset >= _singleListController.position.minScrollExtent){
        _singleListController.jumpTo(_singleListController.offset + _listViewController.offset - lastOffset);
      }
    }
    lastOffset = _listViewController.offset;    
  }

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as ClassModel;
    final availableClassViewModel = Provider.of<AvailableClassViewModel>(context);
    final isLoading = availableClassViewModel.state == AvailableClassState.loading;
    

    return WillPopScope(
      onWillPop: () async {
        availableClassViewModel.changeState(AvailableClassState.none);
        return true;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          controller: _singleListController,
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: costumAppBar(item: item)
                )
              ),
              const SizedBox(height: 15,),
              Builder(
                builder: (context) {
                  if(isLoading){
                    return SizedBox(height: MediaQuery.of(context).size.height, child: const ListViewShimmerLoading(shimmeringLoadingFor: ShimmeringLoadingFor.availableScreen,));
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(
                      height: 64,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(blurRadius: 8, color: Color.fromARGB(255, 230, 230, 230))
                        ]
                      ),
                      child: TabBar(
                        controller: tabController,
                        indicatorWeight: 0,
                        indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Utilities.primaryColor
                        ),
                        indicatorPadding: const EdgeInsets.all(10),
                        isScrollable: false,
                        unselectedLabelColor: const Color.fromRGBO(112, 112, 112, 1),
                        labelColor: Utilities.myWhiteColor,
                        labelPadding: const EdgeInsets.symmetric(horizontal: 10),
                        tabs: [
                          for(var i = 0; i < 7; i++) ...[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(DateFormat('EEE').format(DateTime.now().add(Duration(days: i))), style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400),),
                                const SizedBox(height: 5,),
                                Text(DateFormat('d').format(item.startAt.add(Duration(days: i))), style: GoogleFonts.roboto(fontSize: 12, fontWeight: FontWeight.w400))
                              ],
                            ),
                          ]
                        ],
                      ),
                    ),
                  );
                }
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height - 150,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    for(var i = 0; i < 7; i++) ...[
                      costumListView(isLoading: isLoading, item: item, availableClassViewModel: availableClassViewModel),
                    ]
                  ],
                ),
              ),
            ],
          )
        ),
      ),
    );
  }

  Widget costumListView({required bool isLoading, required ClassModel item, required AvailableClassViewModel availableClassViewModel}){
    return RefreshIndicator(
      onRefresh: availableClassViewModel.refreshData,
      child: Scrollbar(
        controller: _listViewController,
        child: ListView.builder(
          controller: _listViewController,
          padding: const EdgeInsets.only(top: 15),
          itemCount: 8,
          itemBuilder: (context, i){
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: CostumCard(classModel: item, whichScreen: CostumCardFor.availableClassScreen)
            );
          }
        ),
      ),
    );
  }

  Widget costumAppBar({required ClassModel item}){
    return Container(
      height: 60,
      color: Utilities.myWhiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 24,
            child: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, color: Utilities.primaryColor,)
            ),
          ),
          Expanded(child: Center(child: Text('${item.type} ${item.name} Class', style: Utilities.appBarTextStyle,))),
          const SizedBox(width: 24,)
        ],
      ),
    );
  }
}