import 'dart:async';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:input_history_text_field/input_history_text_field.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'mapPage.dart';
import 'model.dart';
import 'notification.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

class mainPage extends StatefulWidget {
  const mainPage({Key? key}) : super(key: key);
  static const List<String> _kOptions = <String>[
  '을지로4가',
  '을지로3가',
  '을지로입구',
  '시청역',
  '충정로',
  '아현',
  '이대',
  '신촌',
  '홍대입구',
  '합청',
  '로컬스티치을지로',
    '구글본사',
  ];

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {


  double lat = 0.0, lng = 0.0, lat1 = 0.0, lng1 = 0.0;
  double tracklat =0.0, tracklng =0.0;
  double streamlat =0.0, streamlng =0.0;
  late String subwayName1 = 'invaild location';
  late String passenger1 = 'invaild name';
  late int countvalue = subwayName1.length;
  late int lineNumber = 0;
  String QRdata = '1234ffov3pp5oq23lk';


  void getLocation() async{
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    lat = position.latitude;
    lng = position.longitude;
  }

  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );

  @override
void initState() {
    // TODO: implement initState
    super.initState();
    Noti.initialize(flutterLocalNotificationsPlugin);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void findMyposition(
      List<SubwayModel> subway, double lat, double lng, String subwayName1,)
  {
    final index = subway.indexWhere((element) => element.name == subwayName1);
    lat1 = subway[index].lat;
    lng1 = subway[index].lng;
    lineNumber = subway[index].line;

  }

  Stream<double> LocationStream() async* {
    StreamSubscription<Position> positionStream =
  Geolocator.getPositionStream().asBroadcastStream().listen((Position? position) {
    print(position == null
        ? 'Unknown'
        : '****${position.latitude.toString()}, ****${position.longitude.toString()}');
    position == null ? 'Unknown' : streamlat = position.latitude;
    position == null ? 'Unknown' : streamlng = position.longitude;
  }
  );
  if(streamlng == lng1 && streamlat == lat1){
    print('Call Notification');
    Noti.showBigTextNotification(
        title: "곧 ${subwayName1} 입니다.", body: "\n 내릴준비하세요",
        fln: flutterLocalNotificationsPlugin);
    positionStream.cancel();
  } else {
    print('resume StreamPosition');
    positionStream.resume();
  }}
  




  @override
  Widget build(BuildContext context) {



    double appHeight = MediaQuery.of(context).size.height;
    double appWidth = MediaQuery.of(context).size.width;
    double appRatio = MediaQuery.of(context).size.aspectRatio;
    double mainBoxHeight = appHeight * 0.58;
    double mainBoxWidth = appWidth * 0.915;

    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Column(
            children: [
              Container(
                color: Colors.white,
                height: appHeight * 0.17,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: mainBoxWidth/40,),
                    Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>  mapPage()),
                            );
                          },
                            child: QrImage(data: QRdata)),
                      ),

                    SizedBox(width: appRatio >= 0.5? mainBoxHeight/6
                        : mainBoxHeight/15,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: mainBoxHeight/25,
                        ),
                        Text(
                          DateFormat('y-M-dd EEE').format(DateTime.now()),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: mainBoxHeight/25,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: mainBoxHeight/50,
                        ),
                        Container(
                          height:  mainBoxHeight/7,
                          width: mainBoxWidth/2.2,
                          // decoration: BoxDecoration(
                          //   border: Border.all(width: 1),
                          // ),
                          child: BarcodeWidget(
                            data: 'FRIST-CLASS',style: TextStyle(fontWeight: FontWeight.bold,fontSize: mainBoxHeight/35),
                            barcode: Barcode.code93(),
                          ),
                        ),

                        SizedBox(
                          height: 3,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                height: appHeight * 0.60,
                width: appWidth * 0.915,
                child: Column(
                  children: <Widget>[
                    DottedLine(
                        dashLength: 15, dashGapLength: 6, lineThickness: 7),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: [
                              SizedBox(height: mainBoxHeight/20,),
                              SizedBox(
                                height: appHeight * 0.58 * 0.90,
                                width: appWidth * 0.08,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: lineNumber == 1? Color(0xff2b3990)
                                           : lineNumber == 2? Color(0xff009D3E)
                                           : lineNumber == 3? Color(0xffEF7C1C)
                                           : lineNumber == 4? Color(0xff00A5DE)
                                           : lineNumber == 5? Color(0xff996CAC)
                                           : lineNumber == 6? Color(0xffCD7C2F)
                                           : lineNumber == 7? Color(0xff747F00)
                                           : lineNumber == 8? Color(0xffEA545D)
                                           : lineNumber == 9? Color(0xffBB8336)
                                           : Color(0xffBDB092)
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: mainBoxHeight/50,),
                          Column(
                            children: <Widget>[
                              SizedBox(height: mainBoxHeight/25,),
                              Container(
                                height:  appWidth * 0.13,
                                width: mainBoxHeight/5.5,
                                color: Colors.black,
                                alignment: Alignment.center,
                                child: Text(
                                  'LINE ${lineNumber}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: mainBoxHeight/21,
                                      color: Colors.white),
                                ),
                              ),
                              SizedBox(height: mainBoxHeight/25,),
                              Container(
                                child: RotatedBox(
                                  quarterTurns: 3,
                                  child:
                                  Column(
                                    children: [
                                      Text(
                                        '${subwayName1}', style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                          countvalue == 3? mainBoxHeight/7.5 /// 70
                                              : countvalue == 4 ? mainBoxHeight/7.5 /// 70
                                              : countvalue == 5 ? mainBoxHeight/7.5 /// 70
                                              : countvalue == 6 ? mainBoxHeight/8.6 /// 60
                                              : countvalue == 7 ? mainBoxHeight/8.6 /// 60
                                              : countvalue == 8 ? mainBoxHeight/10.4 /// 50
                                              : mainBoxHeight/10.4),
                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: appRatio >= 0.5? mainBoxHeight/6
                              : mainBoxHeight/15,),

                          Column(
                            children: <Widget>[
                              SizedBox(height: mainBoxHeight/30,),
                              SizedBox(
                                width: appHeight/6,
                                child: RotatedBox(
                                  quarterTurns: 1,
                                  child: IconButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          content: Container(
                                            height: 330,
                                            child: Form(
                                              child: Column(
                                                children: [
                                                  Container(
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          decoration: BoxDecoration(
                                                            // color: Colors.blueGrey
                                                          ),
                                                          width: 80,
                                                          height: 80,
                                                          child: QrImage(
                                                            data: QRdata,
                                                          ),
                                                        ),
                                                        SizedBox(width: 5,),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text('Boarding Psss',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color: Colors.black),),
                                                            Text(
                                                              DateFormat('y-M-dd EEE \nH:m').format(DateTime.now()),
                                                              style: TextStyle(
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 15,
                                                                  color: Colors.black),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Autocomplete<String>(
                                                          optionsBuilder: (TextEditingValue
                                                          textEditingValue) {
                                                            if (textEditingValue.text == '') {
                                                              return const Iterable<
                                                                  String>.empty();
                                                            }
                                                            subwayName1 = textEditingValue.text;
                                                            return mainPage._kOptions.where(
                                                                    (String option) => option.contains(textEditingValue.text.toLowerCase()));
                                                          },
                                                          onSelected: (String selection) {
                                                            debugPrint('You just selected $selection');
                                                          },
                                                          fieldViewBuilder: (context,
                                                              controller,
                                                              focusNode,
                                                              onEdittingComplete) {

                                                            return TextField(
                                                              controller: controller,
                                                              focusNode: focusNode,
                                                              onEditingComplete:
                                                              onEdittingComplete,
                                                              decoration: InputDecoration(
                                                                  border: OutlineInputBorder(
                                                                    borderRadius:
                                                                    BorderRadius.circular(
                                                                        10),
                                                                  ),
                                                                  prefixIcon: Icon(
                                                                    Icons.subway,
                                                                    color: Colors.black,
                                                                  ),
                                                                  hintText:
                                                                  'Enter your destination'),
                                                            );
                                                          },
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        InputHistoryTextField(
                                                            historyKey: "3",
                                                            decoration: InputDecoration(
                                                                border: OutlineInputBorder(
                                                                  borderRadius:
                                                                  BorderRadius.circular(10),
                                                                ),
                                                                prefixIcon: Icon(
                                                                  Icons.person,
                                                                  color: Colors.black,
                                                                ),
                                                                hintText: 'Enter your name'),
                                                            onChanged: (val2) {
                                                              setState(() {
                                                                passenger1 = val2;
                                                                print(
                                                                    'passenger1 ${passenger1}');
                                                              });
                                                            }),
                                                        SizedBox(
                                                          height: 20,
                                                        ),
                                                        Container(
                                                          height: 70,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white),
                                                          child: Row(
                                                            children: [
                                                              SizedBox(
                                                                height: 60,
                                                                width: 10,
                                                                child: Container(
                                                                  decoration:   BoxDecoration(
                                                                      color: lineNumber == 1? Color(0xff2b3990)
                                                                          : lineNumber == 2? Color(0xff009D3E)
                                                                          : lineNumber == 3? Color(0xffEF7C1C)
                                                                          : lineNumber == 4? Color(0xff00A5DE)
                                                                          : lineNumber == 5? Color(0xff996CAC)
                                                                          : lineNumber == 6? Color(0xffCD7C2F)
                                                                          : lineNumber == 7? Color(0xff747F00)
                                                                          : lineNumber == 8? Color(0xffEA545D)
                                                                          : lineNumber == 9? Color(0xffBB8336)
                                                                          : Color(0xffBDB092)
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 30,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  SizedBox(height: 10,),
                                                                  Text('DATE',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5)),
                                                                  SizedBox(height: 10,),
                                                                  Text(DateFormat('M-dd').format(DateTime.now()),style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5)),
                                                                ],),
                                                              SizedBox(width: 15,),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  SizedBox(height: 10,),
                                                                  Text('SEAT',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5)),
                                                                  SizedBox(height: 10,),
                                                                  Text('1XX',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5)),
                                                                ],),
                                                              SizedBox(width: 15,),
                                                              Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  SizedBox(height: 10,),
                                                                  Text('CLASS',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5)),
                                                                  SizedBox(height: 10,),
                                                                  Text('FIRST C',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12.5))
                                                                ],),
                                                              SizedBox(width: 30,),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          actions: <Widget>[
                                            SizedBox(
                                              child: TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black),
                                                  )),
                                            ),
                                            SizedBox(
                                              child: TextButton( /// setState를 없애고 streambuilder 사용가능
                                                  onPressed: () {
                                               setState(() {
                                                 print('subwayName1 => ${subwayName1}');
                                                 print('passenger1 => ${passenger1}');
                                                 findMyposition(SubwayInfo2,lat1,lng1,subwayName1);
                                                 Navigator.pop(context);
                                               });

                                                  },
                                                  child: Text(
                                                    'Adapt',
                                                    style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.black),
                                                  )),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    icon: RotatedBox(
                                      quarterTurns: 3,
                                      child: Icon(
                                        Icons.subway,
                                        size: mainBoxHeight/7.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: mainBoxHeight/9,),

                              Container(
                                child: Center(
                                  child: Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('NUMBER', style: TextStyle(fontSize: mainBoxHeight/25, fontWeight: FontWeight.bold),),
                                            SizedBox(height: mainBoxHeight/60,),
                                            Text('23X13P', style: TextStyle(fontSize: mainBoxHeight/25, fontWeight: FontWeight.bold),)
                                          ],
                                        ),
                                        SizedBox(width: mainBoxHeight/20,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text('GATE', style: TextStyle(fontSize: mainBoxHeight/25, fontWeight: FontWeight.bold),),
                                            SizedBox(height: mainBoxHeight/60,),
                                            Text('0010', style: TextStyle(fontSize: mainBoxHeight/25, fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                      ]
                                  ),
                                ),
                              ),
                              SizedBox(height: mainBoxHeight/9,),
                              ///-----------------------------------------
                              RotatedBox(
                                quarterTurns: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text('DATE', style: TextStyle(fontWeight: FontWeight.bold, fontSize: mainBoxHeight/25),),
                                        SizedBox(width: mainBoxHeight/25,),
                                        Text('SEAT', style: TextStyle(fontWeight: FontWeight.bold, fontSize: mainBoxHeight/25),),
                                        SizedBox(width: mainBoxHeight/25,),
                                        Text('CLASS', style: TextStyle(fontWeight: FontWeight.bold, fontSize: mainBoxHeight/25),),
                                      ],
                                    ),
                                    SizedBox(
                                      height: mainBoxHeight/60,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          DateFormat('M/dd ').format(DateTime.now()),
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: mainBoxHeight/25),
                                        ),
                                        SizedBox(width: mainBoxHeight/25,),
                                        Text('1XX',style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: mainBoxHeight/25),),
                                        SizedBox(width: mainBoxHeight/25,),
                                        Text('FIRST C',style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: mainBoxHeight/25),),
                                      ],
                                    ),
                                    SizedBox(
                                      height: mainBoxHeight/10,
                                    ),
                                    Text(
                                      'PASSENGER :',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: mainBoxHeight/25),
                                    ),
                                    SizedBox(
                                      height: mainBoxHeight/40,
                                    ),
                                    Text(
                                      '${passenger1}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: mainBoxHeight/30),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: mainBoxHeight/60,),
              Expanded(
                child: Container(
                  color: Colors.white,
                  height: appHeight * 0.35,
                  // width: appWidth * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // SizedBox(width: mainBoxWidth/30,),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: BarcodeWidget(
                          data: '-------LAFAYETTE.co--------',style: TextStyle(fontWeight: FontWeight.bold),
                          barcode: Barcode.code128(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
