// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Unknown`
  String get unknown {
    return Intl.message(
      'Unknown',
      name: 'unknown',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `No data available`
  String get noDataAvailable {
    return Intl.message(
      'No data available',
      name: 'noDataAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Loading data..`
  String get loadingData {
    return Intl.message(
      'Loading data..',
      name: 'loadingData',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `History`
  String get history {
    return Intl.message(
      'History',
      name: 'history',
      desc: '',
      args: [],
    );
  }

  /// `Completed History`
  String get completedHistory {
    return Intl.message(
      'Completed History',
      name: 'completedHistory',
      desc: '',
      args: [],
    );
  }

  /// `Loading Completed Tasks`
  String get loadingCompletedTasks {
    return Intl.message(
      'Loading Completed Tasks',
      name: 'loadingCompletedTasks',
      desc: '',
      args: [],
    );
  }

  /// `No description`
  String get noDescription {
    return Intl.message(
      'No description',
      name: 'noDescription',
      desc: '',
      args: [],
    );
  }

  /// `You have no task yet`
  String get youHaveNoTaskYet {
    return Intl.message(
      'You have no task yet',
      name: 'youHaveNoTaskYet',
      desc: '',
      args: [],
    );
  }

  /// `Setting up your tasks`
  String get settingUpYourTasks {
    return Intl.message(
      'Setting up your tasks',
      name: 'settingUpYourTasks',
      desc: '',
      args: [],
    );
  }

  /// `Add a comment..`
  String get addAComment {
    return Intl.message(
      'Add a comment..',
      name: 'addAComment',
      desc: '',
      args: [],
    );
  }

  /// `Task Details`
  String get taskDetails {
    return Intl.message(
      'Task Details',
      name: 'taskDetails',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `COMMENTS`
  String get comments {
    return Intl.message(
      'COMMENTS',
      name: 'comments',
      desc: '',
      args: [],
    );
  }

  /// `No comments yet....`
  String get noCommentsYet {
    return Intl.message(
      'No comments yet....',
      name: 'noCommentsYet',
      desc: '',
      args: [],
    );
  }

  /// `Task Title`
  String get taskTitle {
    return Intl.message(
      'Task Title',
      name: 'taskTitle',
      desc: '',
      args: [],
    );
  }

  /// `What needs to be done?`
  String get whatNeedsToBeDone {
    return Intl.message(
      'What needs to be done?',
      name: 'whatNeedsToBeDone',
      desc: '',
      args: [],
    );
  }

  /// `Task title is required`
  String get taskTitleIsRequired {
    return Intl.message(
      'Task title is required',
      name: 'taskTitleIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Create Task`
  String get createTask {
    return Intl.message(
      'Create Task',
      name: 'createTask',
      desc: '',
      args: [],
    );
  }

  /// `Task {action}`
  String taskAction(String action) {
    return Intl.message(
      'Task $action',
      name: 'taskAction',
      desc: '',
      args: [action],
    );
  }

  /// `Added`
  String get added {
    return Intl.message(
      'Added',
      name: 'added',
      desc: '',
      args: [],
    );
  }

  /// `Updated`
  String get updated {
    return Intl.message(
      'Updated',
      name: 'updated',
      desc: '',
      args: [],
    );
  }

  /// `{action} Task`
  String upsertTaskPageTitle(String action) {
    return Intl.message(
      '$action Task',
      name: 'upsertTaskPageTitle',
      desc: '',
      args: [action],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Opps, error occured`
  String get oppsErrorOccured {
    return Intl.message(
      'Opps, error occured',
      name: 'oppsErrorOccured',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `Kanban Board`
  String get kanbanBoard {
    return Intl.message(
      'Kanban Board',
      name: 'kanbanBoard',
      desc: '',
      args: [],
    );
  }

  /// `Total Time`
  String get totalTime {
    return Intl.message(
      'Total Time',
      name: 'totalTime',
      desc: '',
      args: [],
    );
  }

  /// `RUNNING`
  String get running {
    return Intl.message(
      'RUNNING',
      name: 'running',
      desc: '',
      args: [],
    );
  }

  /// `PAUSED`
  String get paused {
    return Intl.message(
      'PAUSED',
      name: 'paused',
      desc: '',
      args: [],
    );
  }

  /// `Pause`
  String get pause {
    return Intl.message(
      'Pause',
      name: 'pause',
      desc: '',
      args: [],
    );
  }

  /// `Resume`
  String get resume {
    return Intl.message(
      'Resume',
      name: 'resume',
      desc: '',
      args: [],
    );
  }

  /// `Stop`
  String get stop {
    return Intl.message(
      'Stop',
      name: 'stop',
      desc: '',
      args: [],
    );
  }

  /// `Move ticket to In-Progress to start timer`
  String get moveTicketToInprogressToStartTimer {
    return Intl.message(
      'Move ticket to In-Progress to start timer',
      name: 'moveTicketToInprogressToStartTimer',
      desc: '',
      args: [],
    );
  }

  /// `You can only move tasks forward`
  String get youCanOnlyMoveTasksForward {
    return Intl.message(
      'You can only move tasks forward',
      name: 'youCanOnlyMoveTasksForward',
      desc: '',
      args: [],
    );
  }

  /// `No tasks in {status}`
  String noTasksInStatus(Object status) {
    return Intl.message(
      'No tasks in $status',
      name: 'noTasksInStatus',
      desc: 'Message shown when there are no tasks in a particular status',
      args: [status],
    );
  }

  /// `Move`
  String get move {
    return Intl.message(
      'Move',
      name: 'move',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
