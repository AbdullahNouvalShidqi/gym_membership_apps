import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/screen/available_class/available_class_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_card.dart';
import 'package:gym_membership_apps/utilitites/empty_list_view.dart';
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

  late final _tabController = TabController(length: 7, vsync: this);

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Provider.of<AvailableClassViewModel>(context, listen: false).getAvailableClasses();
    });
  }

  @override
  Widget build(BuildContext context) {
    final item = ModalRoute.of(context)!.settings.arguments as ClassModel;
    final availableClassViewModel = Provider.of<AvailableClassViewModel>(context);
    final isLoading = availableClassViewModel.state == AvailableClassState.loading;
    final isEmpty = availableClassViewModel.availableClasses.isEmpty;

    return WillPopScope(
      onWillPop: () async {
        availableClassViewModel.changeState(AvailableClassState.none);
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  title: Text('${item.type} ${item.name} Class', style: Utilities.appBarTextStyle,),
                  leading: IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios, color: Utilities.primaryColor,),
                  ),
                  centerTitle: true,
                )
              ];
            },
            body: Builder(
              builder: (context) {
                if(isLoading){
                  return const ListViewShimmerLoading(shimmeringLoadingFor: ShimmeringLoadingFor.availableScreen);
                }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
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
                          controller: _tabController,
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
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          for(var i = 0; i < 7; i++) ...[
                            CostumListView(isEmpty: isEmpty, item: item),
                          ]
                        ],
                      ),
                    ),
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}

class CostumListView extends StatelessWidget {
  const CostumListView({Key? key, required this.isEmpty, required this.item}) : super(key: key);
  final bool isEmpty;
  final ClassModel item;

  @override
  Widget build(BuildContext context) {
    // if(isEmpty){
    //   return EmptyListView(svgAssetLink: 'assets/icons/empty_class.svg', title: 'Ooops, class not yet available', emptyListViewFor: EmptyListViewFor.available, onRefresh: availableClassViewModel.refreshData,);
    // }
    return Consumer<AvailableClassViewModel>(
      builder: (context, availableClassViewModel, _) {
        return RefreshIndicator(
          onRefresh: availableClassViewModel.refreshData,
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 15),
            itemCount: 8,
            itemBuilder: (context, i){
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: CostumCard(classModel: item, whichScreen: CostumCardFor.availableClassScreen)
              );
            }
          ),
        );
      }
    );
  }
}