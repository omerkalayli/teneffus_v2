import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:teneffus/arabic/getter/getter.dart';
import 'package:teneffus/constants.dart';
import 'package:teneffus/games/presentation/widgets/custom_dropdown.dart';
import 'package:teneffus/gen/assets.gen.dart';
import 'package:teneffus/homeworks/presentation/widgets/homework_card.dart';
import 'package:teneffus/homeworks/presentation/widgets/homework_card_header.dart';
import 'package:teneffus/quiz/presentation/quiz_page.dart';

class HomeworksWidget extends ConsumerStatefulWidget {
  const HomeworksWidget({
    super.key,
    required this.dropdownItems,
    required this.selectedDropdownIndex,
    required this.showEarliestFirst,
    required this.filteredHomeworks,
    required this.onRefresh,
  });

  final List<String> dropdownItems;
  final ValueNotifier<int> selectedDropdownIndex;
  final ValueNotifier<bool> showEarliestFirst;
  final List filteredHomeworks;
  final Future<void> Function() onRefresh;

  @override
  ConsumerState<HomeworksWidget> createState() => _HomeworksWidgetState();
}

class _HomeworksWidgetState extends ConsumerState<HomeworksWidget> {
  final ScrollController _scrollController = ScrollController();
  double _scrollOffset = 0;
  bool isFiltering = false;
  bool _hasJumpedInNotification = false;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double percentScrolled;

    if (_scrollOffset <= 150) {
      percentScrolled = 0.0;
    } else if (_scrollOffset > 150 && _scrollOffset <= 200) {
      percentScrolled = ((_scrollOffset - 150) / 50).clamp(0.0, 1.0);
    } else {
      percentScrolled = 1.0;
    }

    return RefreshIndicator(
      color: textColor,
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 800));
        await widget.onRefresh();
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification &&
              !_hasJumpedInNotification) {
            _hasJumpedInNotification = true;

            Future.microtask(() {
              final offset = _scrollController.offset;

              if (offset > 130 && offset < 260) {
                _scrollController.animateTo(
                  300,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else if (offset < 130) {
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                );
              }
            });
          } else if (notification is ScrollUpdateNotification) {
            _hasJumpedInNotification = false;
          }

          return false;
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            _appBar(percentScrolled),
            SliverList(
                delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      widget.filteredHomeworks.isEmpty
                          ? Center(
                              child: Column(
                                children: [
                                  Assets.images.noHomework
                                      .image(width: 80, height: 80),
                                  const Gap(8),
                                  Text(
                                    "Hmm... Burada hiç ödev görünmüyor.",
                                    style: GoogleFonts.montserrat(
                                        color: textColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            )
                          : Column(children: <Widget>[
                              const Gap(16),
                              Center(
                                child: Text(
                                    "--- ${widget.filteredHomeworks.length} Görev ---",
                                    style: GoogleFonts.montserrat(
                                        color: textColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w900)),
                              ),
                              const Gap(12),
                              ...List.generate(widget.filteredHomeworks.length,
                                  (index) {
                                final homework =
                                    widget.filteredHomeworks[index];
                                final unitId = homework.unit - 1;
                                final lessonId = homework.lesson;
                                final grade = homework.grade;
                                final teacher = homework.teacher;
                                final dueDate = homework.dueDate;
                                final myScore = homework.myScore;
                                final minScore = homework.minScore;
                                final isCompleted = homework.isCompleted;
                                final id = homework.id;
                                final units = UnitGetter.getUnits(grade);
                                final lesson =
                                    units[unitId].lessons[lessonId - 1];

                                final formattedDate =
                                    DateFormat("d MMMM y", "tr_TR")
                                        .format(dueDate);
                                return InkWell(
                                  overlayColor: const WidgetStatePropertyAll(
                                      Colors.transparent),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => QuizPage(
                                          homeworkId: id,
                                          isHomework: true,
                                          minScore: minScore,
                                          selectedUnit: units[unitId],
                                          selectedLesson: lesson,
                                          isAllLessonsSelected: false,
                                          isAllUnitsSelected: false,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Column(
                                    children: [
                                      HomeworkCardHeader(
                                          teacher: teacher,
                                          formattedDate: formattedDate,
                                          isCompleted: isCompleted),
                                      HomeworkCard(
                                          grade: grade,
                                          unitId: unitId,
                                          lesson: lesson,
                                          myScore: myScore,
                                          minScore: minScore),
                                      const Gap(16),
                                    ],
                                  ),
                                );
                              }),
                              const Gap(80)
                            ]),
                      if (widget.filteredHomeworks.length < 10) const Gap(200)
                    ],
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  SliverAppBar _appBar(double percentScrolled) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 336.0,
      toolbarHeight: 56,
      shadowColor: homeworksColor.withValues(alpha: .2),
      backgroundColor: const Color(0xfff5f5f5),
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        titlePadding: const EdgeInsetsDirectional.only(
            start: 16.0, bottom: 16.0, top: 40),
        title: AnimatedContainer(
          duration: const Duration(milliseconds: 00),
          height: 56 - (1.0 - percentScrolled) * 56,
          child: Opacity(
            opacity: percentScrolled,
            child: Row(
              children: [
                Text("Ödevlerim",
                    style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: textColor,
                        fontWeight: FontWeight.bold)),
                const Spacer(),
                InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: () {
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Icon(
                    Icons.keyboard_double_arrow_up_rounded,
                    color: textColor,
                  ),
                ),
                const Gap(16),
              ],
            ),
          ),
        ),
        background: Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
                color: homeworksColor),
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.only(
              bottom: 4,
            ),
            child: Opacity(
              opacity: 1.0 - percentScrolled,
              child: Column(
                children: [
                  Gap(MediaQuery.of(context).padding.top),
                  Expanded(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "ÖDEVLERİM",
                        style: GoogleFonts.balooChettan2(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CustomDropdown(
                            baseColor: Colors.white,
                            items: widget.dropdownItems,
                            selectedIndex: widget.selectedDropdownIndex.value,
                            onSelected: (index) {
                              widget.selectedDropdownIndex.value = index;
                            },
                            disabled: false,
                          ),
                          InkWell(
                            overlayColor: const WidgetStatePropertyAll(
                                Colors.transparent),
                            onTap: () {
                              widget.showEarliestFirst.value =
                                  !widget.showEarliestFirst.value;
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  const Text(
                                    "Tarih",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: homeworksColor, fontSize: 12),
                                  ),
                                  const Gap(2),
                                  Icon(
                                    widget.showEarliestFirst.value
                                        ? Icons.arrow_upward_rounded
                                        : Icons.arrow_downward_rounded,
                                    color: homeworksColor,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Gap(16),
                      Column(
                        children: [
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.info_outline,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                const Gap(4),
                                Text(
                                    "Kartlara tıklayarak hızlıca sınava girebilirsin.",
                                    style: GoogleFonts.montserrat(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                          const Gap(4),
                          Text("Yenilemek için aşağı çek.",
                              style: GoogleFonts.montserrat(
                                  color: Colors.grey[200],
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const Gap(4),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
