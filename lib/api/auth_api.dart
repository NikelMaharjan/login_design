import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:login_page/model/sign_up_response_model.dart';

class _AuthApi {

  Future<SignUpResponseModel?> signup(String email, String password) async {
    final requestBody = {
      "email":email,
      "password":password,
      "gender":"male",
    };

    final url = Uri.parse("https://api.fresco-meat.com/api/albums/signup");
    try{
      final response = await post(
          url,
          body: jsonEncode(requestBody),
          headers: {"Content-Type": "application/json"}
      );
      final body = response.body;
      final code = response.statusCode;
      if(code!= HttpStatus.created){
        print("Error");
        return null;
      }
      final parsedMap = jsonDecode(body);
      print("The signup response $parsedMap");
      final SignUpResponseModel responseModel = SignUpResponseModel.fromJson(parsedMap);
      return responseModel;
    }catch(e){
      print("Exception $e");
      return null;

    }

  }

}

final authApi = _AuthApi();       //singleton design pattern ..create only one instance