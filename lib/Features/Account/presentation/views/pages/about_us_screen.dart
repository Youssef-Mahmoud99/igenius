import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:igenius/Features/Home/data/models/about_model.dart';
import 'package:igenius/Features/Home/presentation/cubits/get_about_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/base/cubit/base_state.dart';
import '../../../../../core/base/models/base_response.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/url_launcher_utils.dart';
import '../../../../../core/widgets/cached_network_image.dart';
import '../../../../../core/widgets/custom_appBar.dart';
import '../../../../../injection/service_locator.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'About Us',
        showBack: true,
        centerTitle: false,
      ),
      body: SafeArea(
        child: BlocBuilder<GetAboutCubit, BaseCubitState>(
          builder: (context, state) => _buildContent(context, state),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, BaseCubitState state) {
    if (state is ErrorState) {
      return Center(child: Text(state.message));
    }

    if (state is SuccessState) {
      final response = state.data as BaseResponse<AboutDataModel>;
      final aboutUs = response.data;

      if (aboutUs == null) {
        return const Center(child: Text('No content available'));
      }

      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (aboutUs.logo != null) _buildLogo(aboutUs.logo!),

              if (aboutUs.content != null && aboutUs.content!.isNotEmpty)
                dataCard(
                  Html(
                    data: aboutUs.content!,
                    style: {
                      "body": Style(
                        fontSize: FontSize(12.sp),
                        color: AppColors.grey,
                        margin: Margins.zero,
                        padding: HtmlPaddings.zero,
                      ),
                      "p": Style(margin: Margins.zero),
                    },
                  ),
                ),

              if (aboutUs.socialLinks != null)
                _buildSocialLinks(aboutUs.socialLinks!),
            ],
          ),
        ),
      );
    }

    return const Center(child: CircularProgressIndicator());
  }

  Widget _buildLogo(String logoUrl) {
    return dataCard(
      Center(
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
          ),
          child: CustomCachedNetworkImage(
            imageUrl: logoUrl,
            height: 60.h,
            width: 60.h,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLinks(SocialLinksModel links) {
    final items = <_SocialItem>[
      _SocialItem(
        icon: FontAwesomeIcons.facebook,
        color: const Color(0xff1877F2),
        url: links.facebook,
      ),
      _SocialItem(
        icon: FontAwesomeIcons.xTwitter,
        color: Colors.black,
        url: links.twitter,
      ),
      _SocialItem(
        icon: FontAwesomeIcons.instagram,
        color: const Color(0xffE1306C),
        url: links.instagram,
      ),
      _SocialItem(
        icon: FontAwesomeIcons.linkedin,
        color: const Color(0xff0A66C2),
        url: links.linkedin,
      ),
      _SocialItem(
        icon: FontAwesomeIcons.youtube,
        color: const Color(0xffFF0000),
        url: links.youtube,
      ),
      _SocialItem(
        icon: FontAwesomeIcons.tiktok,
        color: Colors.black,
        url: links.tiktok,
      ),
    ];

    return dataCard(
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Follow Us', style: AppsStyles.s14Bold),
          15.verticalSpace,
          Wrap(
            spacing: 15,
            runSpacing: 15,
            children: items.map((item) => _socialButton(item)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _socialButton(_SocialItem item) {
    final isActive = item.url != null && item.url!.isNotEmpty;

    return GestureDetector(
      onTap:
          isActive
              ? () {
                  UrlLauncherUtils.openLink(item.url!);
              }
              : null,
      child: Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color:
              isActive
                  ? item.color.withOpacity(0.1)
                  : AppColors.grey.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          item.icon,
          color: isActive ? item.color : AppColors.grey,
          size: 20.r,
        ),
      ),
    );
  }
  Widget dataCard(Widget child) {
    return Card(
      elevation: 10,
      shadowColor: Colors.grey.withOpacity(0.4),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      color: Colors.white,
      child: Padding(padding: const EdgeInsets.all(16.0), child: child),
    );
  }
}

class _SocialItem {
  final IconData icon;
  final Color color;
  final String? url;
  final bool isWhatsApp;

  const _SocialItem({
    required this.icon,
    required this.color,
    required this.url,
    this.isWhatsApp = false,
  });
}