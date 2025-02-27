class FrogColor extends InheritedWidget{
  const FrogColor({
    super.key,
    required this.color,
    required super.child,
  })

  final Color color;

  // 자기 자신을 타입으로 선언해서 사용할 수도 있나? 이게 기본 문법인가?
  // FrogColor 클래스가 자기 자신의 타입을 반환하는 정적 메서드를 제공
  // 싱글톤 패턴 혹은 팩토리 메서드 패턴에서 자주 사용된다.
  static FrogColor? mayBeOf(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType<FrogColor>();
  }

  // 왜 static 메서드로 만들어서 사용하는 거지?
  // static 메서드로 만든 이유는 '객체를 생성하지 않고도 쉽게 접근할 수 있도록 하기 위해서
  // of 메서드를 호출하려면 FrogColor의 인스턴스가 필요하게 된다.
  // "그냥 인스턴스를 만들었느냐" vs "위젯 트리에 추가되었느냐"


  // BuildContext는 도대체 뭐인거지?
  // BuildContext는 flutter에서 위젯 트리에서 현재 위치를 나타내는 객체
  // 각 위젯은 BuildContext를 가지고 있으며, 이를 통해 부모나 상위 위젯의 정보를 찾을 수 있다.
  static FrogColor of(BuildContext context){
    FrogColor? result = mayBeOf(context);
    assert(result != null, 'Throw this error');
    return result!;
  }

  @override
  bool updateShouldNotify(FrogColor oldWidget) => color != oldWidget.color;
}

// - - - - - - - - - - - - - - - - - - - - 

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return DataProvider(
      data:'Hello, pano!',
      child: MaterialApp(
        context,
        home: HomeScreen(),
      )
    )
  }
}

class DataProvider extends InheritedWidget {
  final String data;

  const DataProvider({required this.data, required Widget child}) :
  super(child:child);

  static DataProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<DataProvider>();
  }

  @override
  bool updateShouldNotify(DataProvider oldWidget) => data != oldWidget.data;  
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = DataProvider.of(context)?.data ?? 'No data';

    return Scaffold(
      appBar: AppBar(title: Text('InheritedWidget Example')),
      body: Center(
        child: Text(data, style: TextStyle(fontSize: 24)),
      ),
    );
  }
}
