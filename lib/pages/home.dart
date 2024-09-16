import 'package:world_time/CommonHeader.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};
  final player = AudioPlayer();

  Future<void> playSound() async {
    await player.play(AssetSource('USSR_National_Anthem.mp3'));
  }

  // @override
  // void dispose() {
  //   // Release all sources and dispose the player.
  //   player.dispose();
  //
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {

    data = !data.isEmpty? data : ModalRoute.of(context)!.settings.arguments as Map;
    print(data); // checking

    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png' ;
    Color? statusbarColor = data['isDayTime'] ? Colors.blue: Colors.indigo[700];
    Color? change_location_color = data['isDayTime'] ? Colors.deepPurpleAccent: Colors.grey[300];
    if(data['flag'] == 'ussr.png'){
      bgImage = 'USSR_Background.png';
      statusbarColor = Colors.red;
      change_location_color = Colors.grey[300];
      playSound();
    }

    print(bgImage); // checking

    return Scaffold(
      backgroundColor: statusbarColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              // image: AssetImage('assets/day.png'),
              fit: BoxFit.cover,
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
            child: Column(
              children: <Widget>[
                TextButton.icon(
                  onPressed: () async { // Choose location button action
                    await player.pause();
                    dynamic result = await Navigator.pushNamed(context, '/location');
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDayTime': result['isDayTime'],
                        'flag': result['flag'],
                      };
                    });
                  },
                  label: Text(
                    'Change Location',
                    style: TextStyle(
                      color: change_location_color,
                    ),
                  ),
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),

                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 28.0,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),
                Text(
                  data['time'],
                  style: TextStyle(
                    fontSize: 66.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
