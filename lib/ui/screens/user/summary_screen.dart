import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:my_users_app/app/dependency_injection.dart';
import 'package:my_users_app/config/config.dart';
import 'package:my_users_app/ui/blocs/user/user_bloc.dart';
import 'package:my_users_app/ui/widgets/widgets.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: AppBar(
        title: Text(context.l10n.summary),
      ),
      scaffoldBackgroundColor: ColorTheme.secondaryColor,
      expandedLayout: _MediumLayout(),
      mediumLayout: _MediumLayout(),
      child: _CompactLayout(),
    );
  }
}

class _CompactLayout extends StatelessWidget {
  const _CompactLayout();

  @override
  Widget build(BuildContext context) {
    return _BodyContainer(
      child: ListView(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: CircleAvatar(
              radius: context.dp(12),
              child: Icon(
                FluentIcons.person_28_filled,
                color: Colors.white,
                size: context.dp(16),
              ),
            ),
          ),
          const Gap(10),
          UserCard(),
          AddressList(),
          const Gap(16),
        ],
      ),
    );
  }
}

class _MediumLayout extends StatelessWidget {
  const _MediumLayout();

  @override
  Widget build(BuildContext context) {
    return _BodyContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: context.dp(6),
                child: Icon(
                  FluentIcons.person_28_filled,
                  color: Colors.white,
                  size: context.dp(8),
                ),
              ),
              const Gap(10),
              UserCard(),
            ],
          ),
          const Gap(16),
          AddressList(),
          const Gap(16),
        ],
      ),
    );
  }
}

class _BodyContainer extends StatelessWidget {
  final Widget child;
  const _BodyContainer({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ColorTheme.secondaryColor,
            Color(0xffaa44fd),
          ],
          stops: [0.25, 0.75],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}

class AddressList extends StatelessWidget {
  const AddressList({super.key});

  @override
  Widget build(BuildContext context) {
    final addresses = getIt.get<UserBloc>().state.address;

    return Container(
      width: context.width,
      constraints: BoxConstraints(
        maxHeight: context.hp(40),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: addresses.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                "#${index + 1} ${context.l10n.address}: ${addresses[index].name}"),
            titleTextStyle: context.textTheme.bodyMedium,
          );
        },
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({super.key});

  @override
  Widget build(BuildContext context) {
    final user = getIt.get<UserBloc>().state.user;
    return Container(
      constraints: BoxConstraints(
        maxWidth: context.wp(60),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                context.l10n.userInformation,
                style: context.textTheme.titleMedium,
              ),
              const Gap(10),
              Text(
                "${context.l10n.fullName}: ${user?.fullName}",
                style: context.textTheme.titleSmall,
              ),
              Text(
                "${context.l10n.dateBirth}: ${DateFormat(DateFormat.YEAR_MONTH_DAY).format(user!.dateBirth)}",
                style: context.textTheme.titleSmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
