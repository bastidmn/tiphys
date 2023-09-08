import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:latlong2/latlong.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tiphys',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          background: Color(0xFF121212),
          surface: Color(0xFF1f1f1f),
          brightness: Brightness.dark,
          primary: Color(0xFF1a4289),
          secondary: Color(0xFFFFFFFF),
        ),
        cardTheme: CardTheme(
            color: Color(0xFF1f1f1f),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            )),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: 25.0,
              vertical: 15.0,
            ),
            foregroundColor: Color(0xFF1a4289),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        appBarTheme: AppBarTheme(
          color: Color(0xFF1f1f1f),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          foregroundColor: Color(0xFFFFFFFF),
          backgroundColor: Color(0xFF1a4289),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
        textTheme: TextTheme(
          headlineLarge: GoogleFonts.breeSerif(
            fontSize: 32.0,
            color: Color(0xFFFFFFFFFF),
          ),
          headlineMedium: GoogleFonts.breeSerif(
            fontSize: 25.0,
            color: Color(0xFFFFFFFF),
          ),
          bodyMedium: GoogleFonts.openSans(
            fontSize: 18.0,
            color: Color(0xFFFFFFFF),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(
            "assets/THW.svg",
            color: Color(0xFFFFFFFF),
          ),
        ),
        title: Text(
          "Tiphys",
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        // actions: const [
        // ],
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          minZoom: 4,
          maxZoom: 25,
          center: LatLng(48.521749, 11.494378),
          zoom: 18,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'dev.fleaflet.flutter_map.example',
            maxZoom: 25,
            maxNativeZoom: 19,
          ),
        ],
        nonRotatedChildren: [
          Align(
            alignment: Alignment.centerLeft,
            child: SizedBox(
              width: width * 0.2,
              height: height * 0.8,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 15.0,
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Import",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 8.0,
                          ),
                          child: ElevatedButton(
                            child: Text(
                              "KML auswählen",
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            onPressed: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles();

                              if (result != null) {
                                File file = File(result.files.single.path!);
                              } else {
                                // User canceled the picker
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SimpleAttributionWidget(
            source: Text('OpenStreetMap contributors'),
          ),
        ],
      ),
    );
  }
}
