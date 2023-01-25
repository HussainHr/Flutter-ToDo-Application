import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_todo_todo/controllers/task_controller.dart';
import 'package:flutter_todo_todo/models/task_model.dart';
import 'package:flutter_todo_todo/services/notification_services.dart';
import 'package:flutter_todo_todo/services/theme_service.dart';
import 'package:flutter_todo_todo/theme/theme.dart';
import 'package:flutter_todo_todo/ui/add_task_page.dart';
import 'package:flutter_todo_todo/ui/widgets/button.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../utils/task_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var notifyHelper;
  final _taskController = Get.put(TaskController());

  DateTime _selecetedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notifyHelper = NotifyHelper();
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _appbar(),
        backgroundColor: context.theme.backgroundColor,
        body: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _taskBar(),
            _dateTimeBar(),
            const SizedBox(
              height: 10,
            ),
            _showTasks(),
          ],
        ),
      ),
    );
  }

// this method for showing tasks in our homepage
  _showTasks() {
    return Expanded(
      child: Obx(() {
        return ListView.builder(
            itemCount: _taskController.taskList.length,
            itemBuilder: (context, index) {
              print(_taskController.taskList.length);
              return AnimationConfiguration.staggeredList(
                position: index,
                child: SlideAnimation(
                  child: FadeInAnimation(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            _showBottomSheet(
                                context, _taskController.taskList[index]);
                          },
                          child: TaskTile(
                            _taskController.taskList[index],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            });
      }),
    );
  }

// this function for bottom Sheet
  _showBottomSheet(BuildContext context, Task task) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4),
        height: task.isCompleted == 1
            ? MediaQuery.of(context).size.height * 0.28
            : MediaQuery.of(context).size.height * 0.35,
        color: Get.isDarkMode ? darkGrayClr : Colors.white,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Get.isDarkMode ? Colors.grey[600] : Colors.grey[300]),
            ),
            const Spacer(),
            task.isCompleted == 1
                ? Container()
                : _bottomSheetButton(
                    label: "Completed Task",
                    onTap: () {
                      _taskController.taskCompleted(task.id!);
                      // _taskController.getTask();
                      Get.back();
                    },
                    clr: primaryClr,
                    context: context,
                  ),
            _bottomSheetButton(
              label: "Delete Task",
              onTap: () {
                _taskController.delete(task);
                // _taskController.getTask();
                Get.back();
              },
              clr: Colors.red,
              context: context,
            ),
            const SizedBox(
              height: 20,
            ),
            _bottomSheetButton(
              label: "Close Task",
              onTap: () {
                Get.back();
              },
              isClose: true,
              clr: Colors.white,
              context: context,
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }

// bottomSheet button

  _bottomSheetButton({
    required BuildContext context,
    required String label,
    required Function()? onTap,
    required Color clr,
    bool isClose = false,
  }) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          height: 55,
          width: MediaQuery.of(context).size.width * 0.9,
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  width: 1,
                  color: isClose == true
                      ? Get.isDarkMode
                          ? Colors.grey[600]!
                          : Colors.grey[300]!
                      : clr),
              color: isClose == true ? Colors.transparent : clr),
          child: Center(
            child: Text(label,
                style: isClose == true
                    ? bottomButtonStyle
                    : bottomButtonStyle.copyWith(color: Colors.white)),
          ),
        ));
  }

// this is for DateTimePicker
  _dateTimeBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime.now(),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: primaryClr,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
        onDateChange: (date) {
          _selecetedDate = date;
        },
      ),
    );
  }

  //this for first row
  _taskBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(DateFormat.yMMMMd().format(DateTime.now()),
                  style: subHeadingStyle),
              // const SizedBox(
              //   height: 6,
              // ),
              Text('Today', style: headingStyle),
            ],
          ),
          MyButton(
              label: '+ Add Task',
              onTap: () async {
                await Get.to(() => const AddTaskPage());
                _taskController.getTask();
              }),
        ],
      ),
    );
  }

  /// this is a coustom appbar
  _appbar() {
    return AppBar(
      elevation: 0,
      backgroundColor: context.theme.backgroundColor,
      leading: GestureDetector(
        onTap: () {
          ThemeService().switchTheme();
          notifyHelper.displayNotification(
              title: 'Theme changed',
              body: Get.isDarkMode
                  ? 'Activated light theme'
                  : 'Activated dark theme');
          //notifyHelper.scheduledNotification();
        },
        child: Icon(
          Get.isDarkMode ? Icons.wb_sunny_outlined : Icons.nightlight_round,
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
}
