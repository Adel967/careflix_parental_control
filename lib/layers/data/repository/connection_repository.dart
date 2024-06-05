import 'package:careflix_parental_control/layers/data/data_provider/connecting_provider.dart';

class ConnectingRepository {
  ConnectingProvider _connectingProvider;

  ConnectingRepository(this._connectingProvider);

  Future<bool> checkIfUserExist(String docId) async {
    return await _connectingProvider.checkIfUserExist(docId);
  }

  Future<bool> checkIfUserHasParentalControl(String docId) async {
    return await _connectingProvider.checkIfUserHasParentalControl(docId);
  }
}
