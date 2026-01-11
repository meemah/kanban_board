// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(status) => "No tasks in ${status}";

  static String m1(action) => "Task ${action}";

  static String m2(action) => "${action} Task";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add": MessageLookupByLibrary.simpleMessage("Add"),
        "addAComment": MessageLookupByLibrary.simpleMessage("Add a comment.."),
        "added": MessageLookupByLibrary.simpleMessage("Added"),
        "comments": MessageLookupByLibrary.simpleMessage("COMMENTS"),
        "completedHistory":
            MessageLookupByLibrary.simpleMessage("Completed History"),
        "createTask": MessageLookupByLibrary.simpleMessage("Create Task"),
        "description": MessageLookupByLibrary.simpleMessage("Description"),
        "history": MessageLookupByLibrary.simpleMessage("History"),
        "home": MessageLookupByLibrary.simpleMessage("Home"),
        "kanbanBoard": MessageLookupByLibrary.simpleMessage("Kanban Board"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "loadingCompletedTasks":
            MessageLookupByLibrary.simpleMessage("Loading Completed Tasks"),
        "loadingData": MessageLookupByLibrary.simpleMessage("Loading data.."),
        "move": MessageLookupByLibrary.simpleMessage("Move"),
        "moveTicketToInprogressToStartTimer":
            MessageLookupByLibrary.simpleMessage(
                "Move ticket to In-Progress to start timer"),
        "noCommentsYet":
            MessageLookupByLibrary.simpleMessage("No comments yet...."),
        "noDataAvailable":
            MessageLookupByLibrary.simpleMessage("No data available"),
        "noDescription": MessageLookupByLibrary.simpleMessage("No description"),
        "noTasksInStatus": m0,
        "oppsErrorOccured":
            MessageLookupByLibrary.simpleMessage("Opps, error occured"),
        "pause": MessageLookupByLibrary.simpleMessage("Pause"),
        "paused": MessageLookupByLibrary.simpleMessage("PAUSED"),
        "resume": MessageLookupByLibrary.simpleMessage("Resume"),
        "retry": MessageLookupByLibrary.simpleMessage("Retry"),
        "running": MessageLookupByLibrary.simpleMessage("RUNNING"),
        "settingUpYourTasks":
            MessageLookupByLibrary.simpleMessage("Setting up your tasks"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "stop": MessageLookupByLibrary.simpleMessage("Stop"),
        "taskAction": m1,
        "taskDetails": MessageLookupByLibrary.simpleMessage("Task Details"),
        "taskTitle": MessageLookupByLibrary.simpleMessage("Task Title"),
        "taskTitleIsRequired":
            MessageLookupByLibrary.simpleMessage("Task title is required"),
        "today": MessageLookupByLibrary.simpleMessage("Today"),
        "totalTime": MessageLookupByLibrary.simpleMessage("Total Time"),
        "unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
        "update": MessageLookupByLibrary.simpleMessage("Update"),
        "updated": MessageLookupByLibrary.simpleMessage("Updated"),
        "upsertTaskPageTitle": m2,
        "whatNeedsToBeDone":
            MessageLookupByLibrary.simpleMessage("What needs to be done?"),
        "youCanOnlyMoveTasksForward": MessageLookupByLibrary.simpleMessage(
            "You can only move tasks forward"),
        "youHaveNoTaskYet":
            MessageLookupByLibrary.simpleMessage("You have no task yet")
      };
}
