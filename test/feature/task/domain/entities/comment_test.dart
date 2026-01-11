import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/feature/task/domain/entities/comment.dart';

void main() {
  group('CommentEntity', () {
    test('creates comment with required fields', () {
      final comment = CommentEntity(
        id: '1',
        taskId: 'task1',
        content: 'Test comment',
        postedAt: DateTime(2024, 1, 1),
      );

      expect(comment.id, '1');
      expect(comment.taskId, 'task1');
      expect(comment.content, 'Test comment');
      expect(comment.isPending, false);
    });

    test('isPending defaults to false', () {
      final comment = CommentEntity(
        id: '1',
        taskId: 'task1',
        content: 'Test',
        postedAt: DateTime(2024, 1, 1),
      );

      expect(comment.isPending, false);
    });
  });
}
