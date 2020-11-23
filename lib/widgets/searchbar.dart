part of 'widgets.dart';

class SearchBar extends StatelessWidget {
 
 
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if ( state.seleccionManual && !state.confirmarDestino ) {
          return new Container();
        } else { 
          return buildSwarchBar(context);
        }
      },
    );
  }


  
  Widget buildSwarchBar(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return new SafeArea(
      child: new Container(
        padding: EdgeInsets.symmetric(horizontal: 30),
        width: size.width,
        child: new GestureDetector(
          onTap: () async {
            print('Buscando...');
            final SearchResult resultado = await showSearch(
              context: context, 
              delegate: new SearchDestination()
            );
            this.retornoBusqueda(context, resultado);
            print(resultado);
          },
          child: new Container(
            padding: EdgeInsets.symmetric(horizontal:20, vertical: 13 ),
            width: double.infinity,
            //height: 20,
            child: new Text('¿Donde Quieres ir?',
              style: new TextStyle(
                color: Colors.black87
              ),
            ),
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: <BoxShadow>[
                new BoxShadow(
                  color:Colors.black12,
                  blurRadius: 5,
                  offset: new Offset(0,5)
                )
              ]
            ),
          ),
        )
      ),
    );

  }

  void retornoBusqueda(BuildContext context, SearchResult result ) {
    print('==> Cancelo: ${result.cancelo}');
    print('==> Manual: ${result.manual}');
    if( result.cancelo) return;
    if( result.manual ) {
      context.bloc<BusquedaBloc>().add( new OnActivarMarcadorManual() );
      return;
    }

  }


}