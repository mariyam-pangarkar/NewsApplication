import 'package:flutter/material.dart';
TextField reuseTextField(String text,IconData icon,bool isPasswordType,TextEditingController controller){
  return TextField(controller: controller,
  obscureText: !isPasswordType,
  enableSuggestions: !isPasswordType,
  autocorrect: !isPasswordType,
  cursorColor: Colors.white,
  
    decoration: InputDecoration(
    prefixIcon: Icon(icon,color:Colors.white70 ,),
    labelText: text,
    labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
    filled: true,
    fillColor: Colors.white.withOpacity(0.1),
    border: OutlineInputBorder(
      
      borderRadius: BorderRadius.circular(30)
    )
    ,
    
  ),
  keyboardType: isPasswordType?TextInputType.visiblePassword:TextInputType.emailAddress,
  );
}
Container signInbutton(BuildContext context , bool isLogin, Function onTap){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(onPressed: (){
      onTap();

    }, child: Text(isLogin ? 'LOG IN ':'SIGN UP',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20),)),
  );
}
Text texterror(String errormsg){
  return Text(errormsg,style: TextStyle(color: Colors.red),);
}
