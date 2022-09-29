extension NonNullString on String? {
  String orEmpty() => this ?? "";
}

extension NonNullInt on int? {
  int orZero() => this ?? 0;
}