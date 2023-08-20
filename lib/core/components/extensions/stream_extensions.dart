extension StreamExtensions<T> on Stream<T> {
  Stream<T> addStream(T data) async* {
    yield data;
    yield* this;
  }

  Stream<T> addAllStream(Iterable<T> data) async* {
    yield* Stream<T>.fromIterable(data);
    yield* this;
  }

  Future<T?> firstWhere(bool Function(T) queries,
      {T Function()? orElse}) async {
    await for (var item in this) {
      if (queries(item)) {
        return item;
      }
    }
    return orElse?.call();
  }

  Future<T?> findStream(bool Function(T) test, {T Function()? orElse}) async {
    return firstWhere(test, orElse: orElse);
  }

  Stream<T> removeWhereStream(bool Function(T) test) async* {
    await for (var item in this) {
      if (!test(item)) {
        yield item;
      }
    }
  }

  Future<int> lengthStream() async {
    var count = 0;
    await for (var _ in this) {
      count++;
    }
    return count;
  }

  Future<bool> isEmptyStream() async {
    return await lengthStream() == 0;
  }

  Future<bool> isNotEmptyStream() async {
    return await lengthStream() > 0;
  }

  Future<void> forEachStream({required void Function(T) itemCall}) async {
    await for (var item in this) {
      itemCall.call(item);
    }
  }

  void clear() => this.clear();
}
