class Appurls {

  //Base Url
  static const String baseUrl = 'https://propertifyapp.online';
  // static const String baseUrl = 'http://10.4.2.58:3000';

  //User Login
  static const String userLogin = '$baseUrl/api/user/loginUser';

  //User Login with Phone
  static const String loginWithUserPhone = '$baseUrl/api/user/loginwithUserPhone';

  //Get All Properties
  static const String getAllProperties = '$baseUrl/api/admin/getAllProperties';

  //Send Property Request
  static const String sendPropertyRequest = '$baseUrl/api/user/addRequest';

  //Signup User
  static const String signupUser = '$baseUrl/api/user/registerUser';

  //Get All Payment Requests
  static const String getAllPaymentRequests =  '$baseUrl/api/user/getAllPaymentRequestsofUser';

  //Add to Favourite
  static const String addFavourite =  '$baseUrl/api/user/addFavouriteProperty';

  //Add to Favourite
  static const String checkFavourite =  '$baseUrl/api/user/checkFavourite';
  
   //Get All Favourites
  static const String getAllFavourites =  '$baseUrl/api/user/getFavouriteProperties';

  //Payment Succes
  static const String paymentSuccess =  '$baseUrl/api/user/markPaymentRequestPaid';

  //Update Profile
  static const String editProfile =  '$baseUrl/api/user/updateUserDetails';
}