import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:pos/core/core.dart';
import 'package:pos/features/features.dart';
import 'package:pos/utils/utils.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// Controller
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();

  bool _isPasswordVisible = false;

  /// Focus Node
  final _fnEmail = FocusNode();
  final _fnPassword = FocusNode();

  /// Global key
  final _formValidator = <String, bool>{};

  @override
  Widget build(BuildContext context) => Parent(
    child: BlocListener<AuthCubit, AuthState>(
      listener: (_, state) => switch (state) {
        AuthStateLoading() => context.show(),
        AuthStateSuccess() => (() {
          context.dismiss();

          TextInput.finishAutofillContext();
          context.goNamed(Routes.root.name);
        })(),
        AuthStateFailure(:final message) => (() {
          context.dismiss();
          message.toToastError(context);
        })(),
        _ => {},
      },
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: ListView(
            shrinkWrap: true,
            children: [
              SvgPicture.asset(
                Images.homeResto,
                width: Dimens.space100,
                height: Dimens.space100,
                colorFilter: ColorFilter.mode(
                  Theme.of(context).primaryColor,
                  BlendMode.srcIn,
                ),
              ),
              SpacerV(value: Dimens.space24),
              Text(
                ' Inisialkey Resto',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
              SpacerV(value: Dimens.space8),
              Text(
                'Akses Login Kasir',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
              SpacerV(value: Dimens.space40),
              _loginForm(),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _loginForm() => BlocBuilder<ReloadFormCubit, ReloadFormState>(
    builder: (context, state) => Column(
      children: [
        TextF(
          autoFillHints: const [AutofillHints.email],
          key: const Key('email'),
          focusNode: _fnEmail,
          textInputAction: TextInputAction.next,
          controller: _conEmail,
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icon(
            Icons.alternate_email,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
          hint: 'kasir@inisialkey.com',
          label: Strings.of(context)!.email,
          isValid: _formValidator.putIfAbsent('email', () => false),
          validatorListener: (String value) {
            _formValidator['email'] = value.isValidEmail();
            context.read<ReloadFormCubit>().reload();
          },
          errorMessage: Strings.of(context)!.errorInvalidEmail,
        ),
        SpacerV(value: Dimens.space8),
        TextF(
          autoFillHints: const [AutofillHints.password],
          key: const Key('password'),
          focusNode: _fnPassword,
          textInputAction: TextInputAction.done,
          controller: _conPassword,
          keyboardType: TextInputType.text,
          prefixIcon: Icon(
            Icons.lock_outline,
            color: Theme.of(context).textTheme.bodyLarge?.color,
          ),
          obscureText: !_isPasswordVisible,
          hint: 'pass123',
          label: Strings.of(context)!.password,
          suffixIcon: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            onPressed: () {
              _isPasswordVisible = !_isPasswordVisible;
              context.read<ReloadFormCubit>().reload();
            },
            icon: Icon(
              _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
            ),
          ),
          isValid: _formValidator.putIfAbsent('password', () => false),
          validatorListener: (String value) {
            _formValidator['password'] = value.length > 5;
            context.read<ReloadFormCubit>().reload();
          },
          errorMessage: Strings.of(context)!.errorPasswordLength,
        ),
        SpacerV(value: Dimens.space24),
        Button(
          title: Strings.of(context)!.login,
          width: double.maxFinite,
          onPressed: _formValidator.validate()
              ? () => context.read<AuthCubit>().login(
                  LoginParams(
                    email: _conEmail.text,
                    password: _conPassword.text,
                    osInfo: Platform.operatingSystem,
                    deviceInfo: Platform.localHostname,
                  ),
                )
              : null,
        ),
      ],
    ),
  );
}
