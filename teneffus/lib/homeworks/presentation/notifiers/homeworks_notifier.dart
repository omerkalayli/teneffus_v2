import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:teneffus/homeworks/domain/entities/homework.dart';
import 'package:teneffus/homeworks/domain/homeworks_repository.dart';
import 'package:teneffus/homeworks/presentation/homeworks_state.dart';

part 'homeworks_notifier.g.dart';

final homeworksProvider = StateProvider(
  (ref) => [],
);

@Riverpod(keepAlive: true)
class HomeworksNotifier extends _$HomeworksNotifier {
  late final HomeworksRepository _homeworksRepository;

  @override
  Future<HomeworksState> build() async {
    _homeworksRepository = ref.read(homeworksRepositoryProvider);
    return const HomeworksState.initial();
  }

  Future<void> getHomeworks({required String uid}) async {
    state = const AsyncValue.data(HomeworksState.loading());
    final result = await _homeworksRepository.getHomeworks(uid: uid);
    state = result.fold(
        (failure) => AsyncValue.data(
              HomeworksState.error(failure.message),
            ), (homeworks) {
      ref.read(homeworksProvider.notifier).state = homeworks;
      return AsyncValue.data(
        HomeworksState.success(homeworks),
      );
    });
  }

  Future<void> updateHomework({
    required String uid,
    required String homeworkId,
    required int score,
    required bool isCompleted,
  }) async {
    state = const AsyncValue.data(HomeworksState.loading());
    await _homeworksRepository.updateHomework(
      uid: uid,
      homeworkId: homeworkId,
      score: score,
      isCompleted: isCompleted,
    );
    await getHomeworks(uid: uid);
  }

  Future<bool> addHomework({
    required List<String> studentEmails,
    required Homework homework,
  }) async {
    state = const AsyncValue.data(HomeworksState.loading());
    final result = await _homeworksRepository.addHomework(
      studentEmails: studentEmails,
      homework: homework,
    );
    state = result.fold(
      (failure) => AsyncValue.data(
        HomeworksState.error(failure.message),
      ),
      (_) => const AsyncValue.data(HomeworksState.success([])),
    );
    return result.isRight();
  }
}
