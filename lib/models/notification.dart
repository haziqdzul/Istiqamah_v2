class Notification {
  static final Notification _notiID = Notification._internal();
  int? product;
  int? tahajjud;
  int? sedekah;
  int? medicine1;
  int? medicine2;
  List<int>? water;
  factory Notification() {
    return _notiID;
  }

  Notification._internal();
}

final notiID = Notification();
