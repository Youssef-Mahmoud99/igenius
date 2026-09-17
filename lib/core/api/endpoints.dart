class EndPoints {
  // auth
  static const String login = "/auth/login";
  static const String register = "/auth/register";
  static const String logout = "/auth/logout";
  static const String forgetPassword = "/auth/forgot-password";
  static const String verifyOtp = "/auth/verify-reset-code";
  static const String resetPassword = "/auth/reset-password";

  // courses
  static const String courses = "/courses";

  // user
  static const String profile = "/student/profile";
  static const String myCourses = "/student/courses";
  static const String getLessonContent = "/student/lessons";
  static const String myPurchasedLessons = "/student/my-lessons";
  static const String markLessonAttendance = "/student/lessons/attend";

  // assignments
  static const String assignments = "/student/assignments";
  static const String myExams = "/student/exams";

  // payment

  static const String getPayments = "/student/payments";
  static const String getInstallments = "/student/installment-requests";
  static const String buyCourse = "/student/purchase/course";
  static const String buyLesson = "/student/purchase/lesson";
  static const String buyInstallment = "/student/purchase/installment";


  // Filters

  static const String subjects = "/subjects";
  static const String boards = "/boards";
  static const String systems = "/systems";
  static const String levels = "/levels";

  // teachers
  static const String teachers = "/teachers";

  // home
  static const String homeData = "/home";
  static const String about = "/about";


  // Reports
  static const String reports = '/student/reports';
  static const String reportsDownload = '/student/reports/download';

  // Support
  static const String support = '/student/support';

  // Notifications
  static const String notifications = '/student/notifications';
  static const String notificationReadPath = '/student/notifications/{id}/read';
  static const String notificationDeletePath = '/student/notifications/{id}';

  // Schedule
  static const String overdues = '/student/overdue';
  static const String upcomings = '/student/upcoming';

}
