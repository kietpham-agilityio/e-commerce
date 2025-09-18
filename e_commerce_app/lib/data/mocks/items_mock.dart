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
}
