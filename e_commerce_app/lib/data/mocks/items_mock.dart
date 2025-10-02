class EcMockedData {
  static List<Map<String, Object?>> generateMockItems(int count) {
    return List.generate(
      count,
      (index) => {
        'id': index,
        'title': 'Debug tools Item $index',
        'body': 'This is a Debug tools item description for item $index',
      },
    );
  }

  static List<Map<String, Object?>> generateMockComments(int count) {
    return List.generate(
      count,
      (index) => {
        "postId": 1,
        "id": index + 1,
        "name": "Debug Tools name $index",
        "email": "Debugtool$index@example.com",
        "body": "This is a Debug tools comment description for item $index",
      },
    );
  }
}
