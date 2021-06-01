import 'package:fuodz/constants/api.dart';
import 'package:fuodz/models/api_response.dart';
import 'package:fuodz/models/payment_method.dart';
import 'package:fuodz/services/http.service.dart';

class PaymentMethodRequest extends HttpService {
  //
  Future<List<PaymentMethod>> getPaymentOptions() async {
    final apiResult = await get(Api.paymentMethods);

    //
    final apiResponse = ApiResponse.fromResponse(apiResult);
    if (apiResponse.allGood) {
      return apiResponse.data.map((jsonObject) {
        return PaymentMethod.fromJson(jsonObject);
      }).toList();
    } else {
      throw apiResponse.message;
    }
  }
}
