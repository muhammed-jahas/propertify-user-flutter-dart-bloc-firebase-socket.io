import 'package:propertify/resources/app_urls/app_urls.dart';
import 'package:propertify/utils/type_def.dart';

import '../../data/network/network_api_services.dart';

class PaymentRepo {
  EitherResponse getAllPaymentRequests(String userId) async =>
      await ApiServices.getApi('${Appurls.getAllPaymentRequests}/$userId');
}
