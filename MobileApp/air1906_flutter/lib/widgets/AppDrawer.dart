import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:flutter/material.dart';



class AppDrawer extends StatelessWidget {
  final Widget scaffold;
  AppDrawer({this.scaffold});
  @override
  Widget build(BuildContext context)
  {
        return InnerDrawer(
            key: _innerDrawerKey,
            onTapClose: true, // default false
            swipe: true, // default true            
            colorTransition: Colors.blue, // default Color.black54
            
            // DEPRECATED: use offset
            leftOffset: 0.6, // Will be removed in 0.6.0 version
            rightOffset: 0.6,// Will be removed in 0.6.0 version
            
            //When setting the vertical offset, be sure to use only top or bottom
            offset: IDOffset.only(),
            
            // DEPRECATED:  use scale
            leftScale: 0.9,// Will be removed in 0.6.0 version
            rightScale: 0.9,// Will be removed in 0.6.0 version
            
            scale: IDOffset.horizontal( 0.8 ), // set the offset in both directions
            
            proportionalChildArea : true, // default true
            borderRadius: 50, // default 0
            leftAnimationType: InnerDrawerAnimation.static, // default static
            rightAnimationType: InnerDrawerAnimation.quadratic,
            backgroundColor: Colors.red, // default  Theme.of(context).backgroundColor
            
            //when a pointer that is in contact with the screen and moves to the right or left            
            onDragUpdate: (double val, InnerDrawerDirection direction) {
                // return values between 1 and 0
                print(val);
                // check if the swipe is to the right or to the left
                print(direction==InnerDrawerDirection.start);
            },
            
            innerDrawerCallback: (a) => print(a), // return  true (open) or false (close)
            leftChild: Container(), // required if rightChild is not set
            //rightChild: Container(), // required if leftChild is not set
            
            //  A Scaffold is generally used but you are free to use other widgets
            // Note: use "automaticallyImplyLeading: false" if you do not personalize "leading" of Bar
            scaffold: scaffold
            
            // CupertinoPageScaffold(                
            //     navigationBar: CupertinoNavigationBar(
            //         automaticallyImplyLeading: false
            //     ),
            // ), 
        );
    }
    
    //  Current State of InnerDrawerState
    final GlobalKey<InnerDrawerState> _innerDrawerKey = GlobalKey<InnerDrawerState>();    

    void _toggle()
    {
       _innerDrawerKey.currentState.toggle(
       // direction is optional 
       // if not set, the last direction will be used
       //InnerDrawerDirection.start OR InnerDrawerDirection.end                        
        direction: InnerDrawerDirection.end 
       );
    }
}