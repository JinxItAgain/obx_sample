import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Obx Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  RxBool buttonVisibility = true.obs;
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textUpdateController = TextEditingController();
  RxString textVariable = "".obs;
  RxDouble firstVariable = 0.00.obs;
  RxDouble secondVariable = 0.00.obs;
  RxDouble theTotal = 0.00.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("OBX")),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [

                  //Section 1
                Row
                (
                children:
                  [
                    const Text("Obx on Widget:"),
                    addWidth(),
                    InkWell
                      (
                        onTap: ()
                        {
                          buttonVisibility.value = !buttonVisibility.value;
                        },
                        child:  Container
                          (
                          padding: const EdgeInsets.all(10),
                          color: Colors.indigo.shade100,
                          child: const Text("on"),
                        )
                    )
                  ],
                ),
                  addHeight(),

                  Obx(() =>
                       Visibility(
                         visible: buttonVisibility.isTrue,
                        child: Container
                          (
                          width: Get.width,
                          height: 50,
                          color: Colors.indigo,
                        ),
                      )
                  ),
                  addHeight(),
                  const Divider(thickness: 2, color: Colors.indigo,),
                  addHeight(),
                  //Section 2

                  Row
                    (
                    children:
                    [
                      const Text("Obx to change values: "),
                      addWidth(),
                      Expanded(
                        child: TextField
                          (
                          controller: textEditingController,
                          onChanged: (newValue)
                          {
                            textVariable.value= textEditingController.text;
                            textUpdateController.text= textEditingController.text;
                            if (kDebugMode) {
                              print("This variable can now be used in the same way you would use a normal String datatype ${textVariable.value}");
                            }
                          },
                        ),
                      )
                    ],
                  ),
                  addHeight(),
                  Container(
                    width: Get.width,
                    margin: const EdgeInsets.all(15.0),
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent)
                    ),

                    child: Column
                      (
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                      [
                        Text("Example for ways to update values in Text Fields:" , style: customStyle(),),
                        addHeight(),
                        Row(
                          children: [
                            const Text("By using Obx Variable"),
                            addWidth(),
                            Expanded(
                              child: Obx(()=>TextField
                                (
                                decoration: InputDecoration
                                  (
                                  isDense: true,
                                  hintText: textVariable.value,
                                  prefixIcon :textVariable.value==""?null:const Icon(Icons.ac_unit),
                                ),
                              )),
                            ),
                          ],
                        ),
                        addHeight(),
                        Row(
                          children: [
                            const Text("By using TextEditingController:"),
                            addWidth(),
                            Expanded(
                              child: TextField(
                                controller: textUpdateController,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  addHeight(),
                  const Divider(thickness: 2, color: Colors.indigo,),
                  addHeight(),
                  //Section 3
                  Text("Calculations using Obx" , style: customStyle(),),
                  addHeight(),
                  Row
                    (
                    children:
                    [
                      const Text("Enter first number: "),
                      addWidth(),
                      Expanded(
                        child: TextField
                          (
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters:
                          [
                            FilteringTextInputFormatter.allow(RegExp( r'^\d+[.]?\d{0,2}')),
                          ],
                          onChanged: (newValue)
                          {
                            if(newValue=="")
                            {
                              newValue="0";
                            }
                            firstVariable.value= double.tryParse(newValue)!;
                            addVariables();
                          },
                        ),
                      )
                    ],
                  ),
                  addHeight(),
                  Row
                    (
                    children:
                    [
                      const Text("Enter second number: "),
                      addWidth(),
                      Expanded(
                        child: TextField
                          (
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters:
                          [
                            FilteringTextInputFormatter.allow(RegExp( r'^\d+[.]?\d{0,2}')),
                          ],
                          onChanged: (newValue)
                          {
                            if(newValue=="")
                            {
                              newValue="0";
                            }
                            secondVariable.value= double.tryParse(newValue)!;
                            addVariables();
                          },
                        ),
                      )
                    ],
                  ),
                  addHeight(),
                  Row
                    (
                    children:
                    [
                      const Text("Sum of the two numbers: "),
                      addWidth(),
                      Expanded(
                        child: Obx( ()
                        {
                            return TextField
                              (
                              enabled: false,
                              decoration: InputDecoration
                                (
                                hintText: theTotal.value.toString(),
                                hintStyle: const TextStyle(color: Colors.black)
                              ),
                            );
                          }
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget addHeight()
  {
    return const SizedBox(height: 15);
  }

  Widget addWidth()
  {
    return const SizedBox(width: 15);
  }

  TextStyle customStyle()
  {
    return const TextStyle(fontWeight: FontWeight.w700, color: Colors.indigo);
  }

  addVariables()
  {
    theTotal.value = firstVariable.value + secondVariable.value;
  }
}

