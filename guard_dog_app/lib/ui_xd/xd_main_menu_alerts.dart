// ignore_for_file: file_names, prefer_const_constructors_in_immutables, camel_case_types, prefer_const_literals_to_create_immutables, prefer_const_constructors, constant_identifier_names
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter/widgets.dart';
import 'package:guard_dog_app/models/guard_user.dart';
//import 'package:guard_dog_app/models/incident.dart';
import 'package:guard_dog_app/models/incident.dart';
import 'package:guard_dog_app/ui_xd/xd_report_screen.dart';
import './xd_main_menu_map.dart';
import 'package:adobe_xd/page_link.dart';
import './xd_main_menu_ems.dart';
import './xd_main_menu_settings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


Future<List<Incident>> fetchIncidents() async {
  await Firebase.initializeApp();

  CollectionReference _collectionRef = FirebaseFirestore.instance.collection('Incidents');
  QuerySnapshot querySnapshot = await _collectionRef.get();
  final allData = querySnapshot.docs.map((doc) => doc.data()).toList();

    return  compute(parseIncidents, allData);

}

// A function that converts Firebase list of incidents collection into a List<Incidents>.
List<Incident> parseIncidents(List fb_response ) {

  List<Incident> threat_incidents = <Incident>[];

   for(var i = 0; i < fb_response.length; i++) {
     Incident tmp = new Incident();

     if (fb_response[i]["Danger Level"] == "High") {
       tmp.clothingother = fb_response[i]["Clothing/Other Description"].toString();
       tmp.userphysdec = fb_response[i]["Physical Description"].toString();
       tmp.dangerlevel = fb_response[i]["Danger Level"].toString();
       tmp.usereventdec = fb_response[i]["Event Description"].toString();
       tmp.locationlong = fb_response[i]["locationlong"].toString();
       tmp.locationlat = fb_response[i]["locationlat"].toString();
       threat_incidents.add(tmp);
     } else if (fb_response[i]["Danger Level"] == "Medium") {
       tmp.clothingother = fb_response[i]["Clothing/Other Description"].toString();
       tmp.userphysdec = fb_response[i]["Physical Description"].toString();
       tmp.dangerlevel = fb_response[i]["Danger Level"].toString();
       tmp.usereventdec = fb_response[i]["Event Description"].toString();
       tmp.locationlong = fb_response[i]["locationlong"].toString();
       tmp.locationlat = fb_response[i]["locationlat"].toString();
       threat_incidents.add(tmp);
     } else if (fb_response[i]["Danger Level"] == "Low") {
       tmp.clothingother = fb_response[i]["Clothing/Other Description"].toString();
       tmp.userphysdec = fb_response[i]["Physical Description"].toString();
       tmp.dangerlevel = fb_response[i]["Danger Level"].toString();
       tmp.usereventdec = fb_response[i]["Event Description"].toString();
       tmp.locationlong = fb_response[i]["locationlong"].toString();
       tmp.locationlat = fb_response[i]["locationlat"].toString();
       threat_incidents.add(tmp);
     }
   }

  return threat_incidents;
}

class XDMainMenuAlerts extends StatefulWidget {
  // The app user
  GuardUser? _guardUser;

  XDMainMenuAlerts(GuardUser? user, {Key? key}) : super(key: key) {
    _guardUser = user;
    print("Welcome to XDMainMenuAlerts user:");
    print(_guardUser?.uid);
  }

  @override
  State<XDMainMenuAlerts> createState() => _XDMainMenuAlertsState();
}

