enum DynamicIssueStatus { open, inProgress, readyToClose }

class DynamicIssueStep {
  const DynamicIssueStep({
    required this.title,
    required this.description,
    required this.isComplete,
  });

  final String title;
  final String description;
  final bool isComplete;

  DynamicIssueStep copyWith({bool? isComplete}) {
    return DynamicIssueStep(
      title: title,
      description: description,
      isComplete: isComplete ?? this.isComplete,
    );
  }
}

class DynamicIssueState {
  const DynamicIssueState({
    required this.issueNumber,
    required this.title,
    required this.status,
    required this.steps,
  });

  factory DynamicIssueState.initial() {
    return const DynamicIssueState(
      issueNumber: 2,
      title: 'Add dynamic issue support',
      status: DynamicIssueStatus.open,
      steps: [
        DynamicIssueStep(
          title: 'Create issue',
          description:
              'Confirm GitHub MCP can create issues for this repository.',
          isComplete: true,
        ),
        DynamicIssueStep(
          title: 'Keep issue open',
          description: 'Keep the issue available for follow-up testing.',
          isComplete: false,
        ),
        DynamicIssueStep(
          title: 'Validate updates',
          description: 'Validate comments, updates, and closing flows.',
          isComplete: false,
        ),
      ],
    );
  }

  final int issueNumber;
  final String title;
  final DynamicIssueStatus status;
  final List<DynamicIssueStep> steps;

  int get completedSteps => steps.where((step) => step.isComplete).length;

  bool get isComplete => completedSteps == steps.length;

  DynamicIssueState copyWith({
    DynamicIssueStatus? status,
    List<DynamicIssueStep>? steps,
  }) {
    return DynamicIssueState(
      issueNumber: issueNumber,
      title: title,
      status: status ?? this.status,
      steps: steps ?? this.steps,
    );
  }
}
