
class Result<T> {
  final T? data;
  final String? message;
  final bool isSuccess;

  const Result._({this.data, this.message, required this.isSuccess});

  factory Result.success(T data) => Result._(data: data, isSuccess: true);

  factory Result.failure(String message) =>
      Result._(message: message, isSuccess: false);
}
