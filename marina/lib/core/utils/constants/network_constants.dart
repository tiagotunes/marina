abstract class NetworkConstants {
  const NetworkConstants();

  static const baseUrl = 'http://localhost:3000/api/v1';
  static const authority = 'localhost:3000';
  static const headers = {
    'Content-Type': 'application/json',
    'charset': 'UTF-8',
  };
  static const pageSize = 10;
}
