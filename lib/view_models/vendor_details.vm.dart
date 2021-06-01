import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_routes.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fuodz/models/product.dart';
import 'package:fuodz/requests/vendor.request.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/view_models/base.view_model.dart';
import 'package:velocity_x/velocity_x.dart';

class VendorDetailsViewModel extends MyBaseViewModel {
  //
  VendorDetailsViewModel(BuildContext context, this.vendor) {
    this.viewContext = context;
  }

  //
  VendorRequest _vendorRequest = VendorRequest();

  //
  Vendor vendor;
  final currencySymbol = AppStrings.currencySymbol;

  int get longestMenuProducts {
    int longestProducts = 1;
    vendor.menus.forEach((menu) {
      if (longestProducts < menu.products.length) {
        longestProducts = menu.products.length;
      }
    });
    return longestProducts;
  }

  //
  void getVendorDetails() async {
    //
    setBusy(true);

    try {
      vendor = await _vendorRequest.vendorDetails(vendor.id);
      clearErrors();
    } catch (error) {
      setError(error);
    }
    setBusy(false);
  }

  void productSelected(Product product) async {
    await viewContext.navigator.pushNamed(
      AppRoutes.product,
      arguments: product,
    );

    //
    notifyListeners();
  }
}
