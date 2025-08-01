import 'package:flutter/material.dart';
import 'package:marina/common/services/storage.dart';

class Global {
  static late StorageService storageService;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    storageService = await StorageService().init();
  }
}
