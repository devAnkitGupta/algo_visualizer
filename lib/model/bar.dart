class Bar {
  bool isanimated = false;
  int row;
  int height;

  Bar({
    required this.isanimated,
    required this.row,
    required this.height,
  });

  @override
  String toString() {
    return '$height';
  }

  factory Bar.clone({
    required Bar data,
  }) {
    return Bar(
      isanimated: data.isanimated,
      row: data.row,
      height: data.height,
    );
  }
}
