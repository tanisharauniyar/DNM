import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:oktoast/oktoast.dart';
import '../Core/Appconfig.dart';
import 'login_state.dart';

final loginLogic =
    StateNotifierProvider<LoginLogic, LoginState>((ref) => LoginLogic(ref));

class LoginLogic extends StateNotifier<LoginState> {
  final StateNotifierProviderRef ref;

  LoginLogic(this.ref) : super(const LoginState());

  TextEditingController ipAddress = TextEditingController(text: "202.79.34.39");
  TextEditingController port = TextEditingController(text: "3030");
  TextEditingController userName = TextEditingController(text: "");
  TextEditingController password = TextEditingController(text: "");
  TextEditingController dbController = TextEditingController();
  File? image;

  FocusNode ipFocus = FocusNode();

  final ImagePicker _imagePicker = ImagePicker();
  FocusNode portFocus = FocusNode();
  FocusNode usernameFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();
  FocusNode dbFocus = FocusNode();
  bool obscure = true;
  bool connectionStatus = false;
  bool signingIn = false;

  togglePasswordView() {
    state = state.copyWith(obscure: !state.obscure);
  }

  setConnectionStatus(bool status) {
    state = state.copyWith(connectionStatus: status);
  }

  Future<bool> fetchDatabaseList(url) async {
    state = state.copyWith(networkSetup: true);
    Dio dio = Dio();
    try {
      Response res = await dio.get("$url/db");
      List<String> database = [];
      res.data.forEach((e) => database.add(e.toString()));
      AppConfig.instance!.databaseList = database;
      state = state.copyWith(dbList: database, networkSetup: false);
      showToast("Network setup successful", position: ToastPosition.bottom);
      setConnectionStatus(true);
      return true;
    } on DioException catch (e) {
      state = state.copyWith(networkSetup: false);

      showToast("Something went wrong during network setup",
          position: ToastPosition.bottom);
      setConnectionStatus(false);

      return false;
    }
  }

  showNetworkSetupDialog() {
    state = state.copyWith(showNetworkSetup: true);
  }

  hideNetworkSetupDialog() {
    state = state.copyWith(showNetworkSetup: false);
  }

  getBiometricList() async {
    final LocalAuthentication auth = LocalAuthentication();
    final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
    final bool canAuthenticate =
        canAuthenticateWithBiometrics || await auth.isDeviceSupported();
    try {
      final List<BiometricType> availableBiometrics =
          await auth.getAvailableBiometrics();
      if (availableBiometrics.isNotEmpty) {
        for (var element in availableBiometrics) {}
      }

      if (availableBiometrics.contains(BiometricType.strong) ||
          availableBiometrics.contains(BiometricType.face)) {}
    } catch (e) {}
  }

  Future<void> authenticate() async {
    final LocalAuthentication auth = LocalAuthentication();

    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: "Scan your finger to authenticate",
      );
    } on PlatformException catch (e) {}
  }

  setBioLoggingInStatus(bool loginStatus) {
    state = state.copyWith(biometricLogin: loginStatus);
  }

  signIn(dbUser, userName, password) async {
    state = state.copyWith(status: LoginStatus.loggingIn);

    // Map response = await ref.watch(userRepositoryProvider).login(
    //       dbUser: dbUser,
    //       userName: userName,
    //       password: password,
    //     );
    //
    // if (response['status'] == true && response['token'] != null) {
    //   SharedPreferences pref = await SharedPreferences.getInstance();
    //   pref.setString("token", response['token']);
    // }
    //
    // state = state.copyWith(status: LoginStatus.idle);
    //
    // return response;
  }

  // saveLoginDetails({
  //   required String username,
  //   required String password,
  //   required String dbUser,
  //   required String ip,
  //   required String port,
  //   required Company selectedCompany,
  //   required Branch selectedBranch,
  // }) async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //
  //   Map data = {
  //     "ip": ip,
  //     "port": port,
  //     "database": dbUser,
  //     "username": username,
  //     "password": password,
  //     "selected_company": selectedCompany.toJson(),
  //     "selected_branch": selectedBranch.toJson(),
  //   };
  //   pref.setString("userCredentials", jsonEncode(data));
  // }

  // getLoginDetails() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? userdata = pref.getString("userCredentials");
  //
  //   if (userdata != null) {
  //     Map data = jsonDecode(userdata);
  //
  //     AppConfig.instance!.ipAddress = data['ip'];
  //     AppConfig.instance!.port = data['port'];
  //     AppConfig.instance!.baseUrl =
  //         "http://${AppConfig.instance!.ipAddress}:${AppConfig.instance!.port}";
  //
  //     await fetchDateRange();
  //     await fetchUserPreference();
  //     await ref.watch(settingsProvider.notifier).fetchCompany();
  //
  //     ref
  //         .watch(settingsProvider.notifier)
  //         .selectCompany(Company.fromJson(data['selected_company']));
  //     ref
  //         .watch(settingsProvider.notifier)
  //         .selectBranch(Branch.fromJson(data['selected_branch']));
  //   }
  // }

  // pickImage(ImageSource source) async {
  //   ImagePicker imagePicker = ImagePicker();
  //   XFile? pickedImage = await imagePicker.pickImage(source: source);
  //   if (pickedImage != null) {
  //     return File(pickedImage.path);
  //   }
  //   return null;
  // }
  //
  // selectImage(ImageSource source) async {
  //   File? img = await pickImage(source);
  //   image = img;
  // }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedImage = await _imagePicker.pickImage(source: source);
      if (pickedImage != null) {
        File image = File(pickedImage.path);
        state = state.copyWith(selectedImage: image);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
  // selectImage(File image){
  //   state = state.copyWith(selectedImage: image);
  // }
}