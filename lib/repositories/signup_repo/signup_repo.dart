import 'package:propertify/data/network/network_api_services.dart';
import 'package:propertify/resources/app_urls/app_urls.dart';
import 'package:propertify/utils/type_def.dart';

class SignupRepo {


  EitherResponse signupUserCheck (userData) async => await ApiServices.postApi(userData,Appurls.loginWithUserPhone);


  EitherResponse signupUser(userData) async => await ApiServices.postApi(userData, Appurls.signupUser);

   
}