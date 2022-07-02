import 'package:flutter/material.dart';
import 'package:gym_membership_apps/screen/profile/profile_view_model.dart';
import 'package:gym_membership_apps/screen/profile_update_password/profile_update_password_view_model.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_button.dart';
import 'package:gym_membership_apps/utilitites/costum_widgets/costum_form_field.dart';
import 'package:gym_membership_apps/utilitites/utilitites.dart';
import 'package:provider/provider.dart';

class CurrentPasswordFormField extends StatelessWidget {
  const CurrentPasswordFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<ProfileViewModel, ProfileUpdatePasswordViewModel>(
      builder: (context, profileViewModel, profileUpdatePasswordViewModel, _) {
        return CostumFormField(
          controller: profileUpdatePasswordViewModel.currentPwCtrl,
          label: 'Current Password',
          hintText: 'Enter your password',
          useIconHidePassword: true,
          prefixIcon: const Icon(Icons.lock_outline),
          textInputType: TextInputType.emailAddress,
          validator: (newValue) {
            if (newValue == null || newValue.isEmpty || newValue == ' ') {
              return 'Please enter your password';
            } else if (newValue != profileViewModel.user.password) {
              return 'Please enter your current password';
            }
            return null;
          },
        );
      },
    );
  }
}

class NewPasswordFormField extends StatelessWidget {
  const NewPasswordFormField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileUpdatePasswordViewModel = context.watch<ProfileUpdatePasswordViewModel>();
    return CostumFormField(
      controller: profileUpdatePasswordViewModel.newPwCtrl,
      label: 'New Password',
      hintText: 'Enter new password',
      useIconHidePassword: true,
      prefixIcon: const Icon(Icons.lock_outline),
      textInputType: TextInputType.emailAddress,
      validator: (newValue) {
        if (newValue == null || newValue.isEmpty || newValue == ' ') {
          return 'Please enter your password';
        } else if (newValue == profileUpdatePasswordViewModel.currentPwCtrl.text) {
          return 'Enter new password';
        } else if (newValue.contains('  ')) {
          return 'Your password contains double space, please remove it';
        } else if (newValue.length < 6) {
          return 'The minimal length of password is 6';
        } else if (!Utilities.pwNeedOneCapital.hasMatch(newValue)) {
          return 'Please enter at least one alphabet letter in your password';
        } else if (!Utilities.pwNeedOneNonCapital.hasMatch(newValue)) {
          return 'Please enter at least one non alphabet letter in your password';
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
    final profileUpdatePasswordViewModel = context.watch<ProfileUpdatePasswordViewModel>();
    return CostumFormField(
      controller: profileUpdatePasswordViewModel.confirmPwCtrl,
      label: 'Confirm Password',
      hintText: 'Enter new password',
      useIconHidePassword: true,
      prefixIcon: const Icon(Icons.lock_outline),
      textInputType: TextInputType.visiblePassword,
      validator: (newValue) {
        if (newValue == null || newValue.isEmpty || newValue == ' ') {
          return 'Please enter your password';
        } else if (newValue.contains('  ')) {
          return 'Please enter a valid password';
        } else if (newValue != profileUpdatePasswordViewModel.newPwCtrl.text) {
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
    final profileUpdatePasswordViewModel = context.watch<ProfileUpdatePasswordViewModel>();
    final profileViewModel = context.watch<ProfileViewModel>();
    final isLoading = profileUpdatePasswordViewModel.state == ProfileUpdatePasswordState.loading ||
        profileViewModel.state == ProfileViewState.loading;
    return Center(
      child: CostumButton(
        isLoading: isLoading,
        onPressed: () async {
          await profileUpdatePasswordViewModel.continueButtonOnTap(context, profileViewModel: profileViewModel);
        },
        childText: 'Continue',
      ),
    );
  }
}
