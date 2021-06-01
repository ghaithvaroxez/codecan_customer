import 'package:flutter/material.dart';
import 'package:fuodz/constants/app_strings.dart';
import 'package:fuodz/models/search.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/view_models/search.vm.dart';
import 'package:fuodz/views/pages/search/widget/search.header.dart';
import 'package:fuodz/widgets/base.page.dart';
import 'package:fuodz/widgets/busy_indicator.dart';
import 'package:fuodz/widgets/custom_list_view.dart';
import 'package:fuodz/widgets/list_items/horizontal_product.list_item.dart';
import 'package:fuodz/widgets/list_items/vendor.list_item.dart';
import 'package:fuodz/widgets/states/vendor.empty.dart';
import 'package:fuodz/widgets/states/product.empty.dart';
import 'package:stacked/stacked.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:fuodz/translations/search.i18n.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key key, this.search}) : super(key: key);

  //
  final Search search;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchViewModel>.reactive(
      viewModelBuilder: () => SearchViewModel(context, search),
      builder: (context, model, child) {
        return BasePage(
          body: SafeArea(
            bottom: false,
            child: VStack(
              [
                //header
                SearchHeader(model),

                //Busy loading
                model.isBusy
                    ? BusyIndicator().centered()
                    : UiSpacer.emptySpace(),

                VStack(
                  [
                    //products
                    CustomListView(
                      noScrollPhysics: true,
                      justList: false,
                      isLoading: model.isBusy,
                      title: "Products".i18n.text.semiBold.xl.make().py12(),
                      dataSet: model.products,
                      itemBuilder: (context, index) {
                        //
                        final product = model.products[index];
                        return HorizontalProductListItem(
                          product,
                          onPressed: model.productSelected,
                        );
                      },
                      separatorBuilder: (context, index) => UiSpacer.verticalSpace(space: 5),
                      emptyWidget: EmptyProduct(),
                    )
                        //calculate height base on the items count
                        .h(model.products.isNotEmpty ? (model.products.length * 98.0) + 60 : 300),

                    ///
                    ///
                    ///
                    ///
                    // vendors
                    AppStrings.enableSingleVendor ? UiSpacer.verticalSpace() : CustomListView(
                      noScrollPhysics: true,
                      justList: false,
                      isLoading: model.isBusy,
                      title: "Vendors".i18n.text.semiBold.xl.make().py12(),
                      dataSet: model.vendors,
                      itemBuilder: (context, index) {
                        //
                        final vendor = model.vendors[index];
                        return VendorListItem(
                          vendor: vendor,
                          onPressed: model.vendorSelected,
                        );
                      },
                      separatorBuilder: (context, index) => UiSpacer.verticalSpace(space: 5),
                      emptyWidget: EmptyVendor(),
                    ).h(model.vendors.isNotEmpty ? (model.vendors.length * 300.0) + 120 : 300),
                  ],
                ).scrollVertical().expand(),
              ],
            ).px16(),
          ),
        );
      },
    );
  }
}
