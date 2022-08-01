import 'package:deliveryapp/src/models/OrdersDataModel.dart';
import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class OrderBloc {
  final _repository = Repository();
  final _OrdersFatcher = PublishSubject<List<OrdersDataModel>>();

  Stream<List<OrdersDataModel>> get allOrders => _OrdersFatcher.stream;

  fetchAllOrders(userid) async {
    List<OrdersDataModel> Orders = await _repository.Orders(userid);
    _OrdersFatcher.sink.add(Orders);
  }

  dispose() {
    _OrdersFatcher.close();
  }
}

final blocOrders = OrderBloc();
