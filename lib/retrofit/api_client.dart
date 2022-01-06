import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:techapp/retrofit/response.dart';
part 'api_client.g.dart';

@RestApi(baseUrl: "https://techspardhabackend.herokuapp.com/")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/foodsponsors")
  Future<ResponseData> getSponsors();

  @GET("/aboutAppDevs")
  Future<ResponseData> getAboutDev();

  @GET("/contacts")
  Future<ResponseData> getTeam();

  @GET("/lectures")
  Future<ResponseData> getLectures();

  @GET("/events")
  Future<ResponseData> getAllEvents();

  @GET("/events/description?eventCategory={category}")
  Future<ResponseData> getEvents(@Path("category") String category);

  @GET("/events/description?eventCategory={category}&eventName={eventName}")
  Future<ResponseData> getEvent(
      @Path("category") String category, @Path("eventName") String eventName);

  @GET("/user/event")
  Future<ResponseData> getMyEvents(@Header("Authorization") String token);

  @PUT("/user/event")
  Future<ResponseData> addEvent(
      @Header("Authorization") String token, @Body() Map<String, dynamic> body);

  @PUT("/signUpApp")
  Future<ResponseData> signUp(
      @Header("Authorization") String token, @Body() Map<String, dynamic> body);

  @POST("/loginApp")
  Future<ResponseData> login(@Body() Map<String, String> body);

  @PUT("/user/event/unregister")
  Future<ResponseData> delEvent(
      @Header("Authorization") String token, @Body() Map<String, String> body);

  @GET("/events/categories")
  Future<ResponseData> getCategories();
}
