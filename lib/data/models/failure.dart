class Failure {
  final String? text;

  Failure([this.text]);

  @override
  String toString() => text ?? "";
}
