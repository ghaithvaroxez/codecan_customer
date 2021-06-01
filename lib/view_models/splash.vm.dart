import 'dart:convert';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/constants/app_theme.dart';
import 'package:fuodz/requests/settings.request.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/services/firebase.service.dart';
import 'base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';

class SplashViewModel extends MyBaseViewModel {
  SplashViewModel(BuildContext context) {
    this.viewContext = context;
  }

  //
  SettingsRequest settingsRequest = SettingsRequest();

  //
  initialise() async {
    await loadAppSettings();
  }

  //

  //
  loadAppSettings() async {
    setBusy(true);
    try {
      final appSettingsObject = await settingsRequest.appSettings();
      //app settings
      await updateAppVariables(appSettingsObject.body["strings"]);
      //colors
      await updateAppTheme(appSettingsObject.body["colors"]);
      loadNextPage();
    } catch (error) {
      setError(error);
      print("Error loading app settings ==> $error");
    }
    setBusy(false);
  }

  //
  void updateAppVariables(dynamic json) async {
    //
    await AppStrings.saveAppSettingsToLocalStorage(jsonEncode(json));
  }

  //theme change
  updateAppTheme(dynamic colorJson) async {
    //
    await AppColor.saveColorsToLocalStorage(jsonEncode(colorJson));
    //change theme
    // await AdaptiveTheme.of(viewContext).reset();
    await AdaptiveTheme.of(viewContext).setTheme(
      light: AppTheme().lightTheme(),
      dark: AppTheme().darkTheme(),
      isDefault: true,
    );
    await AdaptiveTheme.of(viewContext).persist();
  }

  //
  loadNextPage() async {

    //
    if (AuthServices.firstTimeOnApp()) {
      viewContext.navigator
          .pushNamedAndRemoveUntil(AppRoutes.welcomeRoute, (route) => false);
    } else {
      viewContext.navigator
          .pushNamedAndRemoveUntil(AppRoutes.homeRoute, (route) => false);
    }

    //
    RemoteMessage initialMessage =
        await FirebaseService.firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      //
      FirebaseService.saveNewNotification(initialMessage);
      FirebaseService.selectNotification('');
    }
  }
}
