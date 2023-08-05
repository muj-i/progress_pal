class Urls {
  Urls._();

  static const String _baseUrl = "https://task.teamrabbil.com/api/v1";
  static String registration = "$_baseUrl/registration";
  static String login = "$_baseUrl/login";
  static String createTask = "$_baseUrl/createTask";
  static String summaryCardCount = "$_baseUrl/taskStatusCount";
  static String newListTasks = "$_baseUrl/listTaskByStatus/New";
  static String completeListTasks = "$_baseUrl/listTaskByStatus/Completed";
  static String cancelListTasks = "$_baseUrl/listTaskByStatus/Cancelled";
  static String inProgressListTasks = "$_baseUrl/listTaskByStatus/In Progress";
  static String deleteListTasks(String id) => "$_baseUrl/deleteTask/$id";
  static String updateTasksStatus(String id, String status) =>
      "$_baseUrl/updateTaskStatus/$id/$status";
  static String updateListTasks(String id) => "$_baseUrl/updateTask/$id";
}
