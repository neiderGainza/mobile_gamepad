import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class TitleBar extends StatelessWidget implements PreferredSizeWidget{
  const TitleBar({
    super.key
  });

  @override
  Size get preferredSize => Size.fromHeight(40);

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onPanStart: (_) => windowManager.startDragging(),
      child: Container(
        
        height: preferredSize.height,
        width: .infinity,
        color: Colors.transparent,

        child: Row(
          crossAxisAlignment: .center,
          mainAxisSize: .max,
          children: [
            const SizedBox(width: 16,),
            Text(
              "Mobile Gamepad Server", 
              style: tt.titleMedium?.copyWith(
                color: cs.onSurface
              ),
            ),
            const Spacer(),

            IconButton(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: .circular(8)
                ))
              ),
              hoverColor: cs.surfaceContainerHighest,
              onPressed: windowManager.minimize, 
              icon: Icon(Icons.horizontal_rule_outlined)
            ),
            
            IconButton(
              style: ButtonStyle(
                shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: .circular(8)
                ))
              ),
              hoverColor: cs.surfaceContainerHighest,
              onPressed: windowManager.close, 
              icon: Icon(Icons.close)
            ),
            
          ],
        ),
      ),
    );
  }
}