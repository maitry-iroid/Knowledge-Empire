import 'package:ke_employee/BLoC/repository.dart';
import 'package:ke_employee/models/get_learning_module.dart';
import 'package:rxdart/rxdart.dart';

class ModuleBloc {
  Repository _repository = Repository();

  final _weatherFetcher = PublishSubject<LearningModuleResponse>();

  Observable<LearningModuleResponse> get weather => _weatherFetcher.stream;

  fetchModules(int isChallenge ) async {
    LearningModuleResponse weatherResponse = await _repository.fetchModule( isChallenge);
    _weatherFetcher.sink.add(weatherResponse);
  }

  dispose() {
    _weatherFetcher.close();
  }
}

final weatherBloc = ModuleBloc();