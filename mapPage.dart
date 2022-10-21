import 'package:barcode_widget/barcode_widget.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class mapPage extends StatefulWidget {
  const mapPage({Key? key}) : super(key: key);

  @override
  State<mapPage> createState() => _mapPageState();
}

class _mapPageState extends State<mapPage> {

  double lat = 0.0, lng = 0.0, lat1 = 0.0, lng1 = 0.0;
  double tracklat =0.0, tracklng =0.0;
  double streamlat =0.0, streamlng =0.0;
  late String subwayName2 = 'invaild location';
  late int lineNumber = 0;
  String QRdata = '1234ffov3pp5oq23lk';

  @override
  Widget build(BuildContext context) {

    double appHeight = MediaQuery.of(context).size.height;
    double appWidth = MediaQuery.of(context).size.width;
    double appRatio = MediaQuery.of(context).size.aspectRatio;
    double mainBoxHeight = appHeight * 0.58;
    double mainBoxWidth = appWidth * 0.915;

    return SafeArea(
        child: Scaffold(
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
                            Navigator.pop(context);
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
                          SizedBox(width: mainBoxHeight/25,),
                          Column(
                            children: [
                              SizedBox(height: mainBoxHeight/20,),
                              Container(
                                alignment: Alignment.center,
                                height: appHeight * 0.58 * 0.90,
                                width: appWidth * 0.70,
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1)
                                ),
                                child: Text('GOOGLE MAP'),
                              ),
                            ],
                          ),
                          SizedBox(width: appRatio >= 0.5? mainBoxHeight/6
                              : mainBoxHeight/15,),


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
                  // width: mainBoxWidth,
                  // width: appWidth * 0.7,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // SizedBox(width: mainBoxWidth/30,),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: BarcodeWidget(
                          data: '----LISTVIEW-----',style: TextStyle(fontWeight: FontWeight.bold),
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
