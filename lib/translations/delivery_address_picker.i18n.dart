import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  //en,fr,es,de
  static var _t = Translations("en") +
      {
        "en": "Delivery address",
        "fr": "Adresse de livraison",
        "es": "Dirección de entrega",
        "de": "Lieferadresse",
        "pt": "Endereço de entrega",
        "ar": "عنوان التسليم",
        "ko": "배달 주소"
      } +
      {
        "en": "Select order delivery address",
        "fr": "Sélectionnez l'adresse de livraison de la commande",
        "es": "Seleccione la dirección de entrega del pedido",
        "de": "Wählen Sie die Lieferadresse der Bestellung",
        "pt": "Selecione o endereço de entrega do pedido",
        "ar": "حدد عنوان تسليم الطلب",
        "ko": "주문 배송 주소 선택"
      } +
      {
        "en": "New",
        "fr": "Nouveau",
        "es": "Nuevo",
        "de": "Neu",
        "pt": "Novo",
        "ar": "جديد",
        "ko": "새로운"
      } +
      {
        "en": "Choose on map",
        "fr": "Choisissez sur la carte",
        "es": "Elija en el mapa",
        "de": "Wählen Sie auf der Karte",
        "pt": "Escolha no mapa",
        "ar": "اختر على الخريطة",
        "ko": "지도에서 선택"
      } +
      {
        "en": "Location Permission Request",
        "fr": "Demande d'autorisation d'emplacement",
        "es": "Solicitud de permiso de ubicación",
        "de": "Standortgenehmigungsanforderung",
        "pt": "Pedido de permissão de localização",
        "ar": "طلب إذن الموقع",
        "ko": "위치 권한 요청"
      } +
      {
        "en":
            "requires your location permission to show you nearby vendors and setup delivery address/loocationn duirng checkout",
        "fr":
            "nécessite votre autorisation de localisation pour vous montrer les fournisseurs à proximité et configurer l'adresse de livraison / le lieu de paiement",
        "es":
            "requiere su permiso de ubicación para mostrarle proveedores cercanos y configurar la dirección de entrega / ubicación durante el pago",
        "de":
            "erfordert Ihre Standortberechtigung, um Ihnen Lieferanten in der Nähe anzuzeigen und die Lieferadresse / den Standort während der Kaufabwicklung einzurichten",
        "pt":
            "requer a sua permissão de localização para mostrar os fornecedores próximos e configurar o endereço de entrega / pagamento durante o check-out",
        "ar":
            "يتطلب إذن موقعك لتظهر لك البائعين القريبين وإعداد عنوان التسليم / تسجيل الخروج",
        "ko": "근처의 공급 업체를 표시하고 배송 주소 / 위치 확인 중 결제를 설정하려면 위치 권한이 필요합니다."
      } +
      {
        "en": "Request Permission",
        "fr": "Demander la permission",
        "es": "Solicitar permiso",
        "de": "Um Erlaubnis bitten",
        "pt": "Solicitar permissão",
        "ar": "طلب إذن",
        "ko": "권한 요청"
      } +
      {
        "en": "Cancel",
        "fr": "Annuler",
        "es": "Cancelar",
        "de": "Stornieren",
        "pt": "Cancelar",
        "ar": "يلغي",
        "ko": "취소"
      };

  String get i18n => localize(this, _t);
  String fill(List<Object> params) => localizeFill(this, params);
}
