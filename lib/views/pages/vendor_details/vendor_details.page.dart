import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fuodz/models/vendor.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/vendor_details.vm.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/buttons/call.button.dart';
import 'package:fuodz/widgets/buttons/route.button.dart';
import 'package:fuodz/widgets/custom_image.view.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/horizontal_product.list_item.dart';
import 'package:fuodz/widgets/tags/close.tag.dart';
import 'package:fuodz/widgets/tags/delivery.tag.dart';
import 'package:fuodz/widgets/tags/open.tag.dart';
import 'package:fuodz/widgets/tags/pickup.tag.dart';
import 'package:stacked/stacked.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/vendor_details.i18n.dart';

class VendorDetailsPage extends StatelessWidget {
  VendorDetailsPage({this.vendor, Key key}) : super(key: key);

  final Vendor vendor;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VendorDetailsViewModel>.reactive(
      viewModelBuilder: () => VendorDetailsViewModel(context, vendor),
      onModelReady: (model) => model.getVendorDetails(),
      builder: (context, model, child) {
        return BasePage(
          title: model.vendor.name,
          showAppBar: true,
          showLeadingAction: true,
          showCart: true,
          body: VStack(
            [
              //header
              Stack(
                children: [
                  //vendor image
                  Hero(
                    tag: model.vendor.heroTag,
                    child: CustomImage(
                      imageUrl: model.vendor.featureImage,
                      height: context.percentHeight * 25,
                    ).wFull(context),
                  ),

                  //vendor header
                  Positioned(
                    bottom: 0,
                    left: context.percentHeight * 1,
                    right: context.percentHeight * 1,
                    child: HStack(
                      [
                        //logo
                        CustomImage(
                          imageUrl: model.vendor.logo,
                          width: Vx.dp64 * 1,
                          height: Vx.dp64 * 1,
                        ).box.clip(Clip.antiAlias).roundedFull.make(),
                        //
                        VStack(
                          [
                            model.vendor.name.text.semiBold.xl2.make(),
                            model.vendor.address.text.light.base
                                .maxLines(1)
                                .make(),
                          ],
                        ).pOnly(left: Vx.dp12).expand(),
                      ],
                    ).p8().card.make(),
                  ),
                ],
              ),
              VStack(
                [
                  //tags
                  HStack(
                    [
                      //rating
                      HStack(
                        [
                          Icon(
                            FlutterIcons.star_ant,
                            size: 15,
                            color: Colors.yellow[800],
                          ).pOnly(right: 2),
                          model.vendor.rating.text.xl.make(),
                        ],
                        crossAlignment: CrossAxisAlignment.center,
                        alignment: MainAxisAlignment.center,
                      ).pOnly(right: 20),

                      //is open
                      model.vendor.isOpen == 1
                          ? OpenTag().pOnly(right: 10)
                          : CloseTag().pOnly(right: 10),

                      //can deliveree
                      model.vendor.delivery == 1
                          ? DeliveryTag().pOnly(right: 10)
                          : UiSpacer.emptySpace(),

                      //can pickup
                      model.vendor.pickup == 1
                          ? PickupTag().pOnly(right: 10)
                          : UiSpacer.emptySpace(),
                    ],
                    crossAlignment: CrossAxisAlignment.center,
                  ),
                  UiSpacer.verticalSpace(space: 10),

                  //description
                  "Description".i18n.text.sm.bold.uppercase.make(),
                  model.vendor.description.text.make(),
                  UiSpacer.verticalSpace(space: 10),

                  //address
                  HStack(
                    [
                      //
                      VStack(
                        [
                          "Address".i18n.text.sm.bold.uppercase.make(),
                          model.vendor.address.text.make(),
                        ],
                      ).expand(),

                      //location routing
                      (model.vendor.latitude.isNotBlank &&
                              model.vendor.longitude.isNotBlank)
                          ? RouteButton(model.vendor)
                          : UiSpacer.emptySpace(),
                    ],
                  ),
                  UiSpacer.verticalSpace(space: 10),

                  //PHONE
                  HStack(
                    [
                      //
                      VStack(
                        [
                          "Phone".i18n.text.sm.bold.uppercase.make(),
                          model.vendor.phone.text.make(),
                        ],
                      ).expand(),
                      //location routing
                      (model.vendor.latitude.isNotBlank &&
                              model.vendor.longitude.isNotBlank)
                          ? CallButton(model.vendor)
                          : UiSpacer.emptySpace(),
                    ],
                  ),
                ],
              ).p20(),
              UiSpacer.divider(),
              UiSpacer.verticalSpace(space: 10),

              //
              DefaultTabController(
                length: model.vendor.menus.length ?? 0, // Number of Tabs
                child: StickyHeader(
                  header: Container(
                    height: 50.0,
                    width: double.infinity,
                    color: context.theme.primaryColor,
                    child: TabBar(
                      isScrollable: true,
                      indicatorColor: Colors.white,
                      indicatorWeight: 2,
                      tabs: model.vendor.menus.map((menu) {
                        return Tab(
                          text: menu.name,
                        );
                      }).toList(),
                    ),
                  ),
                  content: model.isBusy
                      ? BusyIndicator().p20().centered()
                      : Container(
                          height:
                              double.parse((model.longestMenuProducts * 110).toString()),
                          child: TabBarView(
                            // controller: _tabController,
                            children: model.vendor.menus.map((menu) {
                              //
                              return CustomListView(
                                noScrollPhysics: true,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                dataSet: menu.products,
                                itemBuilder: (context, index) {
                                  //
                                  final product = menu.products[index];
                                  return HorizontalProductListItem(
                                    product,
                                    onPressed: model.productSelected,
                                  );
                                },
                                separatorBuilder: (context, index) =>
                                    UiSpacer.verticalSpace(space: 5),
                              );
                            }).toList(),
                          ),
                        ),
                ),
              ),
            ],
          ).pOnly(bottom: context.percentHeight * 30).scrollVertical(),
        );
      },
    );
  }
}
