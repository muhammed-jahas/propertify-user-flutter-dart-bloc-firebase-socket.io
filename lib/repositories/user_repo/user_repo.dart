
import 'package:propertify/resources/app_urls/app_urls.dart';
import 'package:propertify/utils/type_def.dart';

import '../../data/network/network_api_services.dart';

class UserRepo {

  EitherResponse editProfileDetails(request,userId) async => await ApiServices.putApi(request, '${Appurls.editProfile}/$userId');

  EitherResponse getAllFavourites(userId) async => await ApiServices.getApi('${Appurls.getAllFavourites}/$userId');

}