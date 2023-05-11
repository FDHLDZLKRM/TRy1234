import 'package:flutter/material.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prayer Times',
      home: PrayerScreen(),
    );
  }
}

class PrayerScreen extends StatefulWidget {
  @override
  _PrayerScreenState createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  String _location = 'New York';
  String _date = '';
  Map<String, dynamic> _prayerTimes = {};

  Future<void> _getPrayerTimes() async {
    final response = await get(Uri.parse(
        'http://api.aladhan.com/v1/calendarByAddress?address=$_location&method=2'));

    final data = json.decode(response.body);
    final date = DateTime.parse(data['data'][0]['date']['gregorian']['date']);
    final prayers = data['data'][0]['timings'];

    setState(() {
      _date = '${date.year}-${date.month}-${date.day}';
      _prayerTimes = prayers;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prayer Times'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Location: $_location',
              style: Theme.of(context).textTheme.headline6,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Location',
              ),
              onChanged: (value) {
                setState(() {
                  _location = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _getPrayerTimes,
              child: Text('Get Prayer Times'),
            ),
            SizedBox(height: 32.0),
            Text(
              'Prayer Times for $_date',
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(height: 16.0),
            Text(
              'Fajr: ${_prayerTimes['Fajr']}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              'Dhuhr: ${_prayerTimes['Dhuhr']}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              'Asr: ${_prayerTimes['Asr']}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              'Maghrib: ${_prayerTimes['Maghrib']}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              'Isha: ${_prayerTimes['Isha']}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}

get(Uri parse) {
}