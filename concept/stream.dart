// stream은 다트 언어에 있는 비동기 데이터 이벤트 흐름을 처리하는 클래스.
// 이벤트를 비동기적으로 전달받는 방식

// 데이터가 하나가 아니라 여러 개 순차적으로 잔달될 수 있음.
// 시간이 지남에 따라 비동기적으로 데이터가 도착함
// 데이터가 들어올 때마다 이벤트가 발생하고, 이를 리스너가 감지함.
// dart의 future가 한 번만 응답하는 비동기 작업이라면, stream은 여러 번 응답할 수 있는 비동기 작업이다.

// Stream<int> countStream() async* {
//   for (int i = 0; i < 5; i++) {
//     await Future.delayed(Duration(seconds: 1));
//     yield i;
//   }
// }

// void main() {
//   countStream().listen((event) {
//     print(event);
//   });
// }

Stream<int> countStream() async* {
  for (int i = 0; i < 5; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

void main() {
  countStream().listen((event) {
    print(event);
  });
}

// 데이터가 하나가 아니라 여러개가 '순차적'으로 전달될 수 있음
// 시간이 지남에 따라 데이터가 비동기적으로 전달됨
// 데이터가 들어올 때마다 이벤트가 발생하고, 이를 리스너가 감지함
// dart의 future가 한 번만 응답하는 비동기 작업이라면, stream은 연속적으로 응답하는 비동기 작업
