enum NetworkPath { POST }

extension NetwrokPAthExtension on NetworkPath {
  String get rawValue {
    switch (this) {
      case NetworkPath.POST:
        return '/post';

      default:
        throw Exception('Not found network path');
    }
  }
}

extension StringExtension on String {
  String get toJson => '$this.json';
}
