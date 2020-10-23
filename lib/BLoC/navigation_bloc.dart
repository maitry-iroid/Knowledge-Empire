import 'package:ke_employee/models/homedata.dart';
import 'package:rxdart/rxdart.dart';

final navigationBloc = NavigationBloc();

class NavigationBloc {
  final _navigationSubject = PublishSubject<HomeData>();
  final _coinAnimSubject = PublishSubject<bool>();

  Observable<HomeData> get navigationKey => _navigationSubject.stream;

  Observable<bool> get isCoinVisible => _coinAnimSubject.stream;

  updateNavigation(HomeData homeData) async {
    _navigationSubject.sink.add(homeData);
    return _navigationSubject.stream.distinct();
  }

  setIsCoinVisible(bool isCoinVisible) async {
    _coinAnimSubject.sink.add(isCoinVisible);
    return _coinAnimSubject.stream.distinct();
  }


  dispose() {
    _navigationSubject.close();
    _coinAnimSubject.close();
  }
}
