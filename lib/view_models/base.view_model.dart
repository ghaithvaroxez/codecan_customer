import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:fuodz/services/auth.service.dart';
import 'package:fuodz/services/location.service.dart';
import 'package:fuodz/widgets/bottomsheets/delivery_address_picker.bottomsheet.dart';
import 'package:geocoder/model.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class MyBaseViewModel extends BaseViewModel {
  //
  BuildContext viewContext;
  final formKey = GlobalKey<FormState>();
  final currencySymbol = AppStrings.currencySymbol;
  DeliveryAddress deliveryaddress = DeliveryAddress();
  String firebaseVerificationId;

  void initialise() {}
  // void initialise() {}

  //
  //open delivery address picker
  void pickDeliveryAddress() {
    //
    showModalBottomSheet(
        context: viewContext,
        builder: (context) {
          return DeliveryAddressPicker(
            allowOnMap: true,
            onSelectDeliveryAddress: (mDeliveryaddress) {
              viewContext.pop();
              deliveryaddress = mDeliveryaddress;
              notifyListeners();

              //
              final address = Address(
                coordinates: Coordinates(deliveryaddress.latitude, deliveryaddress.longitude),
                addressLine: deliveryaddress.address,
              );
              //
              LocationService.currenctAddress = address;
              //
              LocationService.currenctAddressSubject.sink.add(address);
            },
          );
        });
  }

  //
  bool isAuthenticated() {
    return AuthServices.authenticated();
  }

  //
  void openLogin() async {
    await viewContext.navigator.pushNamed(AppRoutes.loginRoute);
    notifyListeners();
  }

  //
  //
  Future<DeliveryAddress> showDeliveryAddressPicker() async {
    //
    DeliveryAddress selectedDeliveryAddress;

    //
    await showModalBottomSheet(
      context: viewContext,
      builder: (context) {
        return DeliveryAddressPicker(
          onSelectDeliveryAddress: (deliveryAddress) {
            viewContext.pop();
            selectedDeliveryAddress = deliveryAddress;
          },
        );
      },
    );

    return selectedDeliveryAddress;
  }
}
