import 'package:intl/intl.dart';

class Utils {
  static String formatoFecha(DateTime fecha) {
    return DateFormat('yyyy-MM-dd').format(fecha);
  }
}
