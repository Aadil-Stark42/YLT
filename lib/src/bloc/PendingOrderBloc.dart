import 'package:deliveryapp/src/models/OrdersDataModel.dart';
import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class PendingOrderBloc {
  final _repository = Repository();
  final _pendingOrdersFatcher = PublishSubject<List<OrdersDataModel>>();

  Stream<List<OrdersDataModel>> get allPendingOrders =>
      _pendingOrdersFatcher.stream;

  fetchAllPendingOrders(userid) async {
    List<OrdersDataModel> pendingorders =
        await _repository.pendingOrder(userid);
    _pendingOrdersFatcher.sink.add(pendingorders);
  }

  dispose() {
    _pendingOrdersFatcher.close();
  }
}

final blocPending = PendingOrderBloc();
