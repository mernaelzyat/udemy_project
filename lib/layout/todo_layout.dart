import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy_project/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:udemy_project/modules/done_tasks/done_tasks_screen.dart';
import 'package:udemy_project/modules/new_tasks/new_tasks_screen.dart';
import 'package:udemy_project/shared/components/components.dart';
import 'package:udemy_project/shared/components/constants.dart';
import 'package:udemy_project/shared/cubit/cubit.dart';
import 'package:udemy_project/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget
{
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var  formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener:(BuildContext context , AppStates state )
        {
          if(state is AppInsertDataBaseState)
          {
           Navigator.pop(context);
          }
        },
        builder: (BuildContext context , AppStates state ){
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(
                cubit.titels[cubit.currentIndex],
              ),
            ),
            body: ConditionalBuilder(
              condition:state is! AppGetDataBaseLoadingState,
              builder:(context)=> cubit.screens[cubit.currentIndex],
              fallback: (context)=> Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShow) {
                  if (formKey.currentState!.validate())
                  {
                    cubit.insertDatabase(title:titleController.text, time: timeController.text, date: dateController.text,);
                    // insertDatabase(
                    //   title: titleController.text,
                    //   time: timeController.text,
                    //   date: dateController.text,
                    // ).then((value) {
                    //   Navigator.pop(context);
                    //   // setState(()
                    //   // {
                    //   //   isBottomSheetShow = false;
                    //   //   fabIcon = Icons.edit;
                    //   //   tasks=value;
                    //   //   print('tasks from database $tasks');
                    //   // });
                    // });
                  } else {
                    scaffoldKey.currentState?.showBottomSheet((context) =>
                        Container(
                          color: Colors.white,
                          padding: EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormField(
                                  controller: titleController,
                                  type: TextInputType.text,
                                  onTap: () {},
                                  onChange: () {},
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'title must not be empty';
                                    }
                                    return null;
                                  },
                                  label: 'Task Title',
                                  prefix: Icons.title,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(
                                  controller: dateController,
                                  type: TextInputType.datetime,
                                  isClickable: false,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2023-01-11'),
                                    ).then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                  onChange: () {},
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'date must not be empty';
                                    }
                                    return null;
                                  },
                                  label: 'Task date',
                                  prefix: Icons.calendar_today,
                                ),
                                SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(
                                  controller: timeController,
                                  type: TextInputType.datetime,
                                  onSubmit: () {},
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text = value!.format(context);
                                      print(value.format(context));
                                    });
                                  },
                                  isClickable: false,
                                  onChange: () {},
                                  validate: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'time must not be empty';
                                    }
                                    return null;
                                  },
                                  label: 'Task time',
                                  prefix: Icons.watch_later_outlined,
                                ),
                              ],
                            ),
                          ),
                        ),
                      elevation: 20.0,
                    ).closed.then((value){
                      cubit.changeBottomSheetState(isShow: false, icon: Icons.edit,);
                    });

                    cubit.changeBottomSheetState(isShow: true, icon: Icons.add,);
                  }
                }
                child:
                Icon(
                  cubit.fabIcon,
                );
              },
            ),

            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex:cubit.currentIndex,
              onTap: (index)
              {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                  ),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check_circle_outline,
                  ),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.archive_outlined,
                  ),
                  label: 'Archived',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Future<String> getName() async {
  //   return 'Ahmed alaa';
  // }

}


