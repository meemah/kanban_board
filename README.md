# Kanban Task Manager (Flutter)

A Flutter-based Kanban task management application built using Clean Architecture and BLoC.  
The app integrates the Todoist API for task management and uses Hive for local persistence of task timers and completed task history.

## Demo Video

https://github.com/user-attachments/assets/abcd-1234

## Download APK

[Download latest APK](https://github.com/USERNAME/REPO/releases/download/v1.0.0/app-release.apk)

## Screenshots
<p float="left">
  <img src="https://github.com/user-attachments/assets/57630513-b445-445a-b972-72407fe99ac0" width="180" />
  <img src="https://github.com/user-attachments/assets/fc83b16a-f699-4b52-9972-19a24897c735" width="180" />
  <img src="https://github.com/user-attachments/assets/2f17b73d-5749-4778-9497-f332b227f31e" width="180" />
  <img src="https://github.com/user-attachments/assets/c7f341a0-0db9-474a-8007-90560ba20ae3" width="180" />
  <img src="https://github.com/user-attachments/assets/8d02506b-a3a2-402f-a5c5-c7eff5701be9" width="180" />
</p>

<p float="left">
  <img src="https://github.com/user-attachments/assets/554bacb3-f51a-4991-b1a5-2a3993c17a2c" width="180" />
  <img src="https://github.com/user-attachments/assets/401d5384-c360-4966-97b6-50613f03a436" width="180" />
  <img src="https://github.com/user-attachments/assets/10e068bd-8bde-4fb6-b13f-79efa140d70a" width="180" />
  <img src="https://github.com/user-attachments/assets/fdccaa44-a463-4146-ad34-571ab96ae28d" width="180" />
  <img src="https://github.com/user-attachments/assets/2c89e8be-23ad-45ab-9445-806d20f24ef9" width="180" />
</p>

<p float="left">
  <img src="https://github.com/user-attachments/assets/fdccaa44-a463-4146-ad34-571ab96ae28d" width="180" />
  <img src="https://github.com/user-attachments/assets/2c89e8be-23ad-45ab-9445-806d20f24ef9" width="180" />
</p>


## Features

- Kanban Board
  - View tasks by status: To Do, In Progress, Completed
  - Switch between Board view and Tab view
  - Forward-only task progression to enforce workflow integrity

- Task Management
  - Create new tasks
  - Update existing tasks(However, completed cannot be updated)
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
- Flutter (stable channel). The app was built using  v3.32.5
- Todoist account

Steps:
1. Copy `.env.example` to `.env`
2. Obtain your API token from the Todoist application
3. Paste the token into the `.env` file as `TODOIST_API_TOKEN`

4. RUn `flutter pub run build_runner build`

