import 'package:propertify/resources/app_urls/app_urls.dart';
import 'package:propertify/utils/type_def.dart';

import '../../data/network/network_api_services.dart';

class PropertyRepo {
  EitherResponse getAllProperties() async =>
      await ApiServices.getApi(Appurls.getAllProperties);

  EitherResponse sendPropertyRequest(request) async =>
      await ApiServices.postApi(request, Appurls.sendPropertyRequest);

  EitherResponse addToFavourites(favourite) async =>
      await ApiServices.postApi(favourite, Appurls.addFavourite);

  EitherResponse paymentSuccess(paymentRequestId) async =>
      await ApiServices.putApi(
          '', '${Appurls.paymentSuccess}/$paymentRequestId');

  EitherResponse checkFavorite(checkfavourite) async =>
      await ApiServices.postApi(checkfavourite, Appurls.checkFavourite);

  // EitherResponse getAllPaidProperties(data) async => await ApiServices.postApi(data, Appurls.getAllPaymentRequests);
}
