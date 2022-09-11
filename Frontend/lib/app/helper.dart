
import 'dart:convert';


class AppHelper {
  
  static List<dynamic> response(data, int status){
    if(isJsonParsable(data)){
      if(status >= 200 && status <=299){
        return [jsonDecode(data), "", status];
      }else {
        if(status == 408){
          return ["", "internet error", 408];
        }
        if(jsonDecode(data) != null) {
          return ["", jsonDecode(data), status];
        }
        return ['', 'something went wrong', status];
      }
    } 
    return ['', 'something went wrong', 500];
  }


  static isJsonParsable (string) {
    try {
        jsonDecode(string);
    } catch (e) {
        return false;
    }
    return true;
  }
}