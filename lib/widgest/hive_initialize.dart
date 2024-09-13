import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveDb {
  static late Box cartBox;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    cartBox = await Hive.openBox('cart');
  }
}
