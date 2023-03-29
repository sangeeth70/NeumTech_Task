import 'package:http/http.dart';
import 'package:nuemtech_test/model/user_model.dart';

class api{
  static Userdata? userdata;
  static List<Datum> user=[];

  static Future<List<Datum>> getusers()async{
    Response response=await get(Uri.parse('https://dummyapi.io/data/v1/user?limit=40'),headers: {'app-id':'61dbf9b1d7efe0f95bc1e1a6'});
    print(response.body);
    userdata=userdataFromJson(response.body);
    print(userdata?.data[0].picture);
    user=userdata!.data;
    user.sort((a, b) => a.lastName.compareTo(b.lastName),);
    user.forEach((element) {print(element.lastName);});
    return user;
  }
}