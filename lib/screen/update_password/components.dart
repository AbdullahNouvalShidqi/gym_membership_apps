import 'package:flutter/material.dart';
import 'package:gym_membership_apps/screen/update_password/update_password_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_button.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_form_field.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

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
        } else if (newValue != updatePasswordViewModel.newPasswordCtrl.text) {
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
