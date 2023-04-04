import 'package:flutter/material.dart';
import 'package:wms/principal.dart';

Map<String, WidgetBuilder> getRoute() {
  return <String, WidgetBuilder>{
    '/navigator': (BuildContext context) => AppBar(),
  };
}
