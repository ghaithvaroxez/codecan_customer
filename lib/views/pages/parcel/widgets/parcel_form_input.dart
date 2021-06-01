import 'package:flutter/material.dart';
import 'package:fuodz/utils/ui_spacer.dart';
import 'package:fuodz/widgets/custom_text_form_field.dart';
import 'package:velocity_x/velocity_x.dart';

class ParcelFormInput extends StatelessWidget {
  const ParcelFormInput({
    this.iconData,
    this.iconColor,
    this.labelText,
    this.hintText,
    this.isReadOnly = true,
    this.onInputTap,
    this.tec,
    this.keyboardType,
    this.icon,
    this.content,
    this.formValidator,
    Key key,
  }) : super(key: key);

  final IconData iconData;
  final Color iconColor;
  final String labelText;
  final String hintText;
  final bool isReadOnly;
  final Function onInputTap;
  final TextEditingController tec;
  final TextInputType keyboardType;

  //
  final Widget icon;
  final Widget content;
  final Function(String) formValidator;
  @override
  Widget build(BuildContext context) {
    return HStack(
      [
        //
        icon ??
            Icon(
              iconData,
              color: iconColor,
              size: 20,
            ),
        UiSpacer.horizontalSpace(),

        //
        VStack(
          [
            labelText.text.semiBold.make(),
            content ??
                CustomTextFormField(
                  hintText: hintText,
                  isReadOnly: isReadOnly,
                  underline: true,
                  onTap: onInputTap,
                  textEditingController: tec,
                  textInputAction: TextInputAction.next,
                  keyboardType: keyboardType,
                  validator: formValidator,
                ),
          ],
        ).expand(),
      ],
      crossAlignment: CrossAxisAlignment.start,
    );
  }
}
