import 'package:admin_dashboard/api/flutter_web_api.dart';
import 'package:admin_dashboard/models/categoria.dart';
import 'package:admin_dashboard/models/http/categories_response.dart';
import 'package:flutter/cupertino.dart';

class CategoriasProvider extends ChangeNotifier{

  List<Categoria> categorias = [];

  getCategorias()async{

    final resp = await FlutterWebApi.httpGet('/categorias');
    final categoriesResponse = CategoriesResponse.fromMap(resp);

    this.categorias = categoriesResponse.categorias;

    print( this.categorias );

    notifyListeners();
  }

  Future newCategories(String name) async{

    final data = {
      'nombre': name
    };

    try{

      final json = await FlutterWebApi.post('/categorias', data);
      final newcategoria = Categoria.fromMap(json);

      categorias.add( newcategoria );
      notifyListeners();

    }
    catch(e){
      print(e);
    }

  }

}