import 'dart:math';

import 'package:flutter/material.dart';

class AppInfoView extends StatelessWidget{
  const AppInfoView({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final cc = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),

      body: Column(
        crossAxisAlignment: .center,
        children: [
          const SizedBox(height: 32,),
          Text(
            "Mobile Game Controller",
            style: tt.headlineMedium,
          ),
          const SizedBox(height: 16,),

          Align(
            alignment: .topCenter,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: min(200, MediaQuery.of(context).size.width / 2),
                minWidth: 100
              ),
              decoration: BoxDecoration(
                // borderRadius: .circular(20),
                shape: .circle,
                color: cc.secondaryContainer
              ),
              padding: EdgeInsets.all(30),
              child: AspectRatio(
                aspectRatio: 1,
                child: Image.asset(
                  'assets/icon/icon.png',
                  color: cc.onSecondaryContainer,
                  colorBlendMode: .srcIn,    
                ),
              ),
            ),
          ),

          const SizedBox(height: 16,),
          SelectableText(
            "Version: 0.0.1\n"
            "Developed by: Neider Gainza Llacer\n"
            "Contact at: neidergainza1@gmail.com",
            style: tt.titleMedium,
            textAlign: .center,
          ),
          
        
        ],
      ),
    );
  }
}