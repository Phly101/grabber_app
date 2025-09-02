import 'package:flutter/material.dart';
import 'package:grabber_app/UI/auth/components.dart';
import 'package:grabber_app/UI/auth/sign_up.dart';
import '../main_app/main_screen.dart';

class Login extends StatefulWidget{
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Components(
        height: 20,
        child: Form(
          // autovalidateMode: AutovalidateMode.always,
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50,),
              Text("Welcome Back To Grabber",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Color(0xFF5A5555), fontWeight: FontWeight.bold,),
              ),
              SizedBox(height: 5,),
              Text("Please sign in with your mail",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Color(0xAB5A5555)),
              ),
              SizedBox(height: 40,),

              ATextField(
                label: "User Name",
                hint: "enter your name",
                controller: username,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "User Name is required";
                  }
                },
              ),
              SizedBox(height: 20,),
              ATextField(
                label: "Password",
                hint: "enter your password",
                controller: password,
                obscureText: true,
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Password is required";
                  }
                  if(value.length < 8){
                    return "Password must be at least 8 characters";
                  }
                },
              ),
              SizedBox(height: 3),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: (){}, child: Text("Forgot password",
                    style: TextStyle(color: Colors.white, fontSize: 19),
                  ),
                ),
              ),
              SizedBox(height: 40,),
              AButton(
                text: "Login",
                onPressed: (){
                  if(formKey.currentState!.validate()){
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return MainScreen();
                    }));
                  }
                },
              ),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don’t have an account?", style: TextStyle(color: Colors.white, fontSize: 19),),
                  TextButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return SignUp();
                      },));
                    }, child: Text("Create Account",
                    style: TextStyle(color: Colors.white, fontSize: 19),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}