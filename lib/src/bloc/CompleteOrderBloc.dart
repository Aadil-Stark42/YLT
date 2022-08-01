import 'package:deliveryapp/src/models/OrdersDataModel.dart';
import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class CompleteOrderBloc {
  final _repository = Repository();
  final _completeOrdersFatcher = PublishSubject<List<OrdersDataModel>>();

  Stream<List<OrdersDataModel>> get allCompleteOrders =>
      _completeOrdersFatcher.stream;

  fetchAllCompleteOrders(userid) async {
    List<OrdersDataModel> completeOrders =
        await _repository.completeOrder(userid);
    _completeOrdersFatcher.sink.add(completeOrders);
  }

  dispose() {
    _completeOrdersFatcher.close();
  }
}

final blocComplete = CompleteOrderBloc();
