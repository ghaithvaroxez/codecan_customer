import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/vendor.vm.dart';
import 'package:fuodz/views/pages/vendor/widgets/banners.view.dart';
import 'package:fuodz/views/pages/vendor/widgets/best_selling_products.view.dart';
import 'package:fuodz/views/pages/vendor/widgets/categories.view.dart';
import 'package:fuodz/views/pages/vendor/widgets/for_you_products.view.dart';
import 'package:fuodz/views/pages/vendor/widgets/header.view.dart';
import 'package:fuodz/views/pages/vendor/widgets/nearby_vendors.view.dart';
import 'package:fuodz/views/pages/vendor/widgets/top_vendors.view.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class VendorPage extends StatefulWidget {
  const VendorPage({Key key}) : super(key: key);

  @override
  _VendorPageState createState() => _VendorPageState();
}

class _VendorPageState extends State<VendorPage>
    with AutomaticKeepAliveClientMixin<VendorPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BasePage(
      body: ViewModelBuilder<VendorViewModel>.reactive(
        viewModelBuilder: () => VendorViewModel(context),
        onModelReady: (model) => model.initialise(),
        builder: (context, model, child) {
          return VStack(
            [
              //
              VendorHeader(model: model),

              VStack(
                [
                  //
                  Banners(),
                  //
                  Categories(),

                  //best selling
                  BestSellingProducts(),

                  //For you
                  ForYouProducts(),

                  //nearby vendors
                  AppStrings.enableSingleVendor ? UiSpacer.emptySpace() : NearByVendors(),
                  //
                  AppStrings.enableSingleVendor ? UiSpacer.verticalSpace() : TopVendors(),
                ],
              ).scrollVertical().expand(),
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
