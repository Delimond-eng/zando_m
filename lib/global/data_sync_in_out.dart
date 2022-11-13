import 'package:connectivity_plus/connectivity_plus.dart';

import '../repositories/stock_repo/sync.dart';
import 'controllers.dart';

void startSync() async {
  var result = await (Connectivity().checkConnectivity());
  if (result == ConnectivityResult.mobile ||
      result == ConnectivityResult.wifi) {
    if (!authController.checkUser) {
      await SyncStock.syncOut().then((value) => SyncStock.syncIn()
          .then((value) => authController.isSyncIn.value = false));
    } else {
      if (authController.loggedUser.value.userRole == "admin") {
        await SyncStock.syncOut().then((value) => SyncStock.syncIn()
            .then((value) => authController.isSyncIn.value = false));
        await dataController.syncData();
      } else {
        await dataController.syncData();
      }
    }
  } else {
    authController.isSyncIn.value = false;
  }
}
