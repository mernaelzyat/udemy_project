import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      color: background,
      child: MaterialButton(
        onPressed:(){
          function();
          },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
   Function ? onSubmit ,
  required Function onChange ,
  required Function onTap ,
  bool isPassword = false ,
  required  String? Function(String? x)? validate,
  required String label ,
   IconData ? prefix,
  bool isClickable = true ,

}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit!(),
      obscureText: true,
      enabled: isClickable,
      validator: validate!,
      onTap: onTap(),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
         prefix,
        ),



        border: OutlineInputBorder(),
      ),
    );

Widget buildTaskItem(Map model, BuildContext context) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Row(
    children: [
      CircleAvatar(
        radius:40.0,
        child: Text(
          '${model['time']}',
        ),
      ),
      SizedBox(
        width: 20.0,
      ),
      Column(
        mainAxisSize:MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${model['title']}',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${model['date']}',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ],
  ),
);

Widget tasksBuilder ({
  required List<Map> tasks ,
})=> ConditionalBuilder(
    condition: tasks.length > 0,
    builder: (context) => ListView.separated(
        itemBuilder: (context , index){
          return buildTaskItem(tasks[index], context);
        },
        separatorBuilder: (context, index)=> myDivider(),
        itemCount: tasks.length,
    )
);
Widget myDivider()=> Padding(
    padding: const EdgeInsetsDirectional.only(
      start: 20.0,
    ),
    child: Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey[300],
    ),
);

Widget buildArticleItem(article, context)=> Padding(
  padding: const EdgeInsets.all(8.0),
  child: Row(
    children: [
      Container(
        width: 120.0,
        height: 120.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0,),
          image:DecorationImage(
            image: NetworkImage( "${article['urlToImage']}",),
            fit: BoxFit.cover,
          ),

        ),
      ),
      SizedBox(
        width: 20.0,
      ),
      Expanded(
        child: Container(
          height: 120.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  '${article['title']}',
                  style: Theme.of(context).textTheme.bodyText1,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                '${article['"publishedAt']}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  ),
);

Widget articleBuilder(list, context) => ConditionalBuilder(
  condition:list.length > 0 ,
  builder: (context)=> ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context , index) => buildArticleItem(list[index], context),
    separatorBuilder: (context, index) => myDivider(),
    itemCount: 10,) ,
  fallback:(context) => Center(child: CircularProgressIndicator()) ,
);

void navigateTo(context , widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder:(context) => widget,
    ));
