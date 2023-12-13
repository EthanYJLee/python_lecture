import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late TextEditingController sepalLengthController;
  late TextEditingController sepalWidthController;
  late TextEditingController petalLengthController;
  late TextEditingController petalWidthController;

  late String imageName = 'all';
  String result = 'all';

  late String sepalLength = '';
  late String sepalWidth = '';
  late String petalLength = '';
  late String petalWidth = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sepalLengthController = TextEditingController();
    sepalWidthController = TextEditingController();
    petalLengthController = TextEditingController();
    petalWidthController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('IRIS 품종예측'),
        ),
        body: Center(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: sepalLengthController,
                decoration: const InputDecoration(
                  labelText: 'Sepal Length',
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: sepalWidthController,
                decoration: const InputDecoration(
                  labelText: 'Sepal Width',
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: petalLengthController,
                decoration: const InputDecoration(
                  labelText: 'Petal Length',
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: TextField(
                controller: petalWidthController,
                decoration: const InputDecoration(
                  labelText: 'Petal Width',
                ),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                sepalLength = sepalLengthController.text;
                sepalWidth = sepalWidthController.text;
                petalLength = petalLengthController.text;
                petalWidth = petalWidthController.text;
                getJSONData();
              },
              child: const Text(
                '예측하기',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: CircleAvatar(
                backgroundImage: AssetImage(
                  'images/$imageName.jpg',
                ),
                radius: 100,
              ),
            )
          ],
        )),
      ),
    );
  }

  // ----- Functions -----
  getJSONData() async {
    var url = Uri.parse(
        'http://localhost:5000/iris?sepalLength=$sepalLength&sepalWidth=$sepalWidth&petalLength=$petalLength&petalWidth=$petalWidth');
    var response = await http.get(url);

    setState(() {
      var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
      result = dataConvertedJSON['result'];
      _showDialog(context, result);
    });
  }

  _showDialog(BuildContext context, String result) {
    showDialog(
        context: context,
        builder: ((BuildContext context) {
          return AlertDialog(
            title: const Text('품종 예측 결과'),
            content: Text('입력하신 품종은 $result 입니다.'),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      imageName = result;
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK')),
            ],
          );
        }));
  }
}
