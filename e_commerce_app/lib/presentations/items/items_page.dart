import 'package:e_commerce_app/core/bloc/app_bloc.dart';
import 'package:e_commerce_app/core/bloc/app_state.dart';
import 'package:ec_core/ec_core.dart';
import 'package:ec_themes/ec_design.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/di/api_client_module.dart';
import '../comments/comments_page.dart';
import 'bloc/items_bloc.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (_) =>
              ItemsBloc(apiClient: ApiClientModule.apiClient)
                ..add(LoadRequested()),
      child: const _ItemsView(),
    );
  }
}

class _ItemsView extends StatelessWidget {
  const _ItemsView();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<AppBloc, AppState>(
      builder: (context, appState) {
        final flags = appState.flags;
        final isItemsEnabled = flags.enableItemsPage ?? false;

        if (!isItemsEnabled) {
          return Scaffold(
            appBar: EcAppBar(title: const EcHeadlineSmallText('Items')),
            body: const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: EcBodyLargeText(
                  'The Items feature is not available for now',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }

        return Scaffold(
          body: BlocBuilder<ItemsBloc, ItemsState>(
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  EcSliverAppBar(
                    title: 'Items',
                    actions: [
                      IconButton(
                        icon: const Icon(Icons.refresh),
                        onPressed:
                            () => context.read<ItemsBloc>().add(
                              const LoadRequested(),
                            ),
                        tooltip: 'Refresh data',
                      ),

                      // Show debug button only if debug mode is enabled
                    ],
                  ),

                  if (state.status == ItemsStatus.loading) ...[
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: _LoadingWidget(),
                    ),
                  ] else if (state.status == ItemsStatus.failure) ...[
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: _FailureWidget(state),
                    ),
                  ] else if (state.items.isEmpty) ...[
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: _EmptyWidget(),
                    ),
                  ] else ...[
                    const SliverToBoxAdapter(child: SizedBox(height: 16)),
                    SliverList.separated(
                      itemCount: state.items.length,
                      itemBuilder: (context, index) {
                        final item =
                            state.items[index] as Map<String, dynamic>?;
                        final title =
                            item?['title']?.toString() ?? 'Item ${index + 1}';
                        final subtitle = item?['body']?.toString();
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Material(
                            elevation: 4,
                            shadowColor: colorScheme.onSecondary.withValues(
                              alpha: 0.9,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            child: ListTile(
                              tileColor: colorScheme.onSecondary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              title: EcTitleLargeText(title),
                              subtitle:
                                  subtitle != null
                                      ? Padding(
                                        padding: const EdgeInsets.only(top: 6),
                                        child: EcBodyMediumText(
                                          subtitle,
                                          color: colorScheme.surface,
                                        ),
                                      )
                                      : null,
                              leading: CircleAvatar(
                                backgroundColor: colorScheme.surfaceDim,
                                child: EcTitleMediumText('${index + 1}'),
                              ),
                              trailing: const Icon(Icons.comment_outlined),
                              onTap: () {
                                final postId = item?['id'] ?? index + 1;
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder:
                                        (_) =>
                                            CommentsPage(postId: postId as int),
                                  ),
                                );
                              },
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, __) => SizedBox(height: 16),
                    ),
                  ],
                ],
              );
            },
          ),
          floatingActionButton: FabDebugButton(
            onSelectedMockBackend: (scenario) {
              if (ApiPosts.values.contains(scenario.payload)) {
                context.read<ItemsBloc>().add(const LoadRequested());
              }
            },
            debugToolsScenarios: [
              DebugToolsItem(
                name: 'Success Scenario',
                onTap: () {
                  context.read<ItemsBloc>().add(
                    const DebugScenarioRequested(DebugToolScenarios.success),
                  );
                },
              ),
              DebugToolsItem(
                name: 'Empty Scenario',
                onTap: () {
                  context.read<ItemsBloc>().add(
                    const DebugScenarioRequested(DebugToolScenarios.empty),
                  );
                },
              ),
              DebugToolsItem(
                name: 'Error Scenario',
                onTap: () {
                  context.read<ItemsBloc>().add(
                    const DebugScenarioRequested(DebugToolScenarios.error),
                  );
                },
              ),
              DebugToolsItem(
                name: 'Api Scenario',
                onTap: () {
                  context.read<ItemsBloc>().add(
                    const DebugScenarioRequested(DebugToolScenarios.api),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EmptyWidget extends StatelessWidget {
  const _EmptyWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text('No data available'),
        ],
      ),
    );
  }
}

class _FailureWidget extends StatelessWidget {
  const _FailureWidget(this.state);

  final ItemsState state;

  @override
  Widget build(BuildContext context) {
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
                  () => context.read<ItemsBloc>().add(const LoadRequested()),
              child: const Text('Try again!'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
