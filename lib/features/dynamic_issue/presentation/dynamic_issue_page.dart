import 'package:flutter/material.dart';

import '../domain/dynamic_issue.dart';
import 'dynamic_issue_bloc.dart';

class DynamicIssuePage extends StatefulWidget {
  const DynamicIssuePage({super.key});

  @override
  State<DynamicIssuePage> createState() => _DynamicIssuePageState();
}

class _DynamicIssuePageState extends State<DynamicIssuePage> {
  late final DynamicIssueBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = DynamicIssueBloc();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DynamicIssueState>(
      stream: _bloc.stream,
      initialData: _bloc.currentState,
      builder: (context, snapshot) {
        final issue = snapshot.requireData;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Dynamic Issue'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '#${issue.issueNumber} ${issue.title}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(_statusText(issue.status)),
                const SizedBox(height: 16),
                LinearProgressIndicator(
                  value: issue.completedSteps / issue.steps.length,
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.separated(
                    itemCount: issue.steps.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      final step = issue.steps[index];

                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          step.isComplete
                              ? Icons.check_circle
                              : Icons.radio_button_unchecked,
                          color: step.isComplete ? Colors.green : null,
                        ),
                        title: Text(step.title),
                        subtitle: Text(step.description),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: issue.isComplete ? null : _bloc.completeNextStep,
            icon: const Icon(Icons.task_alt),
            label: Text(issue.isComplete ? 'Ready' : 'Complete next'),
          ),
        );
      },
    );
  }

  String _statusText(DynamicIssueStatus status) {
    return switch (status) {
      DynamicIssueStatus.open => 'Status: Open',
      DynamicIssueStatus.inProgress => 'Status: In progress',
      DynamicIssueStatus.readyToClose => 'Status: Ready to close',
    };
  }
}
