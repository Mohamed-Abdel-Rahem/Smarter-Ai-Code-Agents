import 'dart:async';

import '../domain/dynamic_issue.dart';

class DynamicIssueBloc {
  DynamicIssueBloc() {
    _stateController.add(_state);
  }

  final StreamController<DynamicIssueState> _stateController =
      StreamController<DynamicIssueState>.broadcast();

  DynamicIssueState _state = DynamicIssueState.initial();

  Stream<DynamicIssueState> get stream => _stateController.stream;

  DynamicIssueState get currentState => _state;

  void completeNextStep() {
    final nextIndex = _state.steps.indexWhere((step) => !step.isComplete);
    if (nextIndex == -1) {
      return;
    }

    final updatedSteps = List<DynamicIssueStep>.of(_state.steps);
    updatedSteps[nextIndex] = updatedSteps[nextIndex].copyWith(
      isComplete: true,
    );

    final allComplete = updatedSteps.every((step) => step.isComplete);
    _state = _state.copyWith(
      status: allComplete
          ? DynamicIssueStatus.readyToClose
          : DynamicIssueStatus.inProgress,
      steps: updatedSteps,
    );
    _stateController.add(_state);
  }

  void dispose() {
    _stateController.close();
  }
}
