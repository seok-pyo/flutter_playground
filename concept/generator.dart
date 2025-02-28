// Dart에서 generator 함수는 두 가지 방식으로 작동한다.
// 동기 generator : sync* : Iterable<T> : 즉시 반환
// 비동기 generator : async* : Stream<T> : Future 기반 비동기 흐름

// Iterable<int> syncGenerator() sync* {
//   print("start");
//   yield 1;
//   print("end");
// }

// void main() {
//   for (var value in syncGenerator()) {
//     print(value);
//   }
// }

Stream<int> asyncGenerator() async* {
  print('start');
  yield 1;
  await Future.delayed(Duration(seconds: 1));
  yield 2;
  print("end");
}

void main() async {
  await for (var value in asyncGenerator()) {
    print(value);
  }
}
