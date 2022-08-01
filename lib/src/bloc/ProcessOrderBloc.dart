import 'package:deliveryapp/src/models/OrdersDataModel.dart';
import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class ProcessOrderBloc {
  final _repository = Repository();
  final _processOrdersFatcher = PublishSubject<List<OrdersDataModel>>();

  Stream<List<OrdersDataModel>> get allProcessOrders =>
      _processOrdersFatcher.stream;

  fetchAllProcessOrders(userid) async {
    List<OrdersDataModel> processOrders =
        await _repository.processOrder(userid);
    _processOrdersFatcher.sink.add(processOrders);
  }

  dispose() {
    _processOrdersFatcher.close();
  }
}

final blocProcess = ProcessOrderBloc();
