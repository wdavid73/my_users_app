import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_starter_kit/app/dependency_injection.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/ui/blocs/user/user_bloc.dart';
import 'package:flutter_starter_kit/ui/widgets/widgets.dart';
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
      child: Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: context.dp(12),
                child: Icon(
                  FluentIcons.person_28_filled,
                  color: Colors.white,
                  size: context.dp(16),
                ),
              ),
              const Gap(10),
              _UserCard(),
              _AddressLIst(),
              const Gap(16),
            ],
          ),
        ),
      ),
    );
  }
}

class _AddressLIst extends StatelessWidget {
  const _AddressLIst();

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

class _UserCard extends StatelessWidget {
  const _UserCard();

  @override
  Widget build(BuildContext context) {
    final user = getIt.get<UserBloc>().state.user;
    return Card(
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
    );
  }
}
