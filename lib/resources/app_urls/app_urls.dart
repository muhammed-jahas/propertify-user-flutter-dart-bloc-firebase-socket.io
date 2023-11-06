class Appurls {

  //Base Url
  static const String baseUrl = 'http://192.168.85.221:3000';

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
}