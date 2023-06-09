

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../shared/components/components.dart';

class LoginScreen extends StatelessWidget
{
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();



  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key:formKey ,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      'Login',
                       style: TextStyle(
                         fontSize: 40.0,
                         fontWeight: FontWeight.bold,
              ),
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  defaultFormField(
                    controller: emailController,
                    label:'Email',
                    prefix: Icons.email,
                    type: TextInputType.text,
                    onChange: (value){

                    },
                    onTap: (){},
                    onSubmit: (value){},
                    validate: (value)
                    {
                      if (value!.isEmpty){
                       return 'email must be not empty';
                     }
                     return null ;
                   },
                  ),

                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    onFieldSubmitted: (String ? value){
                      print(value);
                    },
                    onChanged: (String ? value){
                    },
                    validator: ( String ? value)
                    {
                      if (value!.isEmpty)
                      {
                        return 'password must be not empty';
                      }
                      return null ;
                    },
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock,
                      ),
                      suffixIcon: Icon(
                        Icons.remove_red_eye,
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  defaultButton(
                    text: 'login',  function: (){

                    if(formKey.currentState!.validate()){
                      print('valid') ;    }
                    else{
                      print('not valid') ;    }
                  },  background: Colors.blue,  isUpperCase: true,    width: double.infinity,),

                  SizedBox(
                    height: 10.0,
                  ),
                  defaultButton(
                    text: 'ReGIstre',
                    background: Colors.blue,
                    function: (){
                      print(emailController.text);
                      print(passwordController.text);
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account ?',
                      ),
                      TextButton(onPressed: (){},
                          child: Text(
                            'Register Now',
                          ),
                      ),
                    ],
                  ),


                ],

              ),
            ),
          ),
        ),
      ),

    );
  }
}
