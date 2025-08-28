// import 'package:api_client/apis/dtos/get_unit_of_measures_response.dart';
// import 'package:api_client/apis/dtos/get_user_permissions_response.dart';
// import 'package:api_client/apis/dtos/get_user_response.dart';
// import 'package:api_client/apis/dtos/measure_request.dart';
// import 'package:api_client/apis/dtos/update_uom_settings_response.dart';
// import 'package:dio/dio.dart';
// import 'package:retrofit/retrofit.dart';

// part 'user_preferences_apis.g.dart';

// @RestApi()
// abstract class UserPreferencesApis {
//   factory UserPreferencesApis(
//     Dio dio,
//   ) = _UserPreferencesApis;

//   /// ---------- get NWA ----------
//   @GET('/api/Common/User({loginId})')
//   Future<GetUserResponseDto> fetchUserDetails({
//     @Path('loginId') required String loginId,
//   });

//   /// ---------- get measurements ----------
//   @GET('/api/Common/UnitOfMeasures')
//   Future<List<GetUnitOfMeasuresResponseDto>> fetchUnitOfMeasures();

//   /// ---------- update UOM settings ----------
//   @POST('/api/Common/User({userId})/UpdateUOMSettings')
//   Future<UpdateUOMSettingsResponseDto> updateUOMSettings({
//     @Path('userId') required int userId,
//     @Body() required List<MeasureRequestDto> measures,
//   });

//   /// ---------- get user permissions ----------
//   @GET('/api/Common/User({loginId})/Permissions')
//   Future<GetUserPermissionsResponseDto> fetchUserPermissions({
//     @Path('loginId') required String loginId,
//   });
// }
