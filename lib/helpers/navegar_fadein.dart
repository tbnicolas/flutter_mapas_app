
part of 'helpers.dart';

Route navegarMapaFadeIn( BuildContext context, Widget page ) {

  return new PageRouteBuilder(
    pageBuilder: (_, __,___) => page,
    transitionDuration:  new Duration( milliseconds: 300 ),
    transitionsBuilder: ( context, animation,_,child){

      return FadeTransition(
        child: child,
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            curve: Curves.easeOut, 
            parent: animation
          )
        )
      );

    }
  );

}