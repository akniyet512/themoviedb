import 'package:flutter/material.dart';
import 'package:themoviedb/ui/widgets/my_app/my_app.dart';
import 'package:themoviedb/ui/widgets/my_app/my_app_model.dart';

//API Key: ab2ab6408b60ef0a1487d77c7e8fa3a6
//API Read Access Token: eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJhYjJhYjY0MDhiNjBlZjBhMTQ4N2Q3N2M3ZThmYTNhNiIsInN1YiI6IjY0ZGI1YThmZjQ5NWVlMDI5NDMxYTg5MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Av6MgkQB-i24BWv5_ktrbsmJNS0dCGeiWicyQS8pcAg
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MyAppModel myAppModel = MyAppModel();
  await myAppModel.checkOut();
  runApp(MyApp(myAppModel: myAppModel));
}
