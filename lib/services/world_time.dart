 import 'package:world_time/CommonHeader.dart';

class WorldTime {

  late String location; // location name for the UI
  late String time; // the time in that location
  late String flag; // url to an asset flag icon
  late String url; // location url for api endpoint
  bool isDayTime = false; // true of false if daytime or not

  // Parameterised constructor
  WorldTime({

    required this.location,
    required this.flag,
    required this.url

  });

  Future<void> getTime() async{

    // make the request
    // Response response = await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
    try{
      Response response = await get(
          Uri.parse('https://timeapi.io/api/time/current/zone?timeZone=$url'));

      Map data = jsonDecode(response.body);

      // get properties from data
      String datetime = data['dateTime'];
      // String offset = data['utc_offset'].substring(0, 3);

      // create DateTime object
      DateTime now = DateTime.parse(datetime);
      // print(now);
      // now = now.add(Duration(hours: int.parse(offset)));

      // set time property
      isDayTime = (now.hour > 6 && now.hour < 18);
      time = DateFormat.jm().format(now);
    }
    catch(e){
       print('caught error: $e');
       time = '{Could not get the time data}';
    }
  }

}

