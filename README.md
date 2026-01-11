# Kanban Task Manager (Flutter)

A Flutter-based Kanban task management application built using Clean Architecture and BLoC.  
The app integrates the Todoist API for task management and uses Hive for local persistence of task timers and completed task history.

## Features

- Kanban Board
  - View tasks by status: To Do, In Progress, Completed
  - Switch between Board view and Tab view
  - Forward-only task progression to enforce workflow integrity

- Task Management
  - Create new tasks
  - Update existing tasks
  - Optimistic UI updates for smooth user experience

- Task Status Logic
  - Tasks can only move forward in the workflow:
    - To Do → In Progress → Completed
  - Backward movement is intentionally restricted
  - Completed tasks are automatically timestamped

- Task Timer and History
  - Track time spent on tasks
  - Completed task history stored locally using Hive
  - History grouped by completion date
  - Pull-to-refresh supported

- Localization
  - English language support
  - Easily extendable via ARB files

- Settings
  - Language selection (currently English)



## UX Decisions

- Optimistic updates are used when moving or updating tasks
- UI state updates immediately, with rollback on failure
- Explicit handling of loading, empty, error, and success states
- Forward-only task movement prevents invalid workflow states
- Automatic Kanban refresh after task creation or update



## Architecture

The project follows Clean Architecture principles:

- Presentation layer
  - UI widgets
  - BLoC for state management

- Domain layer
  - Entities
  - Use cases
  - Repository contracts

- Data layer
  - Repository implementations
  - Remote data source (Todoist API)
  - Local data source (Hive)

Example structure:
lib/
├── core/
│ ├── errors/
│ ├── usecases/
│ └── utils/
├── features/
│ ├── kanban/
│ ├── upsert_task/
│ ├── completed_history/
│ └── settings/
├── l10n/
├── shared/
└── main.dart

## Tech Stack

- Flutter
- BLoC (flutter_bloc)
- Clean Architecture
- GoRouter for navigation
- Hive for local persistence
- Todoist REST API
- Intl / ARB for localization
- GetIt for dependency injection

## Environment Variables

This project requires a Todoist API token.

An example environment file is provided in .env.example

## Getting Started

Requirements:
- Flutter (stable channel)
- Dart SDK
- Todoist account

Steps:
1. Copy `.env.example` to `.env`
2. Obtain your API token from the Todoist application
3. Paste the token into the `.env` file as `TODOIST_API_TOKEN`

