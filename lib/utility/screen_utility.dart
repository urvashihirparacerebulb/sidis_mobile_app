import 'package:flutter/material.dart';

getScreenWidth(BuildContext context){
 return MediaQuery.of(context).size.width;
}

getScreenHeight(BuildContext context){
 return MediaQuery.of(context).size.height;
}

bool isTablet() {
 final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
 return data.size.shortestSide < 600 ? false : true;
}