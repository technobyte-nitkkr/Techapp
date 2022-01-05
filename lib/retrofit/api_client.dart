import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:techapp/retrofit/response.dart';
part 'api_client.g.dart';

@RestApi(
    baseUrl: "https://us-central1-techspardha-87928.cloudfunctions.net/api/")
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

  @GET("/events/description?eventCategory={category}")
  Future<ResponseData> getEvents(@Path("category") String category);

  @GET("/events/description?eventCategory={category}&eventName={eventName}")
  Future<ResponseData> getEvent(
      @Path("category") String category, @Path("eventName") String eventName);

  @GET("/user/eventApp?email={email}")
  Future<ResponseData> getMyEvents(@Path("email") String email);
}
