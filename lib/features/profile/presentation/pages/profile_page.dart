import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      body: Padding(
        padding: EdgeInsets.all(16.r),
        child: ListView(
          children: [
            const ImageProfile(),
            SizedBox(height: 16.h),
            const NameEmailProfile(),
            SizedBox(height: 24.h),
            const ProfileQuotesWidgets(),
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
        ),
      ),
    );
  }
}
