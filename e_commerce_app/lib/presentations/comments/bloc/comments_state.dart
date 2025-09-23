part of 'comments_bloc.dart';

enum CommentsStatus { initial, loading, success, failure }

class CommentsState extends Equatable {
  const CommentsState({
    this.status = CommentsStatus.initial,
    this.comments = const [],
    this.postId = 0,
    this.errorMessage,
  });

  final CommentsStatus status;
  final List<dynamic> comments;
  final int postId;
  final String? errorMessage;

  CommentsState copyWith({
    CommentsStatus? status,
    List<dynamic>? comments,
    int? postId,
    String? errorMessage,
  }) {
    return CommentsState(
      status: status ?? this.status,
      comments: comments ?? this.comments,
      postId: postId ?? this.postId,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, comments, postId, errorMessage];
}
