import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/delivery_address.dart';
import 'package:fuodz/requests/delivery_address.request.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/delivery_address/new_delivery_address.i18n.dart';

class NewDeliveryAddressesViewModel extends MyBaseViewModel {
  //
  DeliveryAddressRequest deliveryAddressRequest = DeliveryAddressRequest();
  TextEditingController nameTEC = TextEditingController();
  TextEditingController addressTEC = TextEditingController();
  bool isDefault = false;
  DeliveryAddress deliveryAddress = new DeliveryAddress();

  //
  NewDeliveryAddressesViewModel(BuildContext context) {
    this.viewContext = context;
  }

  openLocationPicker() async {
    LocationResult locationResult = await showLocationPicker(
      viewContext,
      AppStrings.googleMapApiKey,
      language: I18n.language,
      countries: [AppStrings.countryCode],
    );

    if (locationResult != null) {
      addressTEC.text = locationResult.address;
      deliveryAddress.address = locationResult.address;
      deliveryAddress.latitude = locationResult.latLng.latitude;
      deliveryAddress.longitude = locationResult.latLng.longitude;
      // From coordinates
      setBusy(true);
      final coordinates = new Coordinates(
        locationResult.latLng.latitude,
        locationResult.latLng.longitude,
      );
      //
      final addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates,
      );
      deliveryAddress.city = addresses.first.locality;
      setBusy(false);
      notifyListeners();
    }
  }

  void toggleDefault(bool value) {
    isDefault = value;
    deliveryAddress.isDefault = isDefault ? 1 : 0;
    notifyListeners();
  }

  //
  saveNewDeliveryAddress() async {
    if (formKey.currentState.validate()) {
      //
      deliveryAddress.name = nameTEC.text;
      //
      setBusy(true);
      //
      final apiRespose = await deliveryAddressRequest.saveDeliveryAddress(
        deliveryAddress,
      );

      //
      CoolAlert.show(
        context: viewContext,
        type: apiRespose.allGood ? CoolAlertType.success : CoolAlertType.error,
        title: "New Delivery Address".i18n,
        text: apiRespose.message,
        onConfirmBtnTap: () {
          viewContext.pop();
          viewContext.pop(true);
        },
      );
      //
      setBusy(false);
    }
  }
}
