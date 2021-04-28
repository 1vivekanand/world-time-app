import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime{

  String location;  //location name for UI
  String time;  //time in that location
  String flag;  //url to an asset flag icon
  String url;   //location url for api
  bool isDaytime;   //true for day time and vice versa

  WorldTime({this.location,this.flag,this.url});

  Future<void> getTime() async{

    try{
      Response response=await get(Uri.parse('https://worldtimeapi.org/api/timezone/$url'));
      Map data=jsonDecode(response.body);

      //get properties from data
      String datetime=data['datetime'];
      String offset =data['utc_offset'].substring(1,3);

      //create datetime object
      DateTime now=DateTime.parse(datetime);
      now=now.add(Duration(hours: int.parse(offset)));

      //set time to string from datetime
      isDaytime=now.hour>6 && now.hour<18 ?true:false;
      time=DateFormat.jm().format(now);
    }
    catch(e){
      print('caught error');
    }
  }

}