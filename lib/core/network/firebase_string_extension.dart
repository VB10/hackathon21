extension FirebaseStringExtension on String {
  String toFirebaseCloudUrl(String baseUrl) {
    return 'https://firebasestorage.googleapis.com/v0/b/$baseUrl/o/blog%2F$this.jpg?alt=media';
  }
}
