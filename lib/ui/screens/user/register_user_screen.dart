import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_starter_kit/app/dependency_injection.dart';
import 'package:flutter_starter_kit/config/config.dart';
import 'package:flutter_starter_kit/ui/cubits/register_user_cubit/register_user_cubit.dart';
import 'package:flutter_starter_kit/ui/widgets/widgets.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class RegisterUserScreen extends StatelessWidget {
  const RegisterUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveScaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.registerUser,
        ),
        centerTitle: true,
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
          child: Align(
            alignment: Alignment.center,
            child: _WrapperProviders(child: _FormContainer()),
          ),
        ),
      ),
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
          value: getIt.get<RegisterUserCubit>(),
        ),
      ],
      child: child,
    );
  }
}

class _FormContainer extends StatelessWidget {
  const _FormContainer();

  void _continue(BuildContext context) {
    context.pushNamed("manage_address");
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterUserCubit>();
    final state = context.watch<RegisterUserCubit>().state;
    return Container(
      constraints: BoxConstraints(maxWidth: 350),
      child: Card(
        elevation: 4.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _FormHeader(),
              const Gap(16),
              CustomTextFormField(
                label: context.l10n.name,
                hint: context.l10n.name,
                onChanged: cubit.firstNameChanged,
                errorMessage: state.firstName.errorMessage,
                initialValue: state.firstName.value,
              ),
              const Gap(10),
              CustomTextFormField(
                label: context.l10n.lastName,
                hint: context.l10n.lastName,
                onChanged: cubit.lastNameChanged,
                errorMessage: state.lastName.errorMessage,
                initialValue: state.lastName.value,
              ),
              const Gap(10),
              CustomDatePickerField(
                hintText: context.l10n.dateBirth,
                errorMessage: state.dateBirth.errorMessage,
                onChanged: cubit.dateBirthChanged,
                firstDate: DateTime(1990, 1, 1),
              ),
              const Gap(10),
              SizedBox(
                width: context.width,
                child: CustomButton(
                  onPressed: () {
                    bool isValid = cubit.onSubmit();
                    if (isValid) _continue(context);
                  },
                  label: context.l10n.continueBtn,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _FormHeader extends StatelessWidget {
  const _FormHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(FluentIcons.person_16_filled),
        const Gap(4),
        Text(
          context.l10n.registerUser,
          style: context.textTheme.titleMedium,
        ),
      ],
    );
  }
}
