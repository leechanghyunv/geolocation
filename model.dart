
class SubwayModel {
  final int line, id;
  final String name;
  final String descrip;
  final double lat, lng;

  SubwayModel({
    required this.line,
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.descrip

  });


}

List<SubwayModel> SubwayInfo2 = [
  SubwayModel(
    id: 2000,
    name: '을지로4가',
    line: 2,
    lat : 37.566040,
    lng : 126.997754,
    descrip: '환승',

  ),
  SubwayModel(
    id: 2001,
    name: '을지로3가',
    line: 2,
    lat : 37.566220,
    lng : 126.990912,
    descrip: '환승',

  ),
  SubwayModel(
    id: 2003,
    name: '을지로입구',
    line: 2,
    lat : 37.566140,
    lng : 126.982561,
    descrip: '',

  ),
  SubwayModel(
    id: 2004,
    name: '시청역',
    line: 2,
    lat : 37.566014,
    lng : 126.982651,
    descrip: '환승'
  ),
  SubwayModel(
    id: 2005,
    name: '충정로',
    line: 3,
    lat : 37.559973,
    lng : 126.963672,
    descrip: '환승',
  ),
  SubwayModel(
    id: 2006,
    name: '아현',
    line: 2,
    lat : 37.557345,
    lng : 126.956141,
    descrip: '',
  ),
  SubwayModel(
    id: 2007,
    name: '이대',
    line: 2,
    lat : 37.556733,
    lng : 126.946013,
    descrip: '',
  ),
  SubwayModel(
    id: 2007,
    name: '신촌',
    line: 2,
    lat : 37.555134,
    lng : 126.936893,
    descrip: '',
  ),
  SubwayModel(
    id: 2007,
    name: '홍대입구',
    line: 2,
    lat : 37.557192,
    lng : 126.925381,
    descrip: '환승',
  ),
  SubwayModel(
    id: 2007,
    name: '합정',
    line: 2,
    lat : 37.549463,
    lng : 126.913739,
    descrip: '환승',
  ),
  SubwayModel(
    id: 2008,
    name: '당산',
    line: 2,
    lat : 37.53438,
    lng : 126.902281,
    descrip: '환승',
  ),
  SubwayModel(
    id: 2009,
    name: '영등포구청',
    line: 2,
    lat : 37.52497,
    lng : 126.895951,
    descrip: '환승',
  ),
  SubwayModel(
    id: 2010,
    name: '로컬스티치을지로',
    line: 7,
    lat : 37.5638,
    lng : 126.999,
    descrip: '환승',
  ),
  SubwayModel(
    id: 2011,
    name: '로컬스티치잔다리',
    line: 7,
    lat : 37.5638,
    lng : 126.999,
    descrip: '환승',
  ),
  SubwayModel(
    id: 2011,
    name: '구글본사',
    line: 7,
    lat : 37.7858,
    lng : -122.406,
    descrip: '환승',
  ),
];