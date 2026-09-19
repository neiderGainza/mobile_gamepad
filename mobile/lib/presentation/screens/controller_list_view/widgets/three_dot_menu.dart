import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ThreeDotMenu extends StatelessWidget{
  const ThreeDotMenu({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.push('/app_info'),
      icon: Icon(Icons.info_outline));
  }
}