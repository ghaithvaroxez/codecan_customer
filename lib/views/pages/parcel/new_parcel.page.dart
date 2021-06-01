import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/view_models/new_parcel.vm.dart';
import 'package:fuodz/views/pages/parcel/widgets/package_delivery_info.dart';
import 'package:fuodz/views/pages/parcel/widgets/package_delivery_parcel_info.dart';
import 'package:fuodz/views/pages/parcel/widgets/package_delivery_payment.dart';
import 'package:fuodz/views/pages/parcel/widgets/package_delivery_summary.dart';
import 'package:fuodz/views/pages/parcel/widgets/package_recipient_info.dart';
import 'package:fuodz/views/pages/parcel/widgets/package_type_selector.dart';
import 'package:fuodz/views/pages/parcel/widgets/vendor_package_type_selector.dart';
import 'package:im_stepper/stepper.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class NewParcelPage extends StatelessWidget {
  const NewParcelPage({this.onFinish,Key key}) : super(key: key);

  final Function onFinish;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewParcelViewModel>.reactive(
      viewModelBuilder: () => NewParcelViewModel(context, onFinish),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return VStack(
          [
            //

            DotStepper(
              dotCount: 7,
              dotRadius: 12,
              shape: Shape.stadium,
              indicator: Indicator.worm,
              activeStep: vm.activeStep,
              tappingEnabled: false,
              spacing: 10,
              indicatorDecoration: IndicatorDecoration(
                color: AppColor.primaryColor,
                strokeColor: AppColor.primaryColorDark,
              ),
            ).centered(),

            //
            PageView(
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              controller: vm.pageController,
              children: [
                //package type
                PackageTypeSelector(vm: vm),

                //vendors from sort delivery
                VendorPackageTypeSelector(vm: vm),

                //
                PackageDeliveryInfo(vm: vm),

                //receiver info
                PackageRecipientInfo(vm: vm),

                //parcel info
                PackageDeliveryParcelInfo(vm: vm),

                //summary
                PackageDeliverySummary(vm: vm),

                //PAYMENT
                PackageDeliveryPayment(vm: vm),
              ],
            ).box.make().px20().expand()
          ],
        );
      },
    );
  }
}
