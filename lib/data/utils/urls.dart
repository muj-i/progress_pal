class Urls {
  Urls._();

  static const String _baseUrl = "https://task.teamrabbil.com/api/v1";
  static String registration = "$_baseUrl/registration";
  static String login = "$_baseUrl/login";
  static String createTask = "$_baseUrl/createTask";
  static String summaryCardCount = "$_baseUrl/taskStatusCount";
  static String newListTasks = "$_baseUrl/listTaskByStatus/New";
  static String completeListTasks = "$_baseUrl/listTaskByStatus/Completed";
  static String cancelListTasks = "$_baseUrl/listTaskByStatus/Canceled";
   static String progressListTasks = "$_baseUrl/listTaskByStatus/In Progress";
}
