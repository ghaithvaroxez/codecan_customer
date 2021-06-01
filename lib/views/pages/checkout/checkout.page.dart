import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/models/checkout.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/checkout.vm.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/translations/checkout.i18n.dart';
import 'package:fuodz/widgets/buttons/custom_button.dart';
import 'package:fuodz/widgets/cards/order_summary.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:fuodz/widgets/list_items/delivery_address.list_item.dart';
import 'package:fuodz/widgets/list_items/payment_method.list_item.dart';
import 'package:fuodz/widgets/states/delivery_address.empty.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({this.checkout, Key key}) : super(key: key);

  final CheckOut checkout;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CheckoutViewModel>.reactive(
      viewModelBuilder: () => CheckoutViewModel(context, checkout),
      onModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        return BasePage(
          showAppBar: true,
          showLeadingAction: true,
          title: "Checkout".i18n,
          body: VStack(
            [
              //If its pickup
              HStack(
                [
                  //
                  Checkbox(
                    value: vm.isPickup,
                    onChanged: vm.togglePickupStatus,
                  ),
                  //
                  VStack(
                    [
                      "Pickup Order".i18n.text.xl.semiBold.make(),
                      "Please indicate if you would come pickup order at the vendor"
                          .i18n
                          .text
                          .make(),
                    ],
                  ).expand(),
                ],
                crossAlignment: CrossAxisAlignment.start,
              ).wFull(context).onInkTap(
                    () => vm.togglePickupStatus(!vm.isPickup),
                  ),

              //
              Divider(thickness: 3).py12(),

              //delivery address pick preview
              vm.isPickup
                  ? UiSpacer.emptySpace()
                  : VStack(
                      [
                        //
                        HStack(
                          [
                            //
                            VStack(
                              [
                                "Delivery address".i18n.text.semiBold.xl.make(),
                                "Please select delivery address/location"
                                    .i18n
                                    .text
                                    .make(),
                              ],
                            ).expand(),
                            //
                            CustomButton(
                              title: "Change",
                              onPressed: vm.showDeliveryAddressPicker,
                            ),
                          ],
                        ),
                        //Selected delivery address box
                        DottedBorder(
                          borderType: BorderType.RRect,
                          color: context.accentColor,
                          strokeWidth: 1,
                          strokeCap: StrokeCap.round,
                          radius: Radius.circular(10),
                          dashPattern: [5, 6],
                          child: vm.deliveryAddress != null
                              ? DeliveryAddressListItem(
                                  deliveryAddress: vm.deliveryAddress,
                                  action: false,
                                  border: false,
                                  showDefault: false,
                                )
                              : EmptyDeliveryAddress(selection: true)
                                  .py12()
                                  .opacity(value: 0.60),
                        ).wFull(context).py12(),

                        //within vendor range
                        vm.delievryAddressOutOfRange
                            ? "Delivery address is out of vendor delivery range"
                                .i18n
                                .text
                                .sm
                                .red500
                                .make()
                            : UiSpacer.emptySpace(),

                        //
                        Divider(thickness: 3).py12(),
                      ],
                    ),

              //payment options
              "Payment Methods".i18n.text.semiBold.xl.make(),
              CustomListView(
                noScrollPhysics: true,
                dataSet: vm.paymentMethods,
                isLoading: vm.busy(vm.paymentMethods),
                itemBuilder: (context, index) {
                  //
                  final paymentMethod = vm.paymentMethods[index];
                  return PaymentOptionListItem(
                    paymentMethod,
                    selected: vm.isSelected(paymentMethod),
                    onSelected: vm.changeSelectedPaymentMethod,
                  );
                },
              ).pOnly(top: Vx.dp16),
              //note
              Divider(thickness: 3).py12(),
              CustomTextFormField(
                labelText: "Note".i18n,
                textEditingController: vm.noteTEC,
              ).pOnly(bottom: Vx.dp20),
              //order final price preview
              OrderSummary(
                subTotal: vm.checkout.subTotal,
                discount: vm.checkout.discount,
                deliveryFee: vm.checkout.deliveryFee,
                tax: vm.checkout.tax,
                vendorTax: vm.vendor.tax,
                total: vm.checkout.total,
              ),

              //
              CustomButton(
                title: "PLACE ORDER".i18n.padRight(14),
                icon: FlutterIcons.credit_card_fea,
                onPressed: vm.placeOrder,
                loading: vm.isBusy,
              ).centered().py16(),
            ],
          ).p20().scrollVertical(),
        );
      },
    );
  }
}
