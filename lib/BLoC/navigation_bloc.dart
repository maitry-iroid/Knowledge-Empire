import 'package:ke_employee/models/homedata.dart';
import 'package:rxdart/rxdart.dart';

final navigationBloc = NavigationBloc();

class NavigationBloc {
  final _navigationSubject = PublishSubject<HomeData>();

  Stream<HomeData> get navigationKey => _navigationSubject.stream;

  updateNavigation(HomeData homeData) async {
    _navigationSubject.sink.add(homeData);
    return _navigationSubject.stream.distinct();
  }

  dispose() {
    _navigationSubject.close();
  }
}
