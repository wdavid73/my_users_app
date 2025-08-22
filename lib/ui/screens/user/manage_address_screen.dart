import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/app/dependency_injection.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/ui/cubits/cubits.dart';
import 'package:flutter_starter_kit/ui/widgets/widgets.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:animate_do/animate_do.dart';

class ManageAddressScreen extends StatelessWidget {
  const ManageAddressScreen({super.key});

  void _continue(BuildContext context) {
    context.pushNamed("summary");
  }

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: AppBar(
        title: Text("Manage Address"),
      ),
      scaffoldBackgroundColor: ColorTheme.secondaryColor,
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
          child: _WrapperProviders(
            child: _Body(
              onContinue: () => _continue(context),
            ),
          ),
        ),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  final void Function() onContinue;
  const _Body({required this.onContinue});

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ManageAddressCubit>();
    return Column(
      children: [
        Expanded(child: AddressList()),
        const Gap(10),
        Container(
          constraints: BoxConstraints(
            maxWidth: 350,
          ),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(context.l10n.inputAddress),
                  const Gap(10),
                  _InputRegisterAddress(
                    controller: _controller,
                  ),
                  const Gap(10),
                ],
              ),
            ),
          ),
        ),
        const Gap(10),
        Container(
          constraints: BoxConstraints(
            maxWidth: 350,
          ),
          child: CustomButton(
            onPressed: () {
              bool isValid = cubit.saveAddress();
              if (isValid == true) {
                widget.onContinue();
                return;
              }

              if (isValid == false) {
                CustomSnackBar.showSnackBar(
                  context,
                  message: context.l10n.registerAlmostOneAddress,
                  icon: FluentIcons.error_circle_20_filled,
                );
              }
            },
            label: context.l10n.continueBtn,
            buttonType: CustomButtonType.elevated,
            backgroundColor: ColorTheme.accentColor,
          ),
        )
      ],
    );
  }
}

class _InputRegisterAddress extends StatelessWidget {
  final TextEditingController controller;

  const _InputRegisterAddress({
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ManageAddressCubit>();
    return CustomTextFormField(
      label: context.l10n.newAddress,
      hint: context.l10n.newAddress,
      controller: controller,
      onFieldSubmitted: (val) {
        if (val.trim().isNotEmpty) {
          cubit.registerAddress(val.trim());
          controller.clear();
        }
      },
    );
  }
}

class _WrapperProviders extends StatelessWidget {
  final Widget child;
  const _WrapperProviders({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: getIt.get<ManageAddressCubit>(),
        ),
      ],
      child: child,
    );
  }
}

class AddressList extends StatelessWidget {
  const AddressList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ManageAddressCubit>();
    final state = context.watch<ManageAddressCubit>().state;
    if (state.address.isEmpty) {
      return Center(
        child: Text(
          context.l10n.addressListEmpty,
          style: context.textTheme.bodyLarge?.copyWith(
            color: Colors.white,
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: state.address.length,
      itemBuilder: (context, index) {
        final addressModel = state.address[index];
        return SlideInRight(
          child: Card(
            elevation: 4.0,
            child: ListTile(
              title: Text("${context.l10n.address}: ${addressModel.name}"),
              trailing: CustomButton(
                onPressed: () => cubit.removeAddress(index),
                buttonType: CustomButtonType.icon,
                icon: Icon(
                  FluentIcons.dismiss_16_filled,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
