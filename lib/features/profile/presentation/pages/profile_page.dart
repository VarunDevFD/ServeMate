import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:serve_mate/features/profile/domain/entities/user_entity.dart';
import 'package:serve_mate/features/profile/presentation/bloc/profile_bloc/profile_bloc_bloc.dart';
import 'package:serve_mate/features/profile/presentation/bloc/profile_bloc/profile_bloc_state.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:serve_mate/core/theme/app_colors.dart';
import 'package:serve_mate/features/profile/presentation/widgets/profile_delete_account_widget.dart';
import 'package:serve_mate/features/profile/presentation/widgets/profile_image_widget.dart';
import 'package:serve_mate/features/profile/presentation/widgets/profile_info_widget.dart';
import 'package:serve_mate/features/profile/presentation/widgets/profile_name_email_widget.dart';
import 'package:serve_mate/features/profile/presentation/widgets/profile_privacypolicy_widget.dart';
import 'package:serve_mate/features/profile/presentation/widgets/profile_quotes_widgets.dart';
import 'package:serve_mate/features/profile/presentation/widgets/profile_settings_widget.dart';
import 'package:serve_mate/features/profile/presentation/widgets/profile_sign_out_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          // Choose user data based on state
          final user = switch (state) {
            ProfileInitial() => state.user,
            ProfileLoaded() => state.user,
            _ => UserEntity.empty(), // fallback in case
          };
          return ListView(
            children: [
              ImageProfile(imageUrl: user?.profileImageUrl),
              SizedBox(height: 16.h),
              NameEmailProfile(name: user?.name, email: user?.email),
              SizedBox(height: 24.h),
              ProfileQuotesWidgets(quote: user?.quote),
              SizedBox(height: 24.h),
              const Divider(),
              const ProfileSignOutWidget(),
              const Divider(),
              const ProfileDeleteAccountWidget(),
              const Divider(),
              const ProfileSettingsWidget(),
              const Divider(),
              const ProfileInfoWidget(),
              const Divider(),
              const ProfilePrivacypolicyWidget(),
            ],
          );
        },
      ),
    );
  }
}
