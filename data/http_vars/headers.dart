class Header {
  static Map<String, String> contentJson = {
    'Content-Type': 'application/json',
    'Cookie': '',
  };
  static Map<String, String> bearer(String token) => {
        'Content-Type': 'multipart/form-data',
        "Accept": 'application/json',
        'Cookie': '',
        'Authorization': "Bearer $token",
      };

  static Map<String, String> tokenHeader(String token) => {
        'Content-Type': 'application/json',
        'Cookie': '',
        'Authorization': "Bearer $token",
      };
}