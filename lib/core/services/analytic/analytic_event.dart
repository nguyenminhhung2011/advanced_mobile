enum AnalyticEvent {
  becomeTutor,
  cancelBooTutor,
  login,
  displayTeacherList,
  displaySpecialties,
  filterTeachersBySpecialties,
  addToFavoritesList,
  viewFavoritesList,
  searchForTeachers,
  paginationForSearchResults,
  groupSearchResults,
  displaySearchResults,
  registerAsTeacher,
  displayTotalClassHours,
  displayUpcomingClasses,
  participateInUpcomingClasses,
  displayClassSchedules,
  paginationForClassSchedules,
  viewPastClasses,
  cancelClass,
  displayCurriculumList,
  searchForCurricula,
  paginationForCurriculum,
  viewCurriculumDescription,
  displayCurriculumContent,
  updateProfile,
}

extension AnalyticEventExt on AnalyticEvent {
  String get toName => switch (this) {
        AnalyticEvent.becomeTutor => "become_tutor",
        AnalyticEvent.cancelBooTutor => "cancel_boo_tutor",
        AnalyticEvent.login => "login",
        AnalyticEvent.displayTeacherList => "display_teacher_list",
        AnalyticEvent.displaySpecialties => "display_specialties",
        AnalyticEvent.filterTeachersBySpecialties =>
          "filter_teachers_by_specialties",
        AnalyticEvent.addToFavoritesList => "add_to_favorites_list",
        AnalyticEvent.viewFavoritesList => "view_favorites_list",
        AnalyticEvent.searchForTeachers => "search_for_teachers",
        AnalyticEvent.paginationForSearchResults =>
          "pagination_for_search_results",
        AnalyticEvent.groupSearchResults => "group_search_results",
        AnalyticEvent.displaySearchResults => "display_search_results",
        AnalyticEvent.registerAsTeacher => "register_as_teacher",
        AnalyticEvent.displayTotalClassHours => "display_total_class_hours",
        AnalyticEvent.displayUpcomingClasses => "display_upcoming_classes",
        AnalyticEvent.participateInUpcomingClasses =>
          "participate_in_upcoming_classes",
        AnalyticEvent.displayClassSchedules => "display_class_schedules",
        AnalyticEvent.paginationForClassSchedules =>
          "pagination_for_class_schedules",
        AnalyticEvent.viewPastClasses => "view_past_classes",
        AnalyticEvent.cancelClass => "cancel_class",
        AnalyticEvent.displayCurriculumList => "display_curriculum_list",
        AnalyticEvent.searchForCurricula => "search_for_curricula",
        AnalyticEvent.paginationForCurriculum => "pagination_for_curriculum",
        AnalyticEvent.viewCurriculumDescription =>
          "view_curriculum_description",
        AnalyticEvent.displayCurriculumContent => "display_curriculum_content",
        AnalyticEvent.updateProfile => "update_profile",
      };
}
