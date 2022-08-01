import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class TotalOrderBloc {
  final _repository = Repository();
  final _totalOrdersFatcher = PublishSubject<String>();

  Stream<String> get allOrders => _totalOrdersFatcher.stream;

  fetchAllTotalOrders(userid) async {
    String totalorders = await _repository.totalOrders(userid);
    _totalOrdersFatcher.sink.add(totalorders);
  }

  dispose() {
    _totalOrdersFatcher.close();
  }
}

final bloc = TotalOrderBloc();
