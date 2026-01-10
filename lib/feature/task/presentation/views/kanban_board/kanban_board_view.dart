import 'package:boardview/board_callbacks.dart';
import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/theme/font_family.dart';
import 'package:kanban_board/core/util/navigation/app_routes.dart';
import 'package:kanban_board/core/widgets/app_snackbar.dart';
import 'package:kanban_board/core/widgets/app_states/empty_state_widget.dart';
import 'package:kanban_board/core/widgets/app_states/error_state_widget.dart';
import 'package:kanban_board/core/widgets/app_states/loading_state_widget.dart';
import 'package:kanban_board/feature/task/domain/entities/task.dart';
import 'package:kanban_board/feature/task/presentation/bloc/kanban_board_bloc/kanban_board_bloc.dart';
import 'package:kanban_board/feature/task/presentation/views/kanban_board/widget/kanban_board_card.dart';

class KanbanBoardView extends StatefulWidget {
  const KanbanBoardView({super.key});

  @override
  State<KanbanBoardView> createState() => _KanbanBoardViewState();
}

class _KanbanBoardViewState extends State<KanbanBoardView> {
  late BoardController boardController;

  int _currentListIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<KanbanBoardBloc>().add(GetAllTaskEvent());
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
    return Scaffold(
      floatingActionButton: GestureDetector(
        onTap: () => context.pushNamed(AppRouteName.taskUpsert),
        child: Container(
          height: 50.h,
          width: 50.w,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(1, 1),
                color: Colors.black.withValues(alpha: 0.1),
              ),
            ],
            shape: BoxShape.circle,
            color: AppColors.primary,
          ),
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.grey[100],
          child: BlocBuilder<KanbanBoardBloc, KanbanBoardState>(
            builder: (context, state) {
              if (state is KanbanBoardLoading) {
                return LoadingStateWidget(message: "Setting up your tasks");
              }
              if (state is KanbanBoardFailure) {
                return ErrorStateWidget(message: state.errorMessage);
              }
              if (state is KanbanBoardSuccess) {
                if (state.tasks.values.isEmpty) {
                  EmptyStateWidget(message: "You have no task yet");
                }
                return BoardView(
                  lists: TaskStatus.values.map((status) {
                    final tasks = state.getTasksByStatus(status);
                    return BoardList(
                      headerBackgroundColor: Colors.blue[100],
                      backgroundColor: Colors.grey[50],
                      header: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              status.title,
                              style: TextStyle(
                                fontFamily: FontFamily.merriweather.value,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[800],
                              ),
                            ),
                          ),
                        ),
                      ],
                      items: tasks.map((task) {
                        return BoardItem(
                          item: KanbanBoardCard(taskEntity: task),
                          onStartDragItem: (listIndex, itemIndex, state) {
                            boardController.notifyDragStart(
                              listIndex!,
                              itemIndex!,
                            );
                          },
                          onDropItem:
                              (
                                newListIndex,
                                newItemIndex,
                                oldListIndex,
                                oldItemIndex,
                                state,
                              ) {
                                // context.read<KanbanBoardBloc>().add(
                                //   MoveTaskEvent(
                                //     task: task,
                                //     toStatus: TaskStatus.values[newListIndex!],
                                //   ),
                                // );

                                boardController.notifyDragEnd(
                                  oldListIndex!,
                                  oldItemIndex!,
                                  newListIndex!,
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
                );
              }
              return SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
