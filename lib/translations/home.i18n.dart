import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Home",
        "fr": "Maison",
        "es": "Hogar",
        "de": "Zuhause",
        "pt": "Casa",
        "ar": "الصفحة الرئيسية",
        "ko": "집"
      } +
      {
        "en": "Orders",
        "fr": "Ordres",
        "es": "Pedidos",
        "de": "Aufträge",
        "pt": "Pedidos",
        "ar": "أوامر",
        "ko": "명령"
      } +
      {
        "en": "Cart",
        "fr": "Chariot",
        "es": "Carro",
        "de": "Wagen",
        "pt": "Carrinho",
        "ar": "عربة التسوق",
        "ko": "카트"
      } +
      {
        "en": "More",
        "fr": "Suite",
        "es": "Más",
        "de": "Mehr",
        "pt": "Mais",
        "ar": "أكثر",
        "ko": "더"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
