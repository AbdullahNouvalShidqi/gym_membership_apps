import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'costum_button.dart';

class CostumErrorScreen extends StatefulWidget {
  const CostumErrorScreen({Key? key, required this.onPressed, this.useLoading = false}) : super(key: key);
  final Future<void> Function() onPressed;
  final bool useLoading;

  @override
  State<CostumErrorScreen> createState() => _CostumErrorScreenState();
}

class _CostumErrorScreenState extends State<CostumErrorScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/icons/connection_lost.svg'),
              const SizedBox(height: 14),
              const Text(
                'Connection Lost',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 5),
              const Text(
                'Looks like you have lost connection with Wifi or other internet connection, or the server is down',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: Color.fromRGBO(88, 88, 88, 1)),
              ),
              const SizedBox(height: 25),
              CostumButton(
                onPressed: () async {
                  if (widget.useLoading) {
                    setState(() {
                      isLoading = true;
                    });
                  }

                  await widget.onPressed();

                  if (widget.useLoading) {
                    setState(() {
                      isLoading = false;
                    });
                  }
                },
                isLoading: isLoading,
                width: 121,
                childText: 'Try Again',
              )
            ],
          ),
        ),
      ),
    );
  }
}
