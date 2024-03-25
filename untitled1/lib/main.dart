import 'package:flutter/material.dart';
import 'dart:math';

class AppTheme {
  static const Color primaryColor = Colors.orangeAccent;
}

void main() {
  runApp(const ExamApp());
}

class ExamApp extends StatelessWidget {
  const ExamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Генерация варианта для экзамена",
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyPage(),
    );
  }
}

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  MyPageState createState() => MyPageState();
}

OutlineInputBorder borderStyle = OutlineInputBorder(
  borderRadius: BorderRadius.circular(60.0),
  borderSide: BorderSide(color: AppTheme.primaryColor, width: 1),
);

Widget borderColor(String colorName, bool isSelected) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    decoration: BoxDecoration(
      border: isSelected
          ? Border.all(color: AppTheme.primaryColor, width: 1)
          : null,
      borderRadius: BorderRadius.circular(60.0),
    ),
    child: Text(colorName),
  );
}

Widget borderFinal(String resultName, bool isSelected) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    decoration: BoxDecoration(
      border: isSelected
          ? Border.all(color: AppTheme.primaryColor, width: 1)
          : null,
      borderRadius: BorderRadius.circular(60.0),
    ),
    child: Text(resultName),
  );
}

void textSwap(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        expand: false,
        builder: (_, controller) => Container(
          padding: EdgeInsets.all(30),
          child: ListView(
            controller: controller,
            children: <Widget>[
              Text(
                "Критерии:",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              Text(
                "Звездная ночь. Самое подходящее время. Ужин при свечах. Уютный итальянский ресторанчик. Маленькое черное платье. Роскошные волосы, блестящие глаза, серебристый смех. Вместе уже два года. Чудесное время! Настоящая любовь, лучший друг, больше никого. Шампанского! Предлагаю руку и сердце. На одно колено. Люди смотрят? Ну и пусть! Прекрасное бриллиантовое кольцо. Румянец на щеках, очаровательная улыбка. Как, нет?!",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget selectButton(String transitionName, bool isSelected) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    decoration: BoxDecoration(
      border: isSelected
          ? Border.all(color: AppTheme.primaryColor, width: 1)
          : null,
      borderRadius: BorderRadius.circular(60.0),
    ),
    child: Text(transitionName),
  );
}

class MyPageState extends State<MyPage> {
  String selectedColor = "";
  String selectedResult = "";
  String selectedTransition = "";

  final List<String> colors = ["Розовый", "Желтый", "Зеленый"];
  final List<String> results = ["Dialog", "SnackBar"];
  final List<String> transitions = ["Снизу вверх", "Сверху вниз", "Справа налево"];

  int getCount(int length) {
    return Random().nextInt(length);
  }

  void selectRandomElement() {
    setState(() {
      selectedColor = colors[getCount(colors.length)];
      selectedResult = results[getCount(results.length)];
      selectedTransition = transitions[getCount(transitions.length)];
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$selectedColor, $selectedResult, $selectedTransition"),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Генерация варианта для экзамена"),
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Основной цвет",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              borderColor("Розовый", selectedColor == "Розовый"),
              borderColor("Желтый", selectedColor == "Желтый"),
              borderColor("Зеленый", selectedColor == "Зеленый"),
            ],
          ),
          SizedBox(height: 30),
          Text("Показ результата",
            style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              borderFinal("Dialog", selectedResult == "Dialog"),
              borderFinal("SnackBar", selectedResult == "SnackBar"),
            ],
          ),
          SizedBox(height: 30),
          Text("Переход между экранами",
            style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              selectButton(
                  "Снизу вверх", selectedTransition == "Снизу вверх"),
              selectButton(
                  "Сверху вниз", selectedTransition == "Сверху вниз"),
              selectButton(
                  "Справа налево", selectedTransition == "Справа налево"),
            ],
          ),
          SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: selectRandomElement,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                ),
                child: Text("Подобрать вариант"),
              ),
              SizedBox(width: 10.0),
              ElevatedButton(
                onPressed: () => textSwap(context),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.orange,
                  textStyle: TextStyle(color: Colors.white),
                  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                ),
                child: Text("Открыть критерии"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
