part of 'comments_bloc.dart';

enum CommentsStatus { initial, loading, success, failure }

class CommentsState extends Equatable {
  const CommentsState({
    this.status = CommentsStatus.initial,
    this.comments = const [],
    this.errorMessage,
  });

  final CommentsStatus status;
  final List<dynamic> comments;
  final String? errorMessage;

  CommentsState copyWith({
    CommentsStatus? status,
    List<dynamic>? comments,
    String? errorMessage,
  }) {
    return CommentsState(
      status: status ?? this.status,
      comments: comments ?? this.comments,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, comments, errorMessage];
}
