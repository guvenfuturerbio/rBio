import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

import '../../../../core/core.dart';
import '../cubit/change_password_cubit.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(
        repository: getIt<Repository>(),
        userManager: getIt<UserManager>(),
        adjustManager: getIt<IAppConfig>().platform.adjustManager,
        sentryManager: getIt<IAppConfig>().platform.sentryManager,
        sharedPreferencesManager: getIt<ISharedPreferencesManager>(),
        firebaseAnalyticsManager: getIt<FirebaseAnalyticsManager>(),
      ),
      child: const ChangePasswordView(),
    );
  }
}

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  late TextEditingController _passwordController;
  late TextEditingController _passwordAgainController;
  late TextEditingController _oldPasswordController;

  late FocusNode _oldPasswordFocusNode;
  late FocusNode _passwordFocusNode;
  late FocusNode _passwordAgainFocusNode;

  @override
  void initState() {
    _passwordController = TextEditingController();
    _passwordAgainController = TextEditingController();
    _oldPasswordController = TextEditingController();

    _oldPasswordFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _passwordAgainFocusNode = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordAgainController.dispose();
    _oldPasswordController.dispose();

    _oldPasswordFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordAgainFocusNode.dispose();

    super.dispose();
  }

  final AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: KeyboardDismissOnTap(
        child: _buildScreen(),
      ),
    );
  }

  Widget _buildScreen() {
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state.status == ChangePasswordStatus.showDialog) {
          if (state.dialogTitle != null && state.dialogMessage != null) {
            showDialog(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return RbioMessageDialog(
                  description: state.dialogMessage!,
                  buttonTitle: LocaleProvider.current.Ok,
                  isAtom: false,
                );
              },
            );
          }
        } else if (state.status == ChangePasswordStatus.done) {
          formKey = GlobalKey<FormState>();
          _oldPasswordController.text = '';
          _passwordAgainController.text = '';
          _passwordController.text = '';
        } else if (state.status == ChangePasswordStatus.failure) {
          showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return RbioMessageDialog(
                description: LocaleProvider.current.something_went_wrong,
                buttonTitle: LocaleProvider.current.Ok,
                isAtom: false,
              );
            },
          );
        }
      },
      builder: (context, state) {
        return RbioStackedScaffold(
          resizeToAvoidBottomInset: true,
          isLoading: state.showProgressOverlay,
          appbar: _buildAppBar(),
          body: _buildBody(state),
        );
      },
    );
  }

  RbioAppBar _buildAppBar() {
    return RbioAppBar(
      context: context,
      title: RbioAppBar.textTitle(
        context,
        LocaleProvider.of(context).change_password,
      ),
    );
  }

  Widget _buildBody(ChangePasswordState state) {
    return KeyboardAvoider(
      autoScroll: true,
      child: RbioKeyboardActions(
        focusList: [
          _oldPasswordFocusNode,
          _passwordFocusNode,
          _passwordAgainFocusNode,
        ],
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //
              R.widgets.stackedTopPadding(context),

              //
              R.widgets.hSizer16,

              //
              Text(
                LocaleProvider.current.password_security,
                textAlign: TextAlign.center,
                style: context.xHeadline4.copyWith(
                  color: context.xPrimaryColor,
                ),
              ),

              //
              Container(
                margin: const EdgeInsets.only(bottom: 20, top: 20),
                child: RbioTextFormField(
                  autovalidateMode: autovalidateMode,
                  validator: (value) {
                    if (value?.isNotEmpty ?? false) {
                      return null;
                    } else {
                      return LocaleProvider.current.validation;
                    }
                  },
                  focusNode: _oldPasswordFocusNode,
                  controller: _oldPasswordController,
                  textInputAction: TextInputAction.next,
                  obscureText: state.oldPasswordVisibility ? false : true,
                  hintText: LocaleProvider.of(context).hint_input_old_password,
                  prefixIcon: SvgPicture.asset(
                    R.image.passwordSmall,
                    fit: BoxFit.none,
                  ),
                  suffixIcon: RbioVisibilitySuffixIcon(
                    eyesOpen: state.oldPasswordVisibility,
                    onTap: () {
                      context
                          .read<ChangePasswordCubit>()
                          .toggleOldPasswordVisibility(
                              state.oldPasswordVisibility);
                    },
                  ),
                  inputFormatters: <TextInputFormatter>[
                    TabToNextFieldTextInputFormatter(
                      context,
                      _oldPasswordFocusNode,
                      _passwordFocusNode,
                    ),
                  ],
                  onFieldSubmitted: (term) {
                    Utils.instance.fieldFocusChange(
                      context,
                      _oldPasswordFocusNode,
                      _passwordFocusNode,
                    );
                  },
                ),
              ),

              //
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: RbioTextFormField(
                  focusNode: _passwordFocusNode,
                  controller: _passwordController,
                  autovalidateMode: autovalidateMode,
                  validator: (value) {
                    if (value?.isNotEmpty ?? false) {
                      return null;
                    } else {
                      return LocaleProvider.current.validation;
                    }
                  },
                  textInputAction: TextInputAction.next,
                  obscureText: state.passwordVisibility ? false : true,
                  hintText: LocaleProvider.of(context).hint_input_password,
                  prefixIcon: SvgPicture.asset(
                    R.image.passwordAgain,
                    fit: BoxFit.none,
                  ),
                  suffixIcon: RbioVisibilitySuffixIcon(
                    onTap: () {
                      context
                          .read<ChangePasswordCubit>()
                          .togglePasswordVisibility(state.passwordVisibility);
                    },
                    eyesOpen: state.passwordVisibility,
                  ),
                  inputFormatters: <TextInputFormatter>[
                    TabToNextFieldTextInputFormatter(
                      context,
                      _passwordFocusNode,
                      _passwordAgainFocusNode,
                    ),
                  ],
                  onFieldSubmitted: (term) {
                    Utils.instance.fieldFocusChange(
                      context,
                      _passwordFocusNode,
                      _passwordAgainFocusNode,
                    );
                  },
                  onChanged: (text) {
                    context
                        .read<ChangePasswordCubit>()
                        .checkPasswordCapability(text);
                  },
                ),
              ),

              //
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: RbioTextFormField(
                  focusNode: _passwordAgainFocusNode,
                  controller: _passwordAgainController,
                  autovalidateMode: autovalidateMode,
                  validator: (value) {
                    if (value?.isNotEmpty ?? false) {
                      return null;
                    } else {
                      return LocaleProvider.current.validation;
                    }
                  },
                  textInputAction: TextInputAction.done,
                  obscureText: state.passwordAgainVisibility ? false : true,
                  hintText: LocaleProvider.of(context).password_again,
                  prefixIcon: SvgPicture.asset(
                    R.image.passwordAgain,
                    fit: BoxFit.none,
                  ),
                  suffixIcon: RbioVisibilitySuffixIcon(
                    onTap: () {
                      context
                          .read<ChangePasswordCubit>()
                          .togglePasswordAgainVisibility(
                              state.passwordAgainVisibility);
                    },
                    eyesOpen: state.passwordAgainVisibility,
                  ),
                  inputFormatters: <TextInputFormatter>[
                    TabToNextFieldTextInputFormatter(
                      context,
                      _passwordAgainFocusNode,
                      null,
                    ),
                  ],
                  onFieldSubmitted: (term) {
                    Utils.instance.fieldFocusChange(
                      context,
                      _passwordAgainFocusNode,
                      null,
                    );
                  },
                ),
              ),

              //
              _buildRow(
                state.checkNumeric,
                LocaleProvider.of(context).must_contain_digit,
              ),

              //
              _buildRow(
                state.checkUpperCase,
                LocaleProvider.of(context).must_contain_uppercase,
              ),

              //
              _buildRow(
                state.checkLowerCase,
                LocaleProvider.of(context).must_contain_lowercase,
              ),

              //
              _buildRow(
                state.checkSpecial,
                LocaleProvider.of(context).must_contain_special,
              ),

              //
              _buildRow(
                state.checkLength,
                LocaleProvider.of(context).password_must_8_char,
              ),

              //
              Container(
                margin: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: RbioElevatedButton(
                  infinityWidth: true,
                  title: LocaleProvider.of(context).update.toUpperCase(),
                  onTap: () {
                    if (formKey.currentState?.validate() ?? false) {
                      context.read<ChangePasswordCubit>().changePassword(
                            oldPassword: _oldPasswordController.text.trim(),
                            password: _passwordController.text.trim(),
                            passwordAgain: _passwordAgainController.text.trim(),
                          );
                    }
                  },
                ),
              ),

              //
              R.widgets.defaultBottomPadding,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(
    bool checkboxValue,
    String text,
  ) {
    final child = Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          //
          Expanded(
            child: Text(
              text,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: context.xHeadline5.copyWith(
                color: context.xTextInverseColor,
              ),
            ),
          ),

          //
          RbioCheckbox(
            value: checkboxValue,
            onChanged: (value) {},
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );

    if (checkboxValue) {
      return child;
    } else {
      return IgnorePointer(
        ignoring: true,
        child: Opacity(
          opacity: 0.3,
          child: child,
        ),
      );
    }
  }
}
