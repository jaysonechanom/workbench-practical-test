# workbench_simple_timesheet_app

A new Flutter project.

## Getting Started

## Features

- **Encrypted Local Database** using `sqflite_sqlcipher`
- **State Management** with `bloc` and `flutter_bloc`
- **Dependency Injection** using `get_it`
- **Value Equality** with `equatable`
- **Environment Variable Management** using `flutter_dotenv`
- **Date and Time Formatting** via `intl`
- **Model Serialization** using `json_annotation`

## Folders
## Clean Architecture Pattern

- **core** core folders
- **core/db** local database folder
- **core/di** dependency injection folder
- **core/utils** utilities folder

- **src** main folders
- **src/timesheet** feature folder
- **src/data**
- **src/domain**
- **src/presentation**

## Install Dependencies

- **flutter pub get**

## Generate JSON Serialization Code

- **flutter pub run build_runner build**

## Run the App

- **flutter run**