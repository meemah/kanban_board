import 'package:boardview/board_callbacks.dart';
import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/theme/app_textstyle.dart';
import 'package:kanban_board/core/widgets/app_snackbar.dart';
import 'package:kanban_board/core/widgets/app_states/empty_state_widget.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/presentation/bloc/kanban_bloc/kanban_bloc.dart';
import 'package:kanban_board/feature/task/presentation/views/kanban_board/widget/kanban_board_card.dart';
import 'package:kanban_board/generated/l10n.dart';

class KanbanBoardContainer extends StatefulWidget {
  const KanbanBoardContainer({super.key});

  @override
  State<KanbanBoardContainer> createState() => _KanbanBoardContainerState();
}

class _KanbanBoardContainerState extends State<KanbanBoardContainer> {
  late BoardController boardController;

  int _currentListIndex = 0;

  @override
  void initState() {
    super.initState();
    boardController = BoardController();
    boardController.itemWidth = 300;
    _setupCallbacks();
  }

  void _setupCallbacks() {
    boardController.setCallbacks(
      BoardCallbacks(
        onScroll: (position, maxExtent) {
          final newIndex = (position / 300).round();
          if (newIndex != _currentListIndex) {
            setState(() {
              _currentListIndex = newIndex;
            });
          }
        },

        onError: (error, stackTrace) => AppSnackBar.show(
          context,
          message: error,
          appSnackbarType: AppSnackbarType.failed,
        ),
      ),
    );
  }

  @override
  void dispose() {
    boardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KanbanBloc, KanbanState>(
      builder: (context, state) {
        if (state is KanbanSuccess) {
          if (state.tasks.values.expand((list) => list).toList().isEmpty) {
            return EmptyStateWidget(message: S.current.youHaveNoTaskYet);
          }
          return RefreshIndicator(
            onRefresh: () async =>
                context.read<KanbanBloc>().add(GetAllTaskEvent()),
            child: BoardView(
              lists: TaskStatus.values.map((status) {
                final tasks = state.getTasksByStatus(status);
                return BoardList(
                  headerBackgroundColor: status.color.withValues(alpha: 0.3),
                  backgroundColor: AppColors.gray50,
                  header: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          status.title,
                          style: AppTextStyle.bodySemibold(color: status.color),
                        ),
                      ),
                    ),
                  ],
                  items: tasks.map((task) {
                    return BoardItem(
                      item: KanbanBoardCard(taskEntity: task),
                      onStartDragItem: (listIndex, itemIndex, state) {
                        boardController.notifyDragStart(listIndex!, itemIndex!);
                      },
                      onDropItem:
                          (
                            newListIndex,
                            newItemIndex,
                            oldListIndex,
                            oldItemIndex,
                            BoardItemState state,
                          ) {
                            final blocState = context.read<KanbanBloc>().state;

                            if (blocState is! KanbanSuccess) return;
                            if (newListIndex! < oldListIndex!) {
                              AppSnackBar.show(
                                context,
                                message: S.current.youCanOnlyMoveTasksForward,
                                appSnackbarType: AppSnackbarType.info,
                              );

                              boardController.notifyDragCancel(
                                oldListIndex,
                                oldItemIndex!,
                              );
                              return;
                            }

                            final oldStatus = TaskStatus.values[oldListIndex];
                            final newStatus = TaskStatus.values[newListIndex];

                            final task = blocState.getTasksByStatus(
                              oldStatus,
                            )[oldItemIndex!];

                            context.read<KanbanBloc>().add(
                              MoveTaskEvent(
                                task: task,
                                oldStatus: oldStatus,
                                newStatus: newStatus,
                              ),
                            );

                            boardController.notifyDragEnd(
                              oldListIndex,
                              oldItemIndex,
                              newListIndex,
                              newItemIndex!,
                            );
                          },
                    );
                  }).toList(),
                );
              }).toList(),
              boardController: boardController,
              width: 300,
              scrollbar: true,
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
