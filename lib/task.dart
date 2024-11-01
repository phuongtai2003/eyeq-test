class Task {
  final String name;
  final bool isCompleted;

  const Task({
    required this.name,
    required this.isCompleted,
  });

  Task copyWith({
    String? name,
    bool? isCompleted,
  }) {
    return Task(
      name: name ?? this.name,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
