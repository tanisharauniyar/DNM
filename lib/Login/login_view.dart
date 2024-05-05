import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_flip_builder/page_flip_builder.dart';
import 'package:searchfield/searchfield.dart';
import '../Core/Models/comapny_model.dart';
import '../dashboard/dashboard_view.dart';
import '../utills/Confrimation_dialogue.dart';
import '../utills/Widgets.dart';
import '../utills/themes.dart';
import 'login_logic.dart';
import 'login_state.dart';

@RoutePage()
class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginView> {
  FocusNode ddFocus = FocusNode();
  FocusNode ddFocus2 = FocusNode();

  final formKey = GlobalKey<FormState>();
  GlobalKey<PageFlipBuilderState> flipController =
      GlobalKey<PageFlipBuilderState>();

  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  int _index = 0;

  body(BuildContext context) {
    ///for mobile (hardware) arrow mobile ko chai
    return WillPopScope(
      onWillPop: () async {
        if (!Navigator.canPop(context)) {
          bool? value = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Colors.transparent,
                actionsPadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.all(50.h),
                titlePadding: EdgeInsets.zero,
                insetPadding: EdgeInsets.zero,
                buttonPadding: EdgeInsets.zero,
                iconPadding: EdgeInsets.zero,
                content: const ConfirmationDialog(
                  title: "Exit Confirmation",
                  description: "Are you sure you want to exit?",
                ),
              );
            },
          );
          if (value != null && value) {
            return true;
          } else {
            return false;
          }
        }
        return false;
      },
      child: Material(
        child: Stack(
          children: [
            Container(
              color: Colors.white,
              child: SafeArea(
                bottom: false,
                child: Scaffold(
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    actions: [
                      InkWell(
                        onTap: () {
                          // ref.watch(loginLogic.notifier).showNetworkSetupDialog();
                          flipController.currentState?.flip();
                        },
                        child: SizedBox(
                          width: 200.r,
                          height: 200.r,
                          child: Icon(
                            Icons.edit,
                            color: Themes.defaultGreenColor,
                            size: 90.r,
                          ),
                        ),
                      ),
                    ],
                    backgroundColor: Colors.white,
                    elevation: 0,
                  ),
                  body: PageFlipBuilder(
                    key: flipController,
                    interactiveFlipEnabled: false,
                    nonInteractiveAnimationDuration:
                        const Duration(milliseconds: 0),
                    flipAxis: Axis.horizontal,
                    frontBuilder: (BuildContext context) {
                      return Stack(
                        children: [
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 100.r, vertical: 20.r),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 100.r,
                                ),
                                // Center(
                                //   child: Image.asset(
                                //     "PngImages.synergyLogo",
                                //     width: 600.r,
                                //   ),
                                // ),
                                SizedBox(
                                  height: 50.r,
                                ),
                                // FlipPanel.builder(
                                //   direction: FlipDirection.down,
                                //   itemBuilder: (context, index) => Container(
                                //     alignment: Alignment.center,
                                //     width: 96.0,
                                //     height: 128.0,
                                //
                                //     // decoration: const BoxDecoration(
                                //     //   color: Colors.black,
                                //     //   borderRadius:
                                //     //       BorderRadius.all(Radius.circular(4.0)),
                                //     // ),
                                //     child: (ref
                                //             .watch(loginLogic)
                                //             .showNetworkSetup)
                                //         ? Container(
                                //             padding: EdgeInsets.symmetric(
                                //                 horizontal: 50.r),
                                //             margin: EdgeInsets.symmetric(
                                //                 horizontal: 50.w),
                                //             height: 800.r,
                                //             decoration: BoxDecoration(
                                //               color: Colors.white,
                                //               borderRadius:
                                //                   BorderRadius.circular(20.r),
                                //             ),
                                //             child: Column(
                                //               children: [
                                //                 50.verticalSpace,
                                //                 Text(
                                //                   "Network setup",
                                //                   style: Themes.heading1.copyWith(
                                //                     color:
                                //                         Themes.defaultGreenColor,
                                //                   ),
                                //                 ),
                                //                 50.verticalSpace,
                                //                 Widgets.textForm(
                                //                   context,
                                //                   "Ip address",
                                //                   ref
                                //                       .watch(loginLogic.notifier)
                                //                       .ipAddress,
                                //                   ref,
                                //                   ref
                                //                       .watch(loginLogic.notifier)
                                //                       .ipFocus,
                                //                 ),
                                //                 50.verticalSpace,
                                //                 Widgets.textForm(
                                //                   context,
                                //                   "Port",
                                //                   ref
                                //                       .watch(loginLogic.notifier)
                                //                       .port,
                                //                   ref,
                                //                   ref
                                //                       .watch(loginLogic.notifier)
                                //                       .portFocus,
                                //                 ),
                                //                 50.verticalSpace,
                                //                 Center(
                                //                   child: InkWell(
                                //                     onTap: () async {
                                //                       AppConfig.instance!
                                //                               .ipAddress =
                                //                           ref
                                //                               .watch(loginLogic
                                //                                   .notifier)
                                //                               .ipAddress
                                //                               .text;
                                //                       AppConfig.instance!.port =
                                //                           ref
                                //                               .watch(loginLogic
                                //                                   .notifier)
                                //                               .port
                                //                               .text;
                                //
                                //                       AppConfig
                                //                               .instance!.baseUrl =
                                //                           "http://${AppConfig.instance!.ipAddress}:${AppConfig.instance!.port}";
                                //
                                //                       bool success = await ref
                                //                           .watch(
                                //                               loginLogic.notifier)
                                //                           .fetchDatabaseList(
                                //                               AppConfig.instance!
                                //                                   .baseUrl);
                                //                       if (success) {
                                //                         ref
                                //                             .watch(loginLogic
                                //                                 .notifier)
                                //                             .hideNetworkSetupDialog();
                                //                         flipController
                                //                             .currentState
                                //                             ?.flip();
                                //                       }
                                //                     },
                                //                     child: AnimatedSwitcher(
                                //                       transitionBuilder:
                                //                           (Widget child,
                                //                               Animation<double>
                                //                                   animation) {
                                //                         return ScaleTransition(
                                //                             scale: animation,
                                //                             child: child);
                                //                       },
                                //                       duration: const Duration(
                                //                           milliseconds: 500),
                                //                       child: ref
                                //                                   .watch(
                                //                                       loginLogic)
                                //                                   .networkSetup ==
                                //                               true
                                //                           ? const Column(
                                //                               children: [
                                //                                 CircularProgressIndicator(
                                //                                   color: Themes
                                //                                       .defaultGreenColor,
                                //                                 ),
                                //                                 Text(
                                //                                     "Processing , Please wait")
                                //                               ],
                                //                             )
                                //                           : Container(
                                //                               width: 300.w,
                                //                               height: 150.r,
                                //                               padding: EdgeInsets
                                //                                   .symmetric(
                                //                                       vertical:
                                //                                           25.r),
                                //                               decoration:
                                //                                   BoxDecoration(
                                //                                 color: Themes
                                //                                     .defaultGreenColor,
                                //                                 borderRadius:
                                //                                     BorderRadius
                                //                                         .circular(
                                //                                             10.r),
                                //                               ),
                                //                               child: Center(
                                //                                 child: Text(
                                //                                   "OK",
                                //                                   style: Themes
                                //                                       .heading1
                                //                                       .copyWith(
                                //                                           color: Colors
                                //                                               .white,
                                //                                           fontSize:
                                //                                               50.r),
                                //                                 ),
                                //                               ),
                                //                             ),
                                //                     ),
                                //                   ),
                                //                 ),
                                //               ],
                                //             ),
                                //           )
                                //         : Container(
                                //             color: Colors.red,
                                //           ),
                                //   ),
                                //   itemsCount: 2,
                                //   period: const Duration(milliseconds: 20),
                                //   loop: 1,
                                // ),
                                Flexible(
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: const ColorScheme.light(
                                          primary: Themes.defaultGreenColor),
                                    ),
                                    child: Stepper(
                                      currentStep: _index,
                                      type: StepperType.horizontal,
                                      // connectorThickness: 0,
                                      margin: EdgeInsets.zero,
                                      elevation: 0,
                                      onStepCancel: () {
                                        if (_index > 0) {
                                          setState(() {
                                            _index -= 1;
                                          });
                                        }
                                      },
                                      onStepContinue: () {
                                        if (_index <= 0) {
                                          setState(() {
                                            _index += 1;
                                          });
                                        }
                                      },
                                      stepIconBuilder:
                                          (int index, StepState stepState) {
                                        return Container();
                                      },
                                      controlsBuilder: (BuildContext context,
                                          ControlsDetails details) {
                                        return Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (_index == 0)
                                              InkWell(
                                                onTap: () {
                                                  details.onStepContinue!();
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //             Dashboard()));
                                                },
                                                // onTap: () async {
                                                //   AppConfig.instance!.baseUrl =
                                                //   "http://${AppConfig.instance!.ipAddress}:${AppConfig.instance!.port}";
                                                //   if (ref
                                                //       .watch(loginLogic
                                                //       .notifier)
                                                //       .dbController
                                                //       .text !=
                                                //       "" ||
                                                //       ref
                                                //           .watch(loginLogic
                                                //           .notifier)
                                                //           .dbController
                                                //           .text
                                                //           .isNotEmpty) {
                                                //     Map res = await ref
                                                //         .watch(
                                                //         loginLogic.notifier)
                                                //         .signIn(
                                                //       ref
                                                //           .watch(loginLogic
                                                //           .notifier)
                                                //           .dbController
                                                //           .text,
                                                //       ref
                                                //           .watch(loginLogic
                                                //           .notifier)
                                                //           .userName
                                                //           .text,
                                                //       ref
                                                //           .watch(loginLogic
                                                //           .notifier)
                                                //           .password
                                                //           .text,
                                                //     );
                                                //     if (res['status']) {
                                                //       showToast(
                                                //           "Login Successful,\n Please select a company",
                                                //           position:
                                                //           ToastPosition
                                                //               .bottom);
                                                //       await ref
                                                //           .read(settingsProvider
                                                //           .notifier)
                                                //           .fetchCompany();
                                                //       details.onStepContinue!();
                                                //
                                                //       ref
                                                //           .watch(loginLogic
                                                //           .notifier)
                                                //           .fetchDateRange();
                                                //       ref.watch(loginLogic.notifier).fetchUserPreference();
                                                //
                                                //       ref
                                                //           .watch(loginLogic
                                                //           .notifier)
                                                //           .dbFocus
                                                //           .unfocus();
                                                //     } else {}
                                                //   } else {
                                                //     showToast(
                                                //         "Please select a database before logging in",
                                                //         position: ToastPosition
                                                //             .bottom);
                                                //   }
                                                // },
                                                child: AnimatedSwitcher(
                                                  transitionBuilder:
                                                      (Widget child,
                                                          Animation<double>
                                                              animation) {
                                                    return ScaleTransition(
                                                        scale: animation,
                                                        child: child);
                                                  },
                                                  duration: const Duration(
                                                      milliseconds: 500),
                                                  child: ref
                                                              .watch(loginLogic)
                                                              .status ==
                                                          LoginStatus.loggingIn
                                                      ? const Column(
                                                          children: [
                                                            CircularProgressIndicator(
                                                              color: Themes
                                                                  .primaryColor,
                                                            ),
                                                            Text("Processing")
                                                          ],
                                                        )
                                                      : Column(
                                                          children: [
                                                            Container(
                                                              width: 300.w,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          15),
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Themes
                                                                    .defaultGreenColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10.r),
                                                              ),
                                                              child: Center(
                                                                  child: Text(
                                                                "Log In",
                                                                style: Themes
                                                                    .heading1
                                                                    .copyWith(
                                                                        color: Colors
                                                                            .white),
                                                              )),
                                                            ),
                                                            20.verticalSpace,
                                                          ],
                                                        ),
                                                ),
                                              ),
                                            // if (_index == 1)
                                            //   TextButton(
                                            //     onPressed: details.onStepCancel,
                                            //     child:
                                            //         const Text('Back to Login'),
                                            //   ),
                                          ],
                                        );
                                      },
                                      steps: <Step>[
                                        Step(
                                          title: Text(
                                            'Login',
                                            style: TextStyle(
                                              color: _index == 0
                                                  ? Themes.defaultGreenColor
                                                  : Colors.black,
                                              fontSize: 40.r,
                                            ),
                                          ),
                                          isActive: _index == 0,
                                          state: _index == 0
                                              ? StepState.editing
                                              : StepState.complete,
                                          content: Container(
                                            alignment: Alignment.centerLeft,
                                            child: Form(
                                              key: formKey,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Widgets.textForm(
                                                      context,
                                                      "Username",
                                                      ref
                                                          .watch(loginLogic
                                                              .notifier)
                                                          .userName,
                                                      ref,
                                                      ref
                                                          .watch(loginLogic
                                                              .notifier)
                                                          .usernameFocus),
                                                  SizedBox(
                                                    height: 50.r,
                                                  ),
                                                  Widgets.textForm(
                                                      context,
                                                      "Password",
                                                      ref
                                                          .watch(loginLogic
                                                              .notifier)
                                                          .password,
                                                      ref,
                                                      ref
                                                          .watch(loginLogic
                                                              .notifier)
                                                          .passwordFocus),
                                                  SizedBox(
                                                    height: 50.r,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Step(
                                          title: Text(
                                            'Company Setup',
                                            style: TextStyle(
                                              color: _index == 1
                                                  ? Themes.defaultGreenColor
                                                  : Colors.black,
                                              fontSize: 40.r,
                                            ),
                                          ),
                                          isActive: _index == 1,
                                          content: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 50.r,
                                                vertical: 30.r),
                                            child: Column(
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "SettingsStrings.selectCompany",
                                                      style: TextStyle(
                                                        fontSize: 30.r,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    10.verticalSpace,
                                                    Container(
                                                      height: 150.r,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 20.r),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.r),
                                                      ),
                                                      child:
                                                          SearchField<Company>(
                                                        itemHeight: 150.r,
                                                        focusNode: ddFocus,
                                                        initialValue: null,
                                                        onSuggestionTap:
                                                            (value) {
                                                          // ref
                                                          //     .watch(
                                                          //         settingsProvider
                                                          //             .notifier)
                                                          //     .selectCompany(
                                                          //         value.item!);
                                                          // AppConfig.instance
                                                          //         ?.selectedCompany =
                                                          //     value.item;

                                                          ddFocus.unfocus();
                                                        },
                                                        suggestionItemDecoration:
                                                            BoxDecoration(
                                                          color: Colors.blueGrey
                                                              .withOpacity(0.1),
                                                          border: Border.all(
                                                              color: Colors
                                                                  .transparent),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.r),
                                                          shape: BoxShape
                                                              .rectangle,
                                                        ),
                                                        searchInputDecoration:
                                                            const InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                        ),
                                                        suggestionDirection:
                                                            SuggestionDirection
                                                                .up,
                                                        suggestionStyle:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .black),
                                                        suggestionsDecoration:
                                                            SuggestionDecoration(
                                                          color: Colors.blueGrey
                                                              .withOpacity(0.1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      20.r),
                                                        ),
                                                        suggestions: [],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                15.verticalSpace,
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      "SettingsStrings.selectBranch",
                                                      style: TextStyle(
                                                        fontSize: 30.r,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                    10.verticalSpace,
                                                    Container(
                                                      height: 150.r,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 20.r),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20.r),
                                                      ),
                                                      child: SearchField<
                                                              Branch>(
                                                          itemHeight: 150.r,
                                                          focusNode: ddFocus2,
                                                          suggestionDirection:
                                                              SuggestionDirection
                                                                  .up,
                                                          initialValue: null,
                                                          onSuggestionTap:
                                                              (value) {
                                                            ddFocus2.unfocus();
                                                          },
                                                          suggestionItemDecoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .transparent),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.r),
                                                            shape: BoxShape
                                                                .rectangle,
                                                          ),
                                                          searchInputDecoration:
                                                              const InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                          ),
                                                          suggestionStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                          suggestionsDecoration:
                                                              SuggestionDecoration(
                                                            color: Colors
                                                                .blueGrey
                                                                .withOpacity(
                                                                    0.1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.r),
                                                          ),
                                                          suggestions: []),
                                                    ),
                                                  ],
                                                ),
                                                30.verticalSpace,
                                                InkWell(
                                                  onTap: () {
                                                    ref
                                                        .watch(
                                                            loginLogic.notifier)
                                                        .pickImage(
                                                            ImageSource.camera);
                                                  },
                                                  child: Container(
                                                    height: 150.r,
                                                    width: 630.r,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.r),
                                                    decoration: BoxDecoration(
                                                      color: Colors.black
                                                          .withOpacity(0.1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.r),
                                                    ),
                                                    child: Center(
                                                      child: Text(
                                                        "Click photo",
                                                        style: TextStyle(
                                                            fontSize: 50.r,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                30.verticalSpace,
                                                if (ref
                                                        .watch(loginLogic)
                                                        .selectedImage !=
                                                    null)
                                                  Container(
                                                    height: 220.h,
                                                    width: 230.w,
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    child: ref
                                                                .watch(
                                                                    loginLogic)
                                                                .selectedImage !=
                                                            null
                                                        ? Image.file(
                                                            ref
                                                                .watch(
                                                                    loginLogic)
                                                                .selectedImage!,
                                                            fit: BoxFit.cover,
                                                          )
                                                        : null, // Display the selected image if available
                                                  ),
                                                30.verticalSpace,
                                                Center(
                                                  child: InkWell(
                                                    child: AnimatedSwitcher(
                                                      transitionBuilder:
                                                          (Widget child,
                                                              Animation<double>
                                                                  animation) {
                                                        return ScaleTransition(
                                                            scale: animation,
                                                            child: child);
                                                      },
                                                      duration: const Duration(
                                                          milliseconds: 500),
                                                      child: ref
                                                                  .watch(
                                                                      loginLogic)
                                                                  .status ==
                                                              LoginStatus
                                                                  .loggingIn
                                                          ? const Column(
                                                              children: [
                                                                CircularProgressIndicator(
                                                                  color: Themes
                                                                      .primaryColor,
                                                                ),
                                                                Text(
                                                                    "Processing")
                                                              ],
                                                            )
                                                          : InkWell(
                                                              onTap: () {
                                                                Navigator
                                                                    .pushReplacement(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              Dashboard()),
                                                                );
                                                              },
                                                              child: Container(
                                                                width: 300.w,
                                                                height: 150.r,
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                        vertical:
                                                                            25.r),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Themes
                                                                      .primaryColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.r),
                                                                ),
                                                                child: Center(
                                                                  child: Text(
                                                                    "OK",
                                                                    style: Themes
                                                                        .heading1
                                                                        .copyWith(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          50.r,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (ref.watch(loginLogic).connectionStatus)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.wifi,
                                        color: Colors.green,
                                      ),
                                      10.horizontalSpace,
                                      const Text(
                                        "Connected",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                    backBuilder: (BuildContext context) {
                      return InkWell(
                        onTap: () {},
                        child: Container(
                          child: Center(
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 50.r),
                              margin: EdgeInsets.symmetric(horizontal: 50.w),
                              height: 900.r,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: Column(
                                children: [
                                  50.verticalSpace,
                                  Text(
                                    "Network setup",
                                    style: Themes.heading1.copyWith(
                                      color: Themes.defaultGreenColor,
                                    ),
                                  ),
                                  50.verticalSpace,
                                  Widgets.textForm(
                                    context,
                                    "Ip address",
                                    ref.watch(loginLogic.notifier).ipAddress,
                                    ref,
                                    ref.watch(loginLogic.notifier).ipFocus,
                                  ),
                                  50.verticalSpace,
                                  Widgets.textForm(
                                    context,
                                    "Port",
                                    ref.watch(loginLogic.notifier).port,
                                    ref,
                                    ref.watch(loginLogic.notifier).portFocus,
                                  ),
                                  50.verticalSpace,
                                  Center(
                                    child: InkWell(
                                      // onTap: () async {
                                      //   AppConfig.instance!.ipAddress = ref
                                      //       .watch(loginLogic.notifier)
                                      //       .ipAddress
                                      //       .text;
                                      //   AppConfig.instance!.port = ref
                                      //       .watch(loginLogic.notifier)
                                      //       .port
                                      //       .text;
                                      //
                                      //   AppConfig.instance!.baseUrl =
                                      //       "http://${AppConfig.instance!.ipAddress}:${AppConfig.instance!.port}";
                                      //
                                      //   bool success = await ref
                                      //       .watch(loginLogic.notifier)
                                      //       .fetchDatabaseList(
                                      //           AppConfig.instance!.baseUrl);
                                      //   if (success) {
                                      //     ref
                                      //         .watch(loginLogic.notifier)
                                      //         .hideNetworkSetupDialog();
                                      //     flipController.currentState?.flip();
                                      //   }
                                      // },
                                      child: AnimatedSwitcher(
                                        transitionBuilder: (Widget child,
                                            Animation<double> animation) {
                                          return ScaleTransition(
                                              scale: animation, child: child);
                                        },
                                        duration:
                                            const Duration(milliseconds: 500),
                                        child: ref
                                                    .watch(loginLogic)
                                                    .networkSetup ==
                                                true
                                            ? const Column(
                                                children: [
                                                  CircularProgressIndicator(
                                                    color: Themes
                                                        .defaultGreenColor,
                                                  ),
                                                  Text(
                                                      "Processing , Please wait")
                                                ],
                                              )
                                            : Container(
                                                width: 300.w,
                                                height: 150.r,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 25.r),
                                                decoration: BoxDecoration(
                                                  color:
                                                      Themes.defaultGreenColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    "OK",
                                                    style: Themes.heading1
                                                        .copyWith(
                                                            color: Colors.white,
                                                            fontSize: 50.r),
                                                  ),
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            // if (ref.watch(loginLogic).showNetworkSetup)
          ],
        ),
      ),
    );
  }
}

// showDialog(
//     context: context,
//     builder: (context) {
//       return Dialog(
//         insetPadding: EdgeInsets.symmetric(horizontal: 50.w),
//         child: Container(
//           margin: EdgeInsets.symmetric(horizontal: 30.w),
//           height: 600.h,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20.r),
//           ),
//           child: Column(
//             children: [
//               50.verticalSpace,
//               Text(
//                 "Network setup",
//                 style: Themes.heading1.copyWith(
//                   color: Themes.tableHeaderColor,
//                 ),
//               ),
//               50.verticalSpace,
//               Widgets.textForm(
//                 context,
//                 "Ip address",
//                 ref.watch(loginLogic.notifier).ipAddress,
//                 ref,
//                 ref.watch(loginLogic.notifier).ipFocus,
//               ),
//               50.verticalSpace,
//               Widgets.textForm(
//                 context,
//                 "Port",
//                 ref.watch(loginLogic.notifier).port,
//                 ref,
//                 ref.watch(loginLogic.notifier).portFocus,
//               ),
//               50.verticalSpace,
//               Center(
//                 child: InkWell(
//                     onTap: () async {
//                       AppConfig.instance!.ipAddress = ref
//                           .watch(loginLogic.notifier)
//                           .ipAddress
//                           .text;
//                       AppConfig.instance!.port = ref
//                           .watch(loginLogic.notifier)
//                           .port
//                           .text;
//
//                       AppConfig.instance!.baseUrl =
//                           "http://${AppConfig.instance!.ipAddress}:${AppConfig.instance!.port}";
//
//                       bool success = await ref
//                           .watch(loginLogic.notifier)
//                           .fetchDatabaseList(
//                               AppConfig.instance!.baseUrl);
//                       if (success) {
//                         Navigator.of(context).pop();
//                       }
//                     },
//                     child: AnimatedSwitcher(
//                       transitionBuilder: (Widget child,
//                           Animation<double> animation) {
//                         return ScaleTransition(
//                             scale: animation, child: child);
//                       },
//                       duration:
//                           const Duration(milliseconds: 500),
//                       child: ref
//                                   .watch(loginLogic)
//                                   .networkSetup ==
//                               true
//                           ? const Column(
//                               children: [
//                                 CircularProgressIndicator(
//                                   color:
//                                       Themes.tableHeaderColor,
//                                 ),
//                                 Text("Processing")
//                               ],
//                             )
//                           : Container(
//                               width: 300.w,
//                               padding: EdgeInsets.symmetric(
//                                   vertical: 25.r),
//                               decoration: BoxDecoration(
//                                 color: Themes.tableHeaderColor,
//                                 borderRadius:
//                                     BorderRadius.circular(
//                                         10.r),
//                               ),
//                               child: Center(
//                                   child: Text(
//                                 "OK",
//                                 style: Themes.heading1.copyWith(
//                                     color: Colors.white),
//                               )),
//                             ),
//                     )),
//               ),
//             ],
//           ),
//         ),
//       );
//     });