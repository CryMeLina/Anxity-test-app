import 'package:anxiety_test/ResultWidget/ResWidget.dart';
import 'package:anxiety_test/data/questions.dart';
import 'package:flutter/material.dart';

//бутылочное горлышко
void main() {
  runApp(const MyApp());
}

// базовый класс приложения
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage(), debugShowCheckedModeBanner: false);
  }
}

//Класс домашней страницы (должен наследовать состояние в контексте данной задачи)
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

//прописываем состояние
class _HomePageState extends State<HomePage> {
  PageController? _controller = PageController(
    initialPage: 0,
  ); // для PageView инициализируем контроллер
  List<int> metrix = []; // в этот массив складываем ответы пользователя

  // метод позволяет добавить элемент по нажатию кнопки
  void addItem(matrix, a) {
    setState(() {
      matrix.add(a);
      print(matrix);
    });
  }

  // метод переворачивает значения согласно логике описанной в техническом задании
  List<int> swap(List<int> arr) {
    for (int i = 0; i < arr.length; i++) {
      if (i != 2 ||
          i != 5 ||
          i != 7 ||
          i != 10 ||
          i != 11 ||
          i != 12 ||
          i != 16 ||
          i != 17 ||
          i != 20 ||
          i != 23 ||
          i != 25 ||
          i != 26 ||
          i != 28 ||
          i != 31 ||
          i != 32 ||
          i != 35 ||
          i != 38 ||
          i != 39) {
        if (arr[i] == 1) {
          arr[i] = 4;
        }
        if (arr[i] == 2) {
          arr[i] = 3;
        }
        if (arr[i] == 3) {
          arr[i] = 2;
        }
        if (arr[i] == 4) {
          arr[i] = 1;
        }
      }
    }
    return arr;
  }

  // подсчет для первой половины итогового массива
  double res1(List<int> arr) {
    List<int> halfarr = arr.sublist(0, 20);
    int sum = 0;
    for (int i = 0; i < halfarr.length; i++) {
      sum += halfarr[i];
    }
    double resultOftest = sum.toDouble() * 1.25;
    return resultOftest;
  }

  // подсчет для второй половины итогового массива
  double res2(List<int> arr) {
    List<int> halfarr = arr.sublist(21, 40);
    int sum = 0;
    for (int i = 0; i < halfarr.length; i++) {
      sum += halfarr[i];
    }
    double resultOftest = sum.toDouble() * 1.25;
    return resultOftest;
  }

  // возвращаем то значение, соответсвенно которому мы получили ответ в двух предыдущих функциях
  int translatingRes(double res) {
    int k = 0;
    if (res <= 30) {
      k = 1;
    }
    if (res > 30 && res <= 44) {
      k = 2;
    }
    if (res > 44) {
      k = 3;
    }
    return k;
  }

  // for (int i = 0; i<arr.length;i++){
  //       if (i!=2 || i!= 5 || i!=7|| i!=10 || i!= 11 || i!=12|| i!=16||i!=17||i!=20){

  //       }
  //     }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 69, 245, 107), // основной цвет
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: PageView.builder(
          //используем этот виджет для построения серии виджетов, которым соответсвуют значения из класса с вопросами и ответами
          physics: ClampingScrollPhysics(), // физика плавного перехода
          controller: _controller!,
          itemCount:
              questions.length, // индекс который контролирует номер вопроса
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Вопрос ${index + 1} / ${questions.length}",
                  style: TextStyle(fontWeight: FontWeight.w300, fontSize: 25),
                ),
                Divider(
                  color: Colors.black,
                  height: 10,
                  thickness: 2,
                ), // разделительная полоса
                Text(questions[index].question!), // печатаем текст вопроса
                for (int i = 0; i < questions[index].answers!.length; i++)
                  MaterialButton(
                    onPressed: () {
                      // добавляем выбранный ответ в массив
                      addItem(
                        metrix,
                        questions[index].answers!.values.toList()[i],
                      );
                      _controller!.nextPage(
                        duration: Duration(milliseconds: 400),
                        curve: Curves
                            .easeInOut, // еще одна фишка плавного перехода
                      );
                    },
                    child: Text(questions[index].answers!.keys.toList()[i]),
                  ),
                SizedBox(height: 100),
                MaterialButton(
                  onPressed: () {
                    // при нажатии этой кнопки выполняем всю мат логику
                    List<int> WhileDoingClick;
                    double MiddleName;
                    int res;
                    WhileDoingClick = swap(
                      metrix,
                    ); //переворачиваем значения массива
                    MiddleName = res1(WhileDoingClick); // получаем ответ
                    res = translatingRes(
                      MiddleName,
                    ); // возвращаем 1,2 или 3 для итога
                    final moving = Navigator.push(
                      // переходим на итоговую страницу
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResultWidget(resultPoint: res),
                      ),
                    );
                  },
                  child: Text('ЗАКОНЧИТЬ ТЕСТ'), // сама кнопка
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
