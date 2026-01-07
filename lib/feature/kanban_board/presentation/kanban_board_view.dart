import 'package:boardview/board_callbacks.dart';
import 'package:boardview/board_item.dart';
import 'package:boardview/board_list.dart';
import 'package:boardview/boardview.dart';
import 'package:boardview/boardview_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:kanban_board/core/theme/app_colors.dart';
import 'package:kanban_board/core/theme/app_textstyle.dart';
import 'package:kanban_board/core/theme/font_family.dart';
import 'package:kanban_board/core/widgets/app_card.dart';

class KanbanBoardView extends StatefulWidget {
  const KanbanBoardView({super.key});

  @override
  State<KanbanBoardView> createState() => _KanbanBoardViewState();
}

class _KanbanBoardViewState extends State<KanbanBoardView> {
  late BoardController boardController;
  final List<BoardListObject> _listData = [
    BoardListObject(
      title: "To Do",
      items: [
        BoardItemObject(title: "Task 1"),
        BoardItemObject(title: "Task 2"),
        BoardItemObject(title: "Task 3"),
      ],
    ),
    BoardListObject(
      title: "In Progress",
      items: [
        BoardItemObject(title: "Task 4"),
        BoardItemObject(title: "Task 5"),
      ],
    ),
    BoardListObject(
      title: "Done",
      items: [
        BoardItemObject(title: "Task 6"),
        BoardItemObject(title: "Task 7"),
        BoardItemObject(title: "Task 8"),
        BoardItemObject(title: "Task 9"),
      ],
    ),
  ];

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

        onError: (error, stackTrace) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Error: $error')));
        },
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
      body: SafeArea(
        child: Container(
          color: Colors.grey[100],
          child: BoardView(
            lists: _listData
                .map(
                  (BoardListObject listObject) => BoardList(
                    onStartDragList: (int? listIndex) {},
                    onTapList: (int? listIndex) async {},
                    onDropList: (int? listIndex, int? oldListIndex) {
                      var list = _listData[oldListIndex!];
                      _listData.removeAt(oldListIndex);
                      _listData.insert(listIndex!, list);

                      boardController.notifyListReorder(
                        oldListIndex,
                        listIndex,
                      );

                      setState(() {});
                    },
                    headerBackgroundColor: Colors.blue[100],
                    backgroundColor: Colors.grey[50],
                    header: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            listObject.title!,
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
                    items: listObject.items!
                        .map(
                          (boardListObject) => BoardItem(
                            onStartDragItem:
                                (
                                  int? listIndex,
                                  int? itemIndex,
                                  BoardItemState? state,
                                ) {
                                  boardController.notifyDragStart(
                                    listIndex!,
                                    itemIndex!,
                                  );
                                },
                            onDropItem:
                                (
                                  int? listIndex,
                                  int? itemIndex,
                                  int? oldListIndex,
                                  int? oldItemIndex,
                                  BoardItemState? state,
                                ) {
                                  var item = _listData[oldListIndex!]
                                      .items![oldItemIndex!];
                                  _listData[oldListIndex].items!.removeAt(
                                    oldItemIndex,
                                  );
                                  _listData[listIndex!].items!.insert(
                                    itemIndex!,
                                    item,
                                  );

                                  boardController.notifyDragEnd(
                                    oldListIndex,
                                    oldItemIndex,
                                    listIndex,
                                    itemIndex,
                                  );

                                  setState(() {});
                                },
                            item: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: 4.w,
                                vertical: 5.h,
                              ),
                              child: AppCard(
                                shadowAlpha: 0.04,
                                radius: 4,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        boardListObject.title!,
                                        style: AppTextstyle.captionSemibold(),
                                      ),
                                      Gap(4.h),
                                      Text("Testing the kanban app"),
                                      Gap(2.h),
                                      Divider(
                                        color: AppColors.textGrayLight
                                            .withValues(alpha: 0.2),
                                      ),
                                      Gap(2.h),
                                      Row(
                                        children: [
                                          Icon(Icons.schedule, size: 16),
                                          const Gap(3),
                                          Text("Oct 26"),
                                          const Spacer(),
                                          Container(
                                            height: 25.h,
                                            width: 25.w,
                                            decoration: BoxDecoration(
                                              color: AppColors.backgroundLight,
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(Icons.person, size: 18),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                )
                .toList(),
            boardController: boardController,
            width: 300,
            scrollbar: true,
          ),
        ),
      ),
    );
  }
}

class BoardItemObject {
  String? title;

  BoardItemObject({this.title}) {
    if (this.title == null) {
      this.title = "";
    }
  }
}

class BoardListObject {
  String? title;
  List<BoardItemObject>? items;

  BoardListObject({this.title, this.items}) {
    if (this.title == null) {
      this.title = "";
    }
    if (this.items == null) {
      this.items = [];
    }
  }
}
