import '../Utils/MLImage.dart';
import '../models/MLNotificationData.dart';

List<MLNotificationData> mlNotificationDataList() {
  List<MLNotificationData> list = [];
  list.add(MLNotificationData(
      image: ml_ic_doctor_image,
      title:
          'an appointment has been scheduled” in context from reliable sources',
      time: '3m ago',
      status: 'Completed',
      detail: 'Completed'));
  list.add(MLNotificationData(
      image: ml_ic_doctor_image,
      title: 'Dr. sent you a message',
      time: '3m ago',
      status: ''));
  list.add(MLNotificationData(
      image: ml_ic_doctor_image,
      title: 'Vitamins are essential to human health. Here, l',
      time: 'Today at 2.20 AM',
      status: 'Canceled'));
  list.add(MLNotificationData(
      image: ml_ic_doctor_image,
      title:
          'Hey Dustin,. This email confirms your Service Name appointment on Appointment Date Time Client',
      time: 'Today at 11.20 AM',
      status: 'Delivered',
      detail: 'Succesfully delivered to you'));
  list.add(MLNotificationData(
    image: ml_ic_doctor_image,
    title:
        'Hey Dustin,. This email confirms your Service Name appointment on Appointment Date Time Client',
    time: '3m ago',
    status: 'Delivered',
  ));
  return list;
}
