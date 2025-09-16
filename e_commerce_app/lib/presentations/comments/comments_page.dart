import 'package:ec_core/mocked_backend/mock_backend.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/api_client_module.dart';
import 'bloc/comments_bloc.dart';

class CommentsPage extends StatelessWidget {
  const CommentsPage({super.key, required this.postId});

  final int postId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              CommentsBloc(apiClient: ApiClientModule.apiClient)
                ..add(LoadCommentsRequested(postId: postId)),
      child: _CommentsView(postId: postId),
    );
  }
}

class _CommentsView extends StatelessWidget {
  const _CommentsView({required this.postId});

  final int postId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments for Post $postId'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed:
                () => context.read<CommentsBloc>().add(
                  LoadCommentsRequested(postId: postId),
                ),
            tooltip: 'Refresh comments',
          ),
        ],
      ),
      body: BlocBuilder<CommentsBloc, CommentsState>(
        builder: (context, state) {
          if (state.status == CommentsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == CommentsStatus.failure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red),
                    const SizedBox(height: 12),
                    Text(
                      'Error: ${state.errorMessage ?? 'Unknown error'}',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed:
                          () => context.read<CommentsBloc>().add(
                            LoadCommentsRequested(postId: postId),
                          ),
                      child: const Text('Try again!'),
                    ),
                  ],
                ),
              ),
            );
          }

          final comments = state.comments;

          if (comments.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.comment_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('No comments available'),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: comments.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final comment = comments[index] as Map<String, dynamic>?;
              final name = comment?['name']?.toString() ?? 'Anonymous';
              final email = comment?['email']?.toString() ?? '';
              final body = comment?['body']?.toString() ?? '';
              final commentId = comment?['id']?.toString() ?? '${index + 1}';

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(radius: 16, child: Text(commentId)),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  name,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                                if (email.isNotEmpty)
                                  Text(
                                    email,
                                    style: Theme.of(context).textTheme.bodySmall
                                        ?.copyWith(color: Colors.grey[600]),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(body),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: MockScenarioButton<dynamic>(
        title: 'API Scenarios',
        onSelectedMockBackend: (scenario) {
          // Scenario is already set by MockApiPickerPage
          if (ApiComments.values.contains(scenario.payload)) {
            context.read<CommentsBloc>().add(
              LoadCommentsRequested(postId: postId),
            );
          }
        },
      ),
    );
  }
}
