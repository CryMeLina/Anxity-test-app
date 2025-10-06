import 'package:flutter/material.dart';

// этот класс является вариатором итога
// в нем описано несколько ситуативных виджетов
// в рамках одной страницы

class ResultWidget extends StatelessWidget {
  final int
  resultPoint; // переменная  в которую передаем итог с предыдущей страницы

  const ResultWidget({Key? key, required this.resultPoint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _VarWidget(),
    ); // в каркасе вызываем ситуативный виджет
  }

  // сам ситуативный виджет
  Widget _VarWidget() {
    // в зависимости от параметра возвращаем разные виджеты
    switch (resultPoint) {
      case 1:
        return _FirstOptionWidget();
      case 2:
        return _SecondOptionWidget();
      case 3:
        return _ThirdOptionWidget();
      default:
        return _FirstOptionWidget();
    }
  }

  // если нихзкая тревожность
  Widget _FirstOptionWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/GoodVibeSmile.png'), // картинка из ассета
          Text("Низкий уровень тревожности", style: TextStyle(fontSize: 20)),
          Text("Зеленый сектор"),
        ],
      ),
    );
  }

  // если средняя тревожность
  Widget _SecondOptionWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/i.png'), //картинка из ассета
          Text("Средний уровень тревожности", style: TextStyle(fontSize: 20)),
          Text('Желтый сектор'),
        ],
      ),
    );
  }

  // если высокая тревожность
  Widget _ThirdOptionWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/anxity.png'), // картинка из ассета
          Text("Высокий уровень тревожности", style: TextStyle(fontSize: 20)),
          Text('Красный сектор'),
        ],
      ),
    );
  }
}
