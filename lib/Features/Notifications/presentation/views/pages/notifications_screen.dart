import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:igenius/Features/Notifications/presentation/cubits/notifications_cubit.dart';
import 'package:igenius/core/resources/styles_manager.dart';
import 'package:igenius/core/utils/extensions/extensions.dart';
import 'package:igenius/core/utils/helpers/app_navigtion.dart';
import 'package:igenius/core/widgets/custom_text_button.dart';
import '../../../../../core/base/cubit/base_state.dart';
import '../../../../../core/theme/app_colors.dart';
import '../widgets/nofification_card.dart';
import '../widgets/notification_type.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<String> notificationTypes = ['All', 'Unread'];
  late final ScrollController _scrollController;

  NotificationsFilter _filterFromLabel(String type) {
    return type == 'Unread' ? NotificationsFilter.unread : NotificationsFilter.all;
  }

  String _labelFromFilter(NotificationsFilter filter) {
    return filter == NotificationsFilter.unread ? 'Unread' : 'All';
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
          context.read<GetNotificationsCubit>().loadMoreNotifications();
        }
      });
    context.read<GetNotificationsCubit>().getNotifications();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GetNotificationsCubit>();

    return SafeArea(
      child: BlocBuilder<GetNotificationsCubit, BaseCubitState>(
        builder: (context, state) {
          final notifications = cubit.allNotifications;

          // Loading (أول تحميل بس، لو لسه مفيش داتا)
          if (state is LoadingState && notifications.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // Error (لو مفيش داتا اتحملت قبل كده)
          if (state is ErrorState && notifications.isEmpty) {
            return Center(
              child: Text(state.message ?? 'Something went wrong'),
            );
          }

          return Column(
            children: [
              Container(
                padding: 10.rPadding,
                color: AppColors.white,
                child: Column(
                  children: [
                    notificationFakeAppBar(context),
                    CustomType(
                      CustomTypes: notificationTypes,
                      selectedType: _labelFromFilter(cubit.filter),
                      onTypeSelected: (type) {
                        cubit.changeFilter(_filterFromLabel(type ?? 'All'));
                      },
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: notifications.isEmpty
                      ? const Center(
                          child: Text('No Notifications available yet'),
                        )
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount:
                              notifications.length + (cubit.hasMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index >= notifications.length) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }
                            return NofificationCard(
                              notification: notifications[index],
                            );
                          },
                        ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget notificationFakeAppBar(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: IconButton(
        onPressed: () {
          AppNavaigation.pop();
        },
        icon: const Icon(Icons.arrow_back_ios),
        color: Colors.grey,
      ),
      title: Text('Notifications', style: AppsStyles.s16Bold),
      subtitle: Text(
        context.watch<GetNotificationsCubit>().unreadCount.toString(),
        style: AppsStyles.s12Regular.copyWith(color: Colors.grey),
      ),
      // trailing: CustomTextButton(
      //   fontWeight: FontWeight.bold,
      //   text: 'Mark all as read',
      //   color: AppColors.primary,
      //   onPressed: () {},
      // ),
    );
  }
}