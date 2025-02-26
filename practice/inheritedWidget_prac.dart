// FrogColor.of(context).color를 통해 어디서든 접근 가능.

class FrogColor extends InheritedWidget{
  FrogColor({
    super.key,
    required this.color,
    required super.child,
  })

  final Color color;

  // dependOnInheritedWidgetExactType<T>();
  // 현재 위젯이 특정 InheritedWidget을 찾고, 해당 위젯의 데이터를 의존하도록 만드는 메서드
  // 위젯 트리에서 상위 InheritedWidget을 찾아 데이터를 가져오고, 해당 위젯이 변경되면 
  // 자동으로 rebuild 되도록 연결하는 역할을 한다.

  // InheritedWidget만 사용할 때의 단점
  // InheritedWidget은 불변이라 상태 변경이 어렵다.
  // build를 해야할 때마다 새로 생성해야 한다.
  static FrogColor? maybeOf(BuildContext context){
    return context.dependOnInheritedWidgetExactType<FrogColor>();
  }

  static FrogColor of(BuildContext context){
    FrogColor? result = maybeOf(contest);
    assert(result != null, 'throw FrogColor error');
    return result!;
  }

  @override
  bool updateShouldNotify(FrogColor oldWidget) => color != oldWidget.color;
}

// 왜 계층이 깊어질수록 inheritedWidget을 사용하는게 어려울까?
// 계층이 깊어지면, FrogColor.of(contest)를 여러곳에서 호출해야 한다.
// 만약, FrogColor를 중간에 추가해야 하면 모든 위젯을 수정해야 한다.

// InheritedWidget은 자동 리빌드를 제공하지 않는다/
// InheritedWidget은 자신을 직접 사용하는 위젯만 리빌드, 상태가 변경될 때 자동으로 
// 상태가 필요한 모든 위젯을 리빌드하는 기능은 없음.

// inheritedWidget 자체는 불변 객체이므로 상태를 변경할 수 없음.
// 상태를 변경하려면 부모 위젯을 다시 빌드해야 함

// 상태관리
// provider.of(context).color = 'blue' 이렇게 다시 재할당하는 것이 불가능하다.

// inheritedWiget에서 값 변경이 불가능한 이유
// 1. 위젯 트리에서 widget은 불변(immutable)
// flutter의 widget은 기본적으로 불변 객체.
// 즉, 한 번 생성된 widget은 내부 상태를 변경할 수 없고, 변경하려면 새로운 위젯을 만들어야 한다.

// 2. inheritedWidget도 widget의 한 종류
// inheritedWidget 역시 Widget의 하위 클래스이므로, 내부 상태를 변경할 수 없도록 설계됨.
// 따라서, 값을 재할당하는 것 자체가 불가능하다

// InheritedWidget은 불변 객체로 설계되었기 때문에 값을 재할당할 수 없도록 만들어져 있다.
// 즉, InheritedWidget 객체의 값을 변경하려고 하면 컴파일 오류가 발생한다
// InheritedWidget에서 상태는 final로 선언되기 떄문에 재할당할 수 없게 설계되어 있다.
// Dart에서 final변수는 초기화 후 값 변경을 막기 떄문에, 값을 재할당하는 시도는
// 불가능하게 되어있다.

// class MyInheritedWidget extends InheritedWidget{
//   final int count;

//   MyInheritedWidget({required this.count, required Widget child})
//     : super(child: child);

//   static MyInheritedWidget of(BuildContext context){
//     return context.dependOnInheritedWidgetExactType<MyInheritedWidget>()!;
//   }

//   @override
//   bool updateSholudNotify(MyInheritedWidget oldWidget){
//     return count != oldWidget.count;
//   }
// }

// void updateCount(BuildContext context){
//   MyInheritedWiget.of(context).count = 10;
// }

// class MyInheritedWidgetWrapper extends StatefulWidget{
//   final Widget child;

//   MyInheritedWidgetWrapper({required this.child});

//   @override
//   _MyInheritedWidgetWrapperState createState() => _MyInheritedWidgetWrapperState();
// }

// class _MyInheritedWidgetWrapperState extends State<MyInheritedWrapperWidget> {
//   int _count = 0;

//   void _increment() {
//     setState(() {
//       _count++;
//     })
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MyInheritedWidget(
//       count: _count,
//       child: Column(
//         children: [
//           widget.child,
//           ElevateButton(
//             onPressed: _increment,
//             child: Text('Increment'),
//           )
//         ]
//       )
//     );
//   }
// }

class MyInheritedWidget extends InheritedWidget{
  final int count;

  // child를 받은 후에 super(child: child)를 실행하게 되는거겠지?
  MyInheritedWidget({required this.count, require Widget child})
    : super(child: child);

  static MyInheritedWidget of(BuildContext context){
    return context.dependOnInheritedWidgetExactType<MyInheritedWidget>()!;
  }

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) => count != oldWidget.count;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(
      count: 5,
      child: Scaffold(
        appBar: AppBar(
          title: Text('title'),
        ),
        body: Center(
          child: MyChildWidget(),
        ),
      ),
    );
  }
}

class MyChildWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    int count = MyInheritedWidget.of(context).count;
    return Text("count: $count");
  }
}

