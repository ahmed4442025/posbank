import 'package:dio/dio.dart';
import 'package:posbank/app/app_constants.dart';
import 'package:posbank/data/responses/intrest_response.dart';
import 'package:posbank/data/responses/note_response.dart';
import 'package:posbank/data/responses/user_response.dart';
import 'package:retrofit/http.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  // GET
  @GET(AppConstants.getAllNotes)
  Future<List<NoteResponse>> getAllNotes();

  @GET(AppConstants.getAllNotes)
  Future<List<UserResponse>> getAllUsers();

  @GET(AppConstants.getAllIntrests)
  Future<List<InterestResponse>> getAllInterests();

  // POST
  @POST(AppConstants.notesUpdate)
  Future<String> notesUpdate(
      @Field("Id") String id,
      @Field("Text") String text,
      @Field("UserId") String userId,
      @Field("PlaceDateTime") String PlaceDateTime);

  @POST(AppConstants.notesInsert)
  Future<String> notesInsert(
    @Field("Text") String text,
    @Field("UserId") String userId,
    @Field("PlaceDateTime") String PlaceDateTime,
  );

  @POST(AppConstants.insertUser)
  Future<String> userInsert(
    @Field("Username") String username,
    @Field("Password") String password,
    @Field("Email") String email,
    @Field("ImageAsBase64") String imageAsBase64,
    @Field("IntrestId") String intrestId,
  );
}
