import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/constants/app_colors.dart';
import 'package:fuodz/services/validator.service.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/new_parcel.vm.dart';
import 'package:fuodz/views/pages/parcel/widgets/form_step_controller.dart';
import 'package:fuodz/views/pages/parcel/widgets/parcel_form_input.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/new_parcel.i18n.dart';

class PackageDeliveryInfo extends StatelessWidget {
  const PackageDeliveryInfo({this.vm, Key key}) : super(key: key);

  final NewParcelViewModel vm;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: vm.deliveryInfoFormKey,
      child: VStack(
        [
          //
          VStack(
            [
              "Delivery Info".i18n.text.xl.medium.make().py20(),
              //from
              ParcelFormInput(
                iconData: FlutterIcons.car_ant,
                iconColor: Colors.green[700],
                labelText: "FROM".i18n,
                hintText: "Pickup Location".i18n,
                tec: vm.fromTEC,
                onInputTap: vm.changePickupAddress,
                formValidator: (value) => FormValidator.validateEmpty(
                  value,
                  errorTitle: "Pickup Location".i18n,
                ),
              ),
              UiSpacer.formVerticalSpace(),

              //to
              ParcelFormInput(
                iconData: FlutterIcons.location_pin_ent,
                iconColor: Colors.red[700],
                labelText: "TO".i18n,
                hintText: "Dropoff Location".i18n,
                tec: vm.toTEC,
                onInputTap: vm.changeDropOffAddress,
                formValidator: (value) => FormValidator.validateEmpty(
                  value,
                  errorTitle: "Dropoff Location".i18n,
                ),
              ),
              UiSpacer.formVerticalSpace(),

              //date
              ParcelFormInput(
                iconData: FlutterIcons.calendar_ant,
                iconColor: AppColor.primaryColorDark,
                labelText: "DATE".i18n,
                hintText: "select".i18n,
                tec: vm.dateTEC,
                onInputTap: vm.changeDropOffDate,
                formValidator: (value) => FormValidator.validateEmpty(
                  value,
                  errorTitle: "DATE".i18n,
                ),
              ),
              UiSpacer.formVerticalSpace(),

              //time
              ParcelFormInput(
                iconData: FlutterIcons.clock_fea,
                iconColor: AppColor.primaryColorDark,
                labelText: "TIME".i18n,
                hintText: "select".i18n,
                tec: vm.timeTEC,
                onInputTap: vm.changeDropOffTime,
                formValidator: (value) => FormValidator.validateEmpty(
                  value,
                  errorTitle: "TIME".i18n,
                ),
              ),
            ],
          ).scrollVertical().expand(),

          //
          FormStepController(
            onPreviousPressed: () => vm.nextForm(1),
            onNextPressed: vm.validateDeliveryInfo,
          ),
        ],
      ),
    );
  }
}
