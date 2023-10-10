import 'package:flutter/material.dart';
import 'dice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dice game',
      home: LogIn(),
    );
  }
}

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      //SingleChildScrollView: 자판이 올라올 때, UI를 가리지 않게 화면을 스크롤 해준다.
      body: Builder(
        builder: (context) => GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 50)),
                const Center(
                  child: Image(
                    image: AssetImage('image/main.gif'),
                    width: 170.0,
                    height: 190.0,
                  ),
                ),
                Form(
                  child: Theme(
                    data: ThemeData(
                      primaryColor: Colors.teal,
                      inputDecorationTheme: const InputDecorationTheme(
                        labelStyle: TextStyle(
                          color: Colors.teal,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: controller,
                            decoration: const InputDecoration(
                              labelText: 'Enter "user"',
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          TextField(
                            controller: controller2,
                            decoration: const InputDecoration(
                              labelText: 'Enter password',
                            ),
                            keyboardType: TextInputType.text,
                            obscureText: true, //비밀번호 스타일
                          ),
                          const SizedBox(
                            height: 40.0,
                          ),
                          ButtonTheme(
                            minWidth: 100.0,
                            height: 50.0,
                            child: ElevatedButton(
                              onPressed: () =>
                                  pushLoginButton(context, controller, controller2),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orangeAccent,
                              ),
                              child: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 35.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void pushLoginButton(BuildContext context, TextEditingController controller,
    TextEditingController controller2) {
  var isTheNameCorrect = controller.text == 'user';
  var isThePasswordCorrect = controller2.text == '1234';

  if (!isTheNameCorrect && !isThePasswordCorrect) {
    showErrorSnackBar(context, '로그인 정보를 확인해주세요.');
    return;
  }
  if (isTheNameCorrect && !isThePasswordCorrect) {
    showErrorSnackBar(context, '비밀번호가 일치하지 않습니다.');
    return;
  }
  if (!isTheNameCorrect && isThePasswordCorrect) {
    showErrorSnackBar(context, 'user의 철자를 확인하세요.');
    return;
  }

  if (isTheNameCorrect && isThePasswordCorrect) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => const Dice()));
    controller.text = '';
    controller2.text = '';
  }
}

void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: Colors.blue,
    ),
  );
}
