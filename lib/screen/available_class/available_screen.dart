import 'package:flutter/material.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/screen/available_class/available_class_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_card.dart';
import 'package:gym_membership_apps/utilitites/loading_shimmering_card.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

class AvailableClassScreen extends StatelessWidget {
  static String routeName = '/availableClass';
  const AvailableClassScreen({Key? key}) : super(key: key);

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
        appBar: AppBar(
          title: Text('${item.type} ${item.name} Class', style: Utilities.appBarTextStyle,),
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios)
          ),
        ),
        body: RefreshIndicator(
          onRefresh: availableClassViewModel.refreshData,
          child: ListView.builder(
            physics: isLoading ? const NeverScrollableScrollPhysics() : const BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, i){
              if(isLoading){
                return ShimmeringCard(
                  height: 114,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  borderRadius: BorderRadius.circular(8),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: CostumCard(classModel: item, whichScreen: CostumCardFor.availableClassScreen)
              );
            }
          ),
        ),
      ),
    );
  }
}