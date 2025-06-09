// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i8;
import 'package:teneffus/auth/presentation/pages/auth_page.dart' as _i1;
import 'package:teneffus/global_entities/lesson.dart' as _i6;
import 'package:teneffus/global_entities/unit.dart' as _i7;
import 'package:teneffus/main/main_layout.dart' as _i2;
import 'package:teneffus/quiz/presentation/quiz_page.dart' as _i3;
import 'package:teneffus/splash_page.dart' as _i4;

/// generated route for
/// [_i1.AuthPage]
class AuthRoute extends _i5.PageRouteInfo<void> {
  const AuthRoute({List<_i5.PageRouteInfo>? children})
    : super(AuthRoute.name, initialChildren: children);

  static const String name = 'AuthRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.AuthPage();
    },
  );
}

/// generated route for
/// [_i2.MainLayoutPage]
class MainLayoutRoute extends _i5.PageRouteInfo<void> {
  const MainLayoutRoute({List<_i5.PageRouteInfo>? children})
    : super(MainLayoutRoute.name, initialChildren: children);

  static const String name = 'MainLayoutRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.MainLayoutPage();
    },
  );
}

/// generated route for
/// [_i3.QuizPage]
class QuizRoute extends _i5.PageRouteInfo<QuizRouteArgs> {
  QuizRoute({
    required _i6.Lesson selectedLesson,
    required _i7.Unit selectedUnit,
    bool isAllLessonsSelected = false,
    bool isAllUnitsSelected = false,
    bool isHomework = false,
    String? homeworkId,
    int? minScore,
    _i8.Key? key,
    List<_i5.PageRouteInfo>? children,
  }) : super(
         QuizRoute.name,
         args: QuizRouteArgs(
           selectedLesson: selectedLesson,
           selectedUnit: selectedUnit,
           isAllLessonsSelected: isAllLessonsSelected,
           isAllUnitsSelected: isAllUnitsSelected,
           isHomework: isHomework,
           homeworkId: homeworkId,
           minScore: minScore,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'QuizRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<QuizRouteArgs>();
      return _i3.QuizPage(
        selectedLesson: args.selectedLesson,
        selectedUnit: args.selectedUnit,
        isAllLessonsSelected: args.isAllLessonsSelected,
        isAllUnitsSelected: args.isAllUnitsSelected,
        isHomework: args.isHomework,
        homeworkId: args.homeworkId,
        minScore: args.minScore,
        key: args.key,
      );
    },
  );
}

class QuizRouteArgs {
  const QuizRouteArgs({
    required this.selectedLesson,
    required this.selectedUnit,
    this.isAllLessonsSelected = false,
    this.isAllUnitsSelected = false,
    this.isHomework = false,
    this.homeworkId,
    this.minScore,
    this.key,
  });

  final _i6.Lesson selectedLesson;

  final _i7.Unit selectedUnit;

  final bool isAllLessonsSelected;

  final bool isAllUnitsSelected;

  final bool isHomework;

  final String? homeworkId;

  final int? minScore;

  final _i8.Key? key;

  @override
  String toString() {
    return 'QuizRouteArgs{selectedLesson: $selectedLesson, selectedUnit: $selectedUnit, isAllLessonsSelected: $isAllLessonsSelected, isAllUnitsSelected: $isAllUnitsSelected, isHomework: $isHomework, homeworkId: $homeworkId, minScore: $minScore, key: $key}';
  }
}

/// generated route for
/// [_i4.SplashPage]
class SplashRoute extends _i5.PageRouteInfo<void> {
  const SplashRoute({List<_i5.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.SplashPage();
    },
  );
}