class _XDMainMenuAlertsState extends State<XDMainMenuAlerts> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: const Color(0xff002E5D),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              heroTag: "refreshButton",
              onPressed: () {
                fetchIncidents();
                setState(() {});
              },//call async function when sound needs to be played.
              child: CircleAvatar(
                radius: 120,
                backgroundImage: AssetImage(
                  "assets/images/refresh.png",
                ),
              ),
            ),
          ],
        ),
      ),

      body: Stack(
        children: <Widget>[

          Pinned.fromPins(
            Pin(start: 0.0, end: 0.0),
            Pin(start: 20.0, end: 59.0),
            child: FutureBuilder<List<Incident>>(
              future: fetchIncidents(),
              builder: (context, snapshot) {
                  if (snapshot.hasData) {
                  return IncidentList(incidents: snapshot.data!);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          //NAIVGATION
          Pinned.fromPins(
            Pin(start: 0.0, end: -1.0),
            Pin(size: 55.0, end: 0.0),
            child:
                // Adobe XD layer: 'Group Navigation' (group)
                Stack(
              children: <Widget>[
                Pinned.fromPins(
                  Pin(start: 0.0, end: 0.0),
                  Pin(start: 0.0, end: 0.0),
                  child:
                      // Adobe XD layer: 'Rectangle Navigatio…' (shape)
                      Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff002e5d),
                      border: Border.all(
                          width: 1.0, color: const Color(0xff707070)),
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 69.1, start: 2.1),
                  Pin(size: 38.0, end: 8.0),
                  child:
                      // Adobe XD layer: 'Group Map' (group)
                  // <<<<<<<<<<<<<<<<<<<<<<NAVIGATION<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
                  PageLink(
                    links: [
                      PageLinkInfo(
                        transition: LinkTransition.Fade,
                        ease: Curves.easeOut,
                        duration: 0.3,
                        pageBuilder: () => XDMainMenuMap(widget._guardUser),
                      ),
                    ],
                    child: Stack(
                      children: <Widget>[
                        Pinned.fromPins(
                          Pin(size: 14.0, start: 10.0),
                          Pin(start: 8.5, end: 9.5),
                          child:
                              // Adobe XD layer: 'ic_location_on_24px' (shape)
                              SvgPicture.string(
                            _svg_qf87fe,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Pinned.fromPins(
                          Pin(start: 0.0, end: 0.0),
                          Pin(start: 0.0, end: 0.0),
                          child:
                              // Adobe XD layer: 'Rectangle Map' (shape)
                              SvgPicture.string(
                            _svg_qxqvnc,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Pinned.fromPins(
                          Pin(size: 35.0, end: 7.1),
                          Pin(size: 12.0, middle: 0.4929),
                          child: Text(
                            'Map',
                            style: TextStyle(
                              fontFamily: 'Century',
                              fontSize: 10,
                              color: Colors.transparent,
                              letterSpacing: 2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 69.9, middle: 0.2195),
                  Pin(size: 38.0, end: 5.8),
                  child:
                      // Adobe XD layer: 'Group Ems' (group)
                      PageLink(
                    links: [
                      PageLinkInfo(
                        transition: LinkTransition.Fade,
                        ease: Curves.easeOut,
                        duration: 0.3,
                        pageBuilder: () => XDMainMenuEms(widget._guardUser),
                      ),
                    ],
                    child: Stack(
                      children: <Widget>[
                        Pinned.fromPins(
                          Pin(size: 24.0, start: 7.9),
                          Pin(size: 18.0, middle: 0.4),
                          child:
                              // Adobe XD layer: 'ic_contact_phone_24…' (shape)
                              SvgPicture.string(
                            _svg_on70wp,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Pinned.fromPins(
                          Pin(start: 0.0, end: 0.0),
                          Pin(start: 0.0, end: 0.0),
                          child:
                              // Adobe XD layer: 'Rectangle Ems Call' (shape)
                              SvgPicture.string(
                            _svg_gtwvq9,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Pinned.fromPins(
                          Pin(size: 34.9, end: 0.0),
                          Pin(size: 12.0, middle: 0.5192),
                          child:
                              // Adobe XD layer: 'EMS Call' (text)
                              Text(
                            'EMS',
                            style: TextStyle(
                              fontFamily: 'Century',
                              fontSize: 10,
                              color: Colors.transparent,
                              letterSpacing: 2,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 74.0, middle: 0.4406),
                  Pin(size: 38.0, start: 8.0),
                  child:
                      // Adobe XD layer: 'Group Alerts' (group)
                      Stack(
                    children: <Widget>[
                      Pinned.fromPins(
                        Pin(size: 22.0, start: 7.5),
                        Pin(size: 19.0, middle: 0.5097),
                        child:
                            // Adobe XD layer: 'ic_warning_24px' (shape)
                            SvgPicture.string(
                          _svg_pee1r6,
                          allowDrawingOutsideViewBox: true,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(start: 0.0, end: 1.0),
                        Pin(start: 0.0, end: 0.0),
                        child:
                            // Adobe XD layer: 'Rectangle Alerts' (shape)
                            Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                                width: 1.0, color: Colors.transparent),
                          ),
                        ),
                      ),
                      Pinned.fromPins(
                        Pin(size: 42.0, end: 0.0),
                        Pin(size: 12.0, middle: 0.6538),
                        child: Text(
                          'Alerts',
                          style: TextStyle(
                            fontFamily: 'Century',
                            fontSize: 10,
                            color: const Color(0xffffffff),
                            letterSpacing: 2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 79.4, middle: 0.7048),
                  Pin(size: 38.0, middle: 0.5),
                  child:
                      // Adobe XD layer: 'Group Report' (group)
                      PageLink(
                    links: [
                      PageLinkInfo(
                        transition: LinkTransition.Fade,
                        ease: Curves.easeOut,
                        duration: 0.3,
                        pageBuilder: () => XDReportScreen(widget._guardUser),
                      ),
                    ],
                    child: Stack(
                      children: <Widget>[
                        Pinned.fromPins(
                          Pin(size: 18.0, start: 4.6),
                          Pin(start: 8.0, end: 8.0),
                          child:
                              // Adobe XD layer: 'ic_content_paste_24…' (shape)
                              SvgPicture.string(
                            _svg_rj5ioh,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Pinned.fromPins(
                          Pin(start: 0.0, end: 0.0),
                          Pin(start: 0.0, end: 0.0),
                          child:
                              // Adobe XD layer: 'Rectangle Report' (shape)
                              SvgPicture.string(
                            _svg_zec7aw,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Pinned.fromPins(
                          Pin(size: 49.8, end: 0.0),
                          Pin(size: 18.0, middle: 0.6642),
                          child: Text(
                            'Report',
                            style: TextStyle(
                              fontFamily: 'Century',
                              fontSize: 10,
                              color: Colors.transparent,
                              letterSpacing: 2,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Pinned.fromPins(
                  Pin(size: 87.9, end: 5.0),
                  Pin(size: 38.0, middle: 0.5),
                  child:
                      // Adobe XD layer: 'Group Settings' (group)
                      PageLink(
                    links: [
                      PageLinkInfo(
                        transition: LinkTransition.Fade,
                        ease: Curves.easeOut,
                        duration: 0.3,
                        pageBuilder: () =>
                            XDMainMenuSettings(widget._guardUser),
                      ),
                    ],
                    child: Stack(
                      children: <Widget>[
                        Pinned.fromPins(
                          Pin(start: 0.0, end: 0.0),
                          Pin(start: 0.0, end: 0.0),
                          child:
                              // Adobe XD layer: 'Rectangle Report' (shape)
                              SvgPicture.string(
                            _svg_jj5m,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Pinned.fromPins(
                          Pin(start: 29.6, end: 0.0),
                          Pin(size: 18.0, middle: 0.6642),
                          child: Text(
                            'Settings',
                            style: TextStyle(
                              fontFamily: 'Century',
                              fontSize: 10,
                              color: const Color(0x0dffffff),
                              letterSpacing: 2,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Pinned.fromPins(
                          Pin(size: 18.0, start: 6.9),
                          Pin(size: 14.0, middle: 0.4792),
                          child:
                              // Adobe XD layer: 'ic_reorder_24px' (shape)
                              SvgPicture.string(
                            _svg_srd5,
                            allowDrawingOutsideViewBox: true,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class IncidentList extends StatelessWidget {

  const IncidentList ({Key? key, required this.incidents}) : super(key: key);

  final List<Incident> incidents;

  //##002E5d blue
//#6F6B19  yellow
// #2A1119 red
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 450,
          //crossAxisAlignment: CrossAxisAlignment.stretch,
          childAspectRatio: 3,
          crossAxisSpacing: 15,
          mainAxisSpacing: 5),
      itemCount: incidents.length,
      itemBuilder: (context, index) {
        if(incidents[index].dangerlevel == 'High'){
          return Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(30.0, 2.0, 3.0, 4.0),
            child: Text(
                "Danger Level : " + incidents[index].dangerlevel.toString() + " \n" +" \n" +
                    "Description : " +  incidents[index].usereventdec + " \n" +" \n"+
                    "Location : " + incidents[index].userphysdec,
              style: TextStyle(
                  color:  const Color(0xff002E5D), //Colors.black.withOpacity(0.8),  //002E5d
                  fontSize: 14.0,
                  height: 1.4,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.left,

            ),
            decoration: BoxDecoration(
              color: Colors.blueGrey[50],
                border: Border.all(
                  color: const Color(0xff883838).withOpacity(0.8),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15),
                image:  DecorationImage(
            image: ExactAssetImage("assets/images/dg_red.png"),
            fit: BoxFit.scaleDown,
            alignment: Alignment.bottomRight,
            //Align: Center,
          )
          ),
          );
        }
        else if(incidents[index].dangerlevel == 'Medium'){
          return Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(30.0, 2.0, 3.0, 4.0),
            child: Text(
              "Danger Level : " + incidents[index].dangerlevel.toString() + " \n" +" \n" +
                  "Description : " +  incidents[index].usereventdec + " \n" +" \n"+
                  "Location : " + incidents[index].userphysdec,
              style: TextStyle(
                  color:  const Color(0xff002E5D), //Colors.black.withOpacity(0.8),  //002E5d
                  fontSize: 14.0,
                  height: 1.4,
                  fontWeight: FontWeight.w600),
                textAlign: TextAlign.left,
            ),
            decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                border: Border.all(
                  color: const Color(0xff6F6B19),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15),
                image:  DecorationImage(
                  image: ExactAssetImage("assets/images/dg_yellow.png"),
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.bottomRight,
                )
            ),
          );
        }
        else {
          return Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(30.0, 2.0, 3.0, 4.0),
            child: Text(
              "Danger Level : " + incidents[index].dangerlevel.toString() + " \n" +" \n" +
                  "Description : " +  incidents[index].usereventdec + " \n" +" \n"+
                  "Location : " + incidents[index].userphysdec,
              style: TextStyle(
                  color:  const Color(0xff002E5D), //Colors.black.withOpacity(0.8),  //002E5d
                  fontSize: 14.0,
                  height: 1.4,
                  fontWeight: FontWeight.w600),
                  textAlign: TextAlign.left,
            ),
            decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                border: Border.all(
                  color: const Color(0xff002E5D),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(15),
                image:  DecorationImage(
                  image: ExactAssetImage("assets/images/dg_grey.png"),
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.bottomRight,
                )
            ),
          );
        }
      },
    );
  }
}

const String _svg_qf87fe =
    '<svg viewBox="10.0 8.5 14.0 20.0" ><path transform="translate(5.0, 6.5)" d="M 12 2 C 8.130000114440918 2 5 5.130000114440918 5 9 C 5 14.25 12 22 12 22 C 12 22 19 14.25 19 9 C 19 5.130000114440918 15.86999988555908 2 12 2 Z M 12 11.5 C 10.61999988555908 11.5 9.5 10.38000011444092 9.5 9 C 9.5 7.619999885559082 10.61999988555908 6.5 12 6.5 C 13.38000011444092 6.5 14.5 7.619999885559082 14.5 9 C 14.5 10.38000011444092 13.38000011444092 11.5 12 11.5 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_qxqvnc =
    '<svg viewBox="0.0 0.0 69.1 38.0" ><path  d="M 0 0 L 69.07080078125 0 L 69.07080078125 38 L 0 38 L 0 0 Z" fill="#ffffff" fill-opacity="0.0" stroke="#707070" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_on70wp =
    '<svg viewBox="7.9 8.0 24.0 18.0" ><path transform="translate(7.93, 5.0)" d="M 22 3 L 2 3 C 0.8999999761581421 3 0 3.900000095367432 0 5 L 0 19 C 0 20.10000038146973 0.8999999761581421 21 2 21 L 22 21 C 23.10000038146973 21 23.98999977111816 20.10000038146973 23.98999977111816 19 L 24 5 C 24 3.900000095367432 23.10000038146973 3 22 3 Z M 8 6 C 9.659999847412109 6 11 7.340000152587891 11 9 C 11 10.65999984741211 9.659999847412109 12 8 12 C 6.340000152587891 12 5 10.65999984741211 5 9 C 5 7.340000152587891 6.340000152587891 6 8 6 Z M 14 18 L 2 18 L 2 17 C 2 15 6 13.89999961853027 8 13.89999961853027 C 10 13.89999961853027 14 15 14 17 L 14 18 Z M 17.85000038146973 14 L 19.48999977111816 14 L 21 16 L 19.01000022888184 17.98999977111816 C 17.70000076293945 17.01000022888184 16.72999954223633 15.60999965667725 16.28000068664551 14 C 16.10000038146973 13.35999965667725 16 12.69000053405762 16 12 C 16 11.30999946594238 16.10000038146973 10.64000034332275 16.28000068664551 10 C 16.73000144958496 8.380000114440918 17.70000076293945 6.989999771118164 19.01000022888184 6.010000228881836 L 21 8 L 19.48999977111816 10 L 17.85000038146973 10 C 17.63000106811523 10.63000011444092 17.5 11.30000019073486 17.5 12 C 17.5 12.69999980926514 17.6299991607666 13.36999988555908 17.85000038146973 14 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_gtwvq9 =
    '<svg viewBox="0.0 0.0 69.9 38.0" ><path  d="M 0 0 L 69.86083984375 0 C 69.86083984375 0 69.86083984375 11.734375 69.86083984375 21.234375 C 69.86083984375 30.734375 69.86083984375 38 69.86083984375 38 L 0 38 L 0 0 Z" fill="#ffffff" fill-opacity="0.0" stroke="#707070" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_pee1r6 =
    '<svg viewBox="7.5 9.5 22.0 19.0" ><path transform="translate(6.5, 7.5)" d="M 1 21 L 23 21 L 12 2 L 1 21 Z M 13 18 L 11 18 L 11 16 L 13 16 L 13 18 Z M 13 14 L 11 14 L 11 10 L 13 10 L 13 14 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_rj5ioh =
    '<svg viewBox="4.6 8.0 18.0 22.0" ><path transform="translate(1.64, 8.0)" d="M 19 2 L 14.81999969482422 2 C 14.39999961853027 0.8399999737739563 13.30000019073486 0 12 0 C 10.69999980926514 0 9.600000381469727 0.8399999737739563 9.180000305175781 2 L 5 2 C 3.900000095367432 2 3 2.900000095367432 3 4 L 3 20 C 3 21.10000038146973 3.900000095367432 22 5 22 L 19 22 C 20.10000038146973 22 21 21.10000038146973 21 20 L 21 11.44470977783203 L 21 4 C 21 2.900000095367432 20.10000038146973 2 19 2 Z M 12 2 C 12.55000019073486 2 13 2.450000047683716 13 3 C 13 3.549999952316284 12.55000019073486 4 12 4 C 11.44999980926514 4 11 3.549999952316284 11 3 C 11 2.450000047683716 11.44999980926514 2 12 2 Z M 19 20 L 5 20 L 5 4 L 7 4 L 7 7 L 17 7 L 17 4 L 19 4 L 19 20 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_zec7aw =
    '<svg viewBox="0.0 0.0 79.4 38.0" ><path  d="M 0 0 L 79.42822265625 0 L 79.42822265625 37.99993896484375 L 0 37.99993896484375 L 0 0 Z" fill="#ffffff" fill-opacity="0.0" stroke="#707070" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_jj5m =
    '<svg viewBox="0.0 0.0 87.9 38.0" ><path  d="M 0 0 L 87.85302734375 0 L 87.85302734375 37.99993896484375 L 0 37.99993896484375 L 0 0 Z" fill="#ffffff" fill-opacity="0.0" stroke="#707070" stroke-width="1" stroke-opacity="0.0" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_srd5 =
    '<svg viewBox="6.9 11.5 18.0 14.0" ><path transform="translate(3.85, 6.5)" d="M 3 15 L 21 15 L 21 13 L 3 13 L 3 15 Z M 3 19 L 21 19 L 21 17 L 3 17 L 3 19 Z M 3 11 L 21 11 L 21 9 L 3 9 L 3 11 Z M 3 5 L 3 7 L 21 7 L 21 5 L 3 5 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
