import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class TitleBar extends StatelessWidget implements PreferredSizeWidget{
  const TitleBar({
    super.key
  });

  @override
  Size get preferredSize => .fromHeight(53);

  @override
  Widget build(BuildContext context) {
    final cc = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      color: cc.surface,
      height: preferredSize.height,
      child: WindowTitleBarBox(
        child: Row(
          crossAxisAlignment: .center,
          children: [
            Expanded(
              child: MoveWindow(
                child: Row(
                  crossAxisAlignment: .center,
                  mainAxisAlignment: .start,
                  children: [
                    const SizedBox(width: 16,),

                    Text(
                      "Mobile Game Controller  Server",
                      style: tt.titleLarge?.copyWith(
                        color: cc.onSurface
                      ),
                    ),
                  ]
                ),
              )
            ),


            MyMinimizeWindowButton(),
            const SizedBox(width: 8,),
            MyCloseWindowButton(),
            const SizedBox(width: 8,)
          ],
        ),
      ),
    );
  }
}


class MyMinimizeWindowButton extends StatelessWidget{
  const MyMinimizeWindowButton({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final cc = Theme.of(context).colorScheme;
    
    return Transform.scale(
      scale: 1.3,
      child: MinimizeWindowButton(
        colors: WindowButtonColors(
          normal: Colors.transparent,
          mouseOver: cc.surfaceBright,
          mouseDown: cc.secondaryContainer,
          
          iconNormal   : cc.onSurface,
          iconMouseOver: cc.onSurfaceVariant,
          iconMouseDown: cc.onSecondaryContainer,
        ),
      ),
    );
  }
}

class MyMaximizeWindowButton extends StatelessWidget{
  const MyMaximizeWindowButton({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final cc = Theme.of(context).colorScheme;
    
    return Transform.scale(
      scale: 1.3,
      child: MaximizeWindowButton(
        colors: WindowButtonColors(
          normal: Colors.transparent,
          mouseOver: cc.surfaceBright,
          mouseDown: cc.secondaryContainer,
          
          iconNormal   : cc.onSurface,
          iconMouseOver: cc.onSurfaceVariant,
          iconMouseDown: cc.onSecondaryContainer,
        ),
      ),
    );
  }
}


class MyCloseWindowButton extends StatelessWidget{
  const MyCloseWindowButton({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    final cc = Theme.of(context).colorScheme;
    
    return Transform.scale(
      scale: 1.3,
      child: CloseWindowButton(
        colors: WindowButtonColors(
          normal: Colors.transparent,
          mouseOver: cc.surfaceBright,
          mouseDown: cc.secondaryContainer,
          
          iconNormal   : cc.onSurface,
          iconMouseOver: cc.onSurfaceVariant,
          iconMouseDown: cc.onSecondaryContainer,
        ),
      ),
    );
  }
}