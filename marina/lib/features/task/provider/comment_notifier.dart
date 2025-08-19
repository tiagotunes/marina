import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'comment_notifier.g.dart';

@riverpod
class CommentNotifier extends _$CommentNotifier {
  @override
  String build(String comment) {
    return comment;
  }

  void setComment(String newComment) {
    state = newComment;
  }

  String getComment() {
    return state;
  }
}
