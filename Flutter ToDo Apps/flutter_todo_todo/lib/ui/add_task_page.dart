import 'package:flutter/material.dart';
import 'package:flutter_todo_todo/controllers/task_controller.dart';
import 'package:flutter_todo_todo/models/task_model.dart';
import 'package:flutter_todo_todo/theme/theme.dart';
import 'package:flutter_todo_todo/ui/widgets/button.dart';
import 'package:flutter_todo_todo/ui/widgets/text_form_field.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  //this varibale for taskModel
  final TaskController _taskController = Get.put(TaskController());
  //this is texteditingController
  TextEditingController titleController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  // this variable for date widget
  DateTime _selectDate = DateTime.now();

  //this variable for start time and ending time
  String endingTime = '09:30 AM';
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();

  ///this list for reminder
  int _selectRemind = 5;
  List<int> remindList = [5, 10, 15, 20, 25, 30];

  ///this list for repeat
  String _selectRepeat = 'None';
  List<String> repeatdList = ['None', 'Daily', "Weekly", "Monthly"];

  ///this variable for selectColorMode
  int _selectColor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: _appbar(context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Task',
                style: headingStyle,
              ),
              MyTextField(
                controller: noteController,
                title: "Title",
                hinText: "Enter title here",
              ),
              MyTextField(
                controller: titleController,
                title: "Note",
                hinText: "Enter note here",
              ),
              MyTextField(
                title: 'Date',
                hinText: DateFormat.yMd().format(_selectDate),
                widget: IconButton(
                  icon: const Icon(Icons.calendar_month_outlined),
                  color: Colors.grey,
                  onPressed: () {
                    print('Hi Evryone');
                    _getUserDate();
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      title: 'Start Time',
                      hinText: startTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: true);
                        },
                        icon: const Icon(Icons.access_time_filled_outlined),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: MyTextField(
                      title: 'End Time',
                      hinText: endingTime,
                      widget: IconButton(
                        onPressed: () {
                          _getTimeFromUser(isStartTime: false);
                        },
                        icon: const Icon(Icons.access_time_filled_outlined),
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              MyTextField(
                title: "Remind",
                hinText: "$_selectRemind minutes early",
                widget: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(height: 0),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectRemind = int.parse(newValue!);
                    });
                  },
                  items: remindList.map<DropdownMenuItem<String>>(
                    (int value) {
                      return DropdownMenuItem<String>(
                        value: value.toString(),
                        child: Text(value.toString()),
                      );
                    },
                  ).toList(),
                ),
              ),
              MyTextField(
                title: "Repeat",
                hinText: "$_selectRepeat ",
                widget: DropdownButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                  iconSize: 32,
                  elevation: 4,
                  underline: Container(height: 0),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectRepeat = newValue!;
                    });
                  },
                  items: repeatdList.map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15, bottom: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _colorPallet(),
                    MyButton(label: 'Creat Task', onTap: () => _validateData()),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // this validator for validate textFielForm
  _validateData() {
    //add to databse this function
    _addTaskDb();
    if (titleController.text.isNotEmpty && noteController.text.isNotEmpty) {
      Get.back();
    } else if (titleController.text.isEmpty || noteController.text.isEmpty) {
      Get.snackbar(
        'Required',
        "All fields are required !",
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        icon: const Icon(Icons.warning_amber_rounded),
      );
    }
  }

  //this method for add data task in database
  _addTaskDb() async {
    int value = await _taskController.addTask(
      task: Task(
        title: titleController.text,
        note: noteController.text,
        date: DateFormat.yMd().format(_selectDate),
        startTime: startTime,
        endTime: endingTime,
        remind: _selectRemind,
        repeat: _selectRepeat,
        color: _selectColor,
        isCompleted: 0,
      ),
    );
    print('my id is :' + '$value');
  }

  /// this method for color pallet
  _colorPallet() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Colors',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 5,
        ),
        Wrap(
          children: List<Widget>.generate(
            3,
            (int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectColor = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: index == 0
                        ? primaryClr
                        : index == 1
                            ? pinkClr
                            : yelloClr,
                    //this turnary operator for select color mode
                    child: _selectColor == index
                        ? const Icon(
                            Icons.done,
                            color: Colors.white,
                            size: 18,
                          )
                        : Container(),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// this is a coustom appbar
  _appbar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 20,
          color: Get.isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      actions: const [
        CircleAvatar(
          backgroundImage: AssetImage('images/hrr.jpg'),
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

//// this method for showing date time picker , calender
  _getUserDate() async {
    DateTime? _userDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(3100));

    if (_userDate != null) {
      setState(() {
        _selectDate = _userDate;
      });
    } else {
      print("Something went wrong");
    }
  }

  ///this two method for showing time from user
  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String formetedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print('time canceled');
    } else if (isStartTime == true) {
      setState(() {
        startTime = formetedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        endingTime = formetedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          //startTime--> 9:10 AM
          hour: int.parse(startTime.split(':')[0]),
          minute: int.parse(startTime.split(":")[1].split(" ")[0]),
        ));
  }
}
