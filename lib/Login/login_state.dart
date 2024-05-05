import 'dart:io';

import 'package:flutter/foundation.dart';

enum LoginStatus {
  idle,
  loggingIn,
}

@immutable
class LoginState {
  final LoginStatus status;
  final bool networkSetup;
  final bool biometricLogin;
  final bool connectionStatus;
  final bool showNetworkSetup;
  final bool isBiometricAvailable;
  final bool obscure;
  final bool canCheckBiometrics;
  final bool settingNetwork;
  final List<String> dbList;
  final File? selectedImage;

  const LoginState({
    this.status = LoginStatus.idle,
    this.networkSetup = false,
    this.biometricLogin = false,
    this.connectionStatus = false,
    this.showNetworkSetup = false,
    this.isBiometricAvailable = false,
    this.canCheckBiometrics = false,
    this.obscure = true,
    this.settingNetwork = false,
    this.dbList = const [],
    this.selectedImage,
  });

  LoginState copyWith({
    LoginStatus? status,
    bool? networkSetup,
    bool? connectionStatus,
    bool? showNetworkSetup,
    bool? isBiometricAvailable,
    bool? canCheckBiometrics,
    bool? obscure,
    bool? biometricLogin,
    bool? settingNetwork,
    String? errorMessage,
    List<String>? dbList,
    File? selectedImage,
  }) {
    return LoginState(
      biometricLogin: biometricLogin ?? this.biometricLogin,
      connectionStatus: connectionStatus ?? this.connectionStatus,
      showNetworkSetup: showNetworkSetup ?? this.showNetworkSetup,
      networkSetup: networkSetup ?? this.networkSetup,
      status: status ?? this.status,
      obscure: obscure ?? this.obscure,
      canCheckBiometrics: canCheckBiometrics ?? this.canCheckBiometrics,
      isBiometricAvailable: isBiometricAvailable ?? this.isBiometricAvailable,
      settingNetwork: settingNetwork ?? this.settingNetwork,
      dbList: dbList ?? this.dbList,
      selectedImage: selectedImage ?? this.selectedImage,
    );
  }
}