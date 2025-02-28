Future<void> doSomethingAsync() async {
  print('Start');
  await Future.delayed(Duration(seconds: 2)); // 비동기 작업
  print('End');
}

void main() {
  print('Before async');

  // 비동기 작업을 기다리지 않고 즉시 실행
  // Future(() => doSomethingAsync()); // 비동기 작업을 즉시 실행 // 결과는?

  doSomethingAsync(); // 결과는?
  print('After async');
}
