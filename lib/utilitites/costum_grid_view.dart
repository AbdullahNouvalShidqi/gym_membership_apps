import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_membership_apps/screen/detail/detail_screen.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:provider/provider.dart';

class CostumGridView extends StatelessWidget {
  const CostumGridView({Key? key, required this.type}) : super(key: key);
  final String type;

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, _) {
        final items = type == 'Online' ? homeViewModel.classes.where((e) => e.type == type).toList() : homeViewModel.classes.where((e) => e.type == type).toList().reversed.toList();
        return GridView.builder(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            childAspectRatio: 150/195
          ),
          itemBuilder: (context, i){
            return InkWell(
              onTap: (){
                Navigator.pushNamed(context, DetailScreen.routeName, arguments: items[i]);
              },
              child: 
              Container(
                height: 195,
                width: 150,
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: AssetImage(items[i].images!.first),
                    fit: BoxFit.cover
                  )
                ),
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: const LinearGradient(
                      colors: [Colors.black,  Colors.transparent], 
                      begin: Alignment.bottomCenter,
                      end: Alignment.center
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(items[i].name, maxLines: 1, overflow: TextOverflow.ellipsis,style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),),
                        Text('Class', maxLines: 1, overflow: TextOverflow.ellipsis,style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
        );
      }
    );
  }
}