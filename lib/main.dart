
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:wealth_wise/utils/fireBase_option/firebase_options.dart';
import 'config/binding_routing/app_bindings.dart';
import 'my_app/my_app.dart';

void main() async{
 WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
 AuthBinding().dependencies();
  runApp( MyApp());

}
