enum Gender {
  male,
  female,
  either,
}

extension GenderExtension on Gender {
  String get string {
    return ["m", "f", ""][this.index];
  }
}
