import 'dart:developer';
import 'dart:io';

void checkConnection() async {
  try {
    final result = await InternetAddress.lookup('api.cloudinary.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      log('Internet working');
    }
  } on SocketException catch (_) {
    log('No internet or DNS issue');
  }
}
