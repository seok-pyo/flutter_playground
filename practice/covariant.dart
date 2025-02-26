class Animal {
  void speak() {
    print("Animal speaks");
  }
}

class Dog extends Animal {
  @override
  void speak() {
    print("Dog bark!");
  }
}

// 이거 뭐지
class Box<T> {
  final T value;
  Box(this.value);
}

// 이건 또 뭐고
class CovariantBox<out T> extends Box<T> {
  CovariantBox(T value) : super(value);
}

void main() {
  CovariantBox<Animal> animalBox = CovariantBox<Animal>(Animal());

  // Dog는 Animal의 서브타입이므로 CovariantBox<Animal> 타입을 할당받을 수 있다.
  animalBox = CovariantBox<Dog>(Dog());

  animalBox.value.speak();
}

// 제네릭을 사용하지 않으면 타입 안정성을 확보할수 없게 된다.


