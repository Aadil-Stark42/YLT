import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class TodayOrderBloc {
  final _repository = Repository();
  final _todayOrdersFatcher = PublishSubject<String>();

  Stream<String> get alltodayOrders => _todayOrdersFatcher.stream;

  fetchAllTodayOrder(userid) async {
    String todayorders = await _repository.todayOrder(userid);
    _todayOrdersFatcher.sink.add(todayorders);
  }

  dispose() {
    _todayOrdersFatcher.close();
  }
}

final blocTodayOrders = TodayOrderBloc();
