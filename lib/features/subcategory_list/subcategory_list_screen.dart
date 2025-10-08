import 'package:flutter/material.dart';
import '../../core/models/categoria_model.dart';
import '../../core/widgets/custom_appbar.dart';
import 'widgets/subcategory_card.dart';

class SubcategoryListScreen extends StatelessWidget {
  final CategoriaModel categoria;

  const SubcategoryListScreen({super.key, required this.categoria});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar com retorno
      appBar: CustomAppBar(
        title: 'Subcategorias de ${categoria.nome}',
        showBackButton: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        // Lista de subcategorias para popular o ListView
        itemCount: categoria.subcategorias.length,
        itemBuilder: (context, index) {
          final item = categoria.subcategorias[index];
          // Widgets semelhantes organizados e usando dados (ItemModel)
          // Reutilização do SubcategoryCard
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: SubcategoryCard(item: item),
          );
        },
      ),
    );
  }
}