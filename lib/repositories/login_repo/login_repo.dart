

import 'package:propertify/utils/type_def.dart';

import '../../data/network/network_api_services.dart';
import '../../resources/app_urls/app_urls.dart';

class LoginRepo {
  EitherResponse loginUser(userData) async => await ApiServices.postApi(userData, Appurls.loginWithUserPhone);

  
  // EitherResponse getUserData(userPhoneNumeber) async => await ApiServices.postApi(userPhoneNumeber, Appurls.loginWithUserPhone);

}