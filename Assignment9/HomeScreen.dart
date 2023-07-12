import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'constatnt.dart';

class HomeScreen extends StatefulWidget {
  const  HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State< HomeScreen> {

  Timer? timer;
  void startTimer() {
    const refreshInterval = Duration(seconds: 1);
    timer = Timer.periodic(refreshInterval, (Timer timer) {
      getHttpWeatherData(lat: latitude, lon: longitude);
      if (mounted) {
        setState(() {});
      }
    });
  }


  double? latitude;
  double? longitude;
  void getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
      getHttpWeatherData(lat: latitude, lon: longitude);
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      throw Exception('Location is not Allowed');
    }
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    if (latitude == null && longitude == null) {
      getCurrentLocation();
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('Flutter Weather'),
        actions: [
             IconButton(onPressed: (){}, icon: Icon(Icons.settings)),
          IconButton(onPressed: (){}, icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: getHttpWeatherData(
            lat: latitude ?? 24.743448,
            lon: longitude ?? 90.398384),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            int localTime = snapshot.data['timezone'];
            DateTime? dateTime =
            DateTime.now().add(Duration(seconds: localTime));
            String? formattedTime = DateFormat('hh:mm:ss a').format(dateTime);
            return Column(
              children: [
                Column(
                  children: [
                    SizedBox(height: 70),
                    LocationText(text: "${snapshot.data['name']}"),
                    UpdateTime(text: 'Updated: $formattedTime')
                  ],
                ),
                SizedBox(height: 60),
                TemperatureCard(
                    img: snapshot.data['weather'][0]['main'] == 'Clouds'
                        ? "https://openweathermap.org/img/wn/03n.png"
                        : snapshot.data['weather'][0]['main'] == 'Rain'
                        ? "https://openweathermap.org/img/wn/10n.png"
                        : 'https://openweathermap.org/img/wn/01n.png',
                    temp: '${snapshot.data['main']['temp']}°',
                    maxTemp: 'Max:${snapshot.data['main']['temp_max']}°',
                    minTemp: 'Min:${snapshot.data['main']['temp_min']}°'),
                 SizedBox(height: 20),
                WeatherTextStyle(text: snapshot.data['weather'][0]['main']),
                Spacer(),
              ],
            );
          }
          if (snapshot.hasError) {
            return  ConnectionLostScreen();
          }
          return const Center(
            child: RefreshProgressIndicator(),
          );
        },
      ),
    );
  }
}
