import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gym_membership_apps/screen/home/home_view_model.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CostumMainAvatarAndDetail extends StatelessWidget {
  const CostumMainAvatarAndDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<ProfileViewModel>().user;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 57, left: 20, right: 20),
          child: Row(
            children: [
              const CircleAvatar(
                backgroundColor: Utilities.primaryColor,
                radius: 25,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Hello,', style: Utilities.greetingHomeStyle),
                  Text(user.username, style: Utilities.greetinSubHomeStyle),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Select', style: Utilities.homeViewMainTitleStyle),
              Text('Workout', style: Utilities.homeViewMainTitleStyle),
            ],
          ),
        ),
      ],
    );
  }
}

class TipsListView extends StatelessWidget {
  const TipsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, homeViewModel, _) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text('Tips for you', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 129,
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  scrollDirection: Axis.horizontal,
                  itemCount: homeViewModel.articles.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: () async {
                        var url = Uri.parse(homeViewModel.articles[i].url);
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url, mode: LaunchMode.inAppWebView);
                        } else {
                          Fluttertoast.showToast(msg: 'Error: Cannot open url');
                        }
                      },
                      child: SizedBox(
                        width: 210,
                        child: TipsImage(
                          imageUrl: homeViewModel.articles[i].imageUrl,
                          title: homeViewModel.articles[i].title,
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class TipsImage extends StatelessWidget {
  const TipsImage({Key? key, required this.imageUrl, required this.title}) : super(key: key);
  final String imageUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        width: 800,
        fit: BoxFit.cover,
        placeholder: (context, child) {
          return Container(
            height: 600,
            width: 800,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Utilities.primaryColor,
            ),
            child: const SpinKitPianoWave(color: Colors.white),
          );
        },
        imageBuilder: (context, image) {
          return Container(
            height: 600,
            width: 800,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(image: image, fit: BoxFit.cover),
            ),
            child: CarouselTitle(title: title),
          );
        },
      ),
    );
  }
}

class CarouselTitle extends StatelessWidget {
  const CarouselTitle({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          colors: [Colors.black, Colors.transparent],
          begin: Alignment.bottomCenter,
          end: Alignment.center,
        ),
      ),
      height: 60,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
        child: Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
        ),
      ),
    );
  }
}
