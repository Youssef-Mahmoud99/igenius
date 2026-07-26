class AppUrls {

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
  
  // assignments
  static const String assignments = "/student/assignments";
  static const String myExams = "/student/exams";


  // payment

  static const String getPayments = "/student/payments";
  static const String getInstallments = "/student/installment-requests";
  static const String buyCourse = "/student/purchase/course";
  static const String buyLesson = "/student/purchase/lesson";
  static const String buyInstallment = "/student/purchase/installment";


}
