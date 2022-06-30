import 'package:flutter/material.dart';
import 'package:gym_membership_apps/screen/update_password/update_password_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_button.dart';
import 'package:gym_membership_apps/utilitites/costum_form_field.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

class UpdatePasswordScreen extends StatefulWidget {
  static String routeName = '/updatePassword';
  const UpdatePasswordScreen({Key? key}) : super(key: key);

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final updatePasswordViewModel = context.watch<UpdatePasswordViewModel>();
    return WillPopScope(
      onWillPop: () async {
        return await updatePasswordViewModel.onWillPop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            'Update Password',
            style: Utilities.appBarTextStyle,
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () async {
              await updatePasswordViewModel.appBarBackOnPressed(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Utilities.primaryColor),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Form(
              key: updatePasswordViewModel.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  SizedBox(height: 40),
                  NewPasswordFormField(),
                  SizedBox(height: 20),
                  ConfirmFormField(),
                  SizedBox(height: 30),
                  ContinueButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NewPasswordFormField extends StatelessWidget {
  const NewPasswordFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final updatePasswordViewModel = context.watch<UpdatePasswordViewModel>();
    return CostumFormField(
      controller: updatePasswordViewModel.newPasswordCtrl,
      label: 'New Password',
      hintText: 'Enter new password',
      prefixIcon: const Icon(Icons.lock_outline),
      textInputType: TextInputType.visiblePassword,
      useIconHidePassword: true,
      validator: (newValue) {
        if (newValue == null || newValue.isEmpty || newValue == ' ') {
          return 'Please enter your password';
        } else if (newValue.contains('  ')) {
          return 'Your password contains double space, please remove it';
        } else if (newValue.length < 6) {
          return 'The minimal length of password is 6';
        } else if (!Utilities.pwNeedOneCapital.hasMatch(newValue)) {
          return 'Please enter at least one capital letter in your password';
        } else if (!Utilities.pwNeedOneNonCapital.hasMatch(newValue)) {
          return 'Please enter at least one non capital letter in your password';
        } else if (!Utilities.pwNeedOneNumber.hasMatch(newValue)) {
          return 'Please enter at least one number in your password';
        }
        return null;
      },
    );
  }
}

class ConfirmFormField extends StatelessWidget {
  const ConfirmFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final updatePasswordViewModel = context.watch<UpdatePasswordViewModel>();
    return CostumFormField(
      controller: updatePasswordViewModel.confirmPasswordCtrl,
      label: 'Confirm Password',
      hintText: 'Enter new password',
      prefixIcon: const Icon(Icons.lock_outline),
      textInputType: TextInputType.visiblePassword,
      useIconHidePassword: true,
      validator: (newValue) {
        if (newValue == null || newValue.isEmpty || newValue == ' ') {
          return 'Please enter your password';
        } else if (newValue.contains('  ')) {
          return 'Please enter a valid password';
        } else if (newValue != updatePasswordViewModel.confirmPasswordCtrl.text) {
          return 'Please enter a same password';
        }
        return null;
      },
    );
  }
}

class ContinueButton extends StatelessWidget {
  const ContinueButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final updatePasswordViewModel = context.watch<UpdatePasswordViewModel>();
    final isLoading = updatePasswordViewModel.state == UpdatePasswordState.loading;

    return CostumButton(
      isLoading: isLoading,
      onPressed: () async {
        final id = ModalRoute.of(context)!.settings.arguments as int;
        await updatePasswordViewModel.updatePasswordOnPressed(context, id: id);
      },
      childText: 'Continue',
    );
  }
}
