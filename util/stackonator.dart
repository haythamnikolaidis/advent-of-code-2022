class Stack<T> {
  final list = <T>[];

  void push(T val) => list.add(val);

  void pushMany(List<T> vals) => vals.forEach(list.add);

  T pop() => list.removeLast();

  List<T> popMany({int amount = 1}) {
    var lastItems = list.getRange(list.length - amount, list.length);
    var result = <T>[];

    for (var i = lastItems.length - 1; i >= 0; --i) {
      result.add(lastItems.elementAt(i));
    }

    list.removeRange(list.length - amount, list.length);

    return result;
  }

  List<T> popManyInOrder({int amount = 1}) {
    var lastItems = list.getRange(list.length - amount, list.length);
    var result = <T>[];

    lastItems.forEach(result.add);

    list.removeRange(list.length - amount, list.length);

    return result;
  }

  T get peak => list.last;

  bool get isEmpty => list.isEmpty;

  bool get isNotEmpty => list.isNotEmpty;

  String toString() => list.toString();
}
