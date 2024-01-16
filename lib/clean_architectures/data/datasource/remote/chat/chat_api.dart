import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/clean_architectures/data/models/response/chat_response/recipient_response.dart';
import 'package:retrofit/retrofit.dart';

part 'chat_api.g.dart';

@RestApi()
@injectable
abstract class ChatApi {
  static const String branch = "/message";
  static const String getAllRecipientApi = "$branch/get-all-recipient";

  @factoryMethod
  factory ChatApi(Dio dio) = _ChatApi;

  @GET(getAllRecipientApi)
  Future<HttpResponse<RecipientResponse>> getAllRecipient();
}
