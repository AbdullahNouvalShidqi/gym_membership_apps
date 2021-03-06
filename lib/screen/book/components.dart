import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_membership_apps/model/class_model.dart';
import 'package:gym_membership_apps/model/user_model.dart';
import 'package:gym_membership_apps/screen/book/book_view_model.dart';
import 'package:gym_membership_apps/screen/payment_instruction/payment_instruction_screen.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_button.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BookingDetail extends StatelessWidget {
  const BookingDetail({Key? key, required this.item}) : super(key: key);
  final ClassModel item;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Booking Detail', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 108,
              width: 83,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(image: AssetImage(item.images.first), fit: BoxFit.cover),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.type, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 5),
                  Text('${item.name} Class', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.calendar_today_outlined, size: 10, color: Colors.grey),
                      const SizedBox(width: 5),
                      Text(
                        '${DateFormat('d MMMM y').format(item.startAt)}, ${DateFormat('Hm').format(item.startAt)}',
                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/icons/gym_icon.svg', color: Colors.grey),
                      const SizedBox(width: 5),
                      Text(item.instructor.name, style: const TextStyle(fontSize: 10, color: Colors.grey))
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.location_on_outlined, size: 10, color: Colors.grey),
                      const SizedBox(width: 5),
                      Text(item.location, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              NumberFormat.currency(symbol: 'Rp. ', locale: 'id_id', decimalDigits: 0).format(item.price),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Utilities.primaryColor,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class UserInformation extends StatelessWidget {
  const UserInformation({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('User Information', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          const SizedBox(height: 10),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Name', style: TextStyle(fontSize: 10, color: Color.fromRGBO(115, 115, 115, 1))),
                    SizedBox(height: 5),
                    Text('Phone Number', style: TextStyle(fontSize: 10, color: Color.fromRGBO(115, 115, 115, 1))),
                    SizedBox(height: 5),
                    Text('Email', style: TextStyle(fontSize: 10, color: Color.fromRGBO(115, 115, 115, 1))),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(user.username, style: const TextStyle(fontSize: 10, color: Color.fromRGBO(115, 115, 115, 1))),
                    const SizedBox(height: 5),
                    Text(user.contact, style: const TextStyle(fontSize: 10, color: Color.fromRGBO(115, 115, 115, 1))),
                    const SizedBox(height: 5),
                    Text(user.email, style: const TextStyle(fontSize: 10, color: Color.fromRGBO(115, 115, 115, 1))),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CostumButtons extends StatelessWidget {
  const CostumButtons({Key? key, required this.item}) : super(key: key);
  final ClassModel item;

  @override
  Widget build(BuildContext context) {
    final backToHomeOnTap = context.watch<BookViewModel>().backToHomeOnTap;
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [BoxShadow(blurRadius: 3, color: Color.fromARGB(255, 230, 230, 230))],
        color: Utilities.myWhiteColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CostumButton(
              onPressed: () {
                backToHomeOnTap(context);
              },
              height: 45,
              backgroundColor: Utilities.myWhiteColor,
              borderColor: Utilities.primaryColor,
              fontColor: Utilities.primaryColor,
              childText: 'Back to home',
            ),
            const SizedBox(height: 5),
            CostumButton(
              onPressed: () {
                Navigator.pushNamed(context, PaymentInstructionScreen.routeName, arguments: item);
              },
              height: 45,
              childText: 'Payment Instruction',
            ),
          ],
        ),
      ),
    );
  }
}
