import 'package:flutter/material.dart';

import 'item_model.dart';

class CategoriaModel {
  final String id;
  final String nome;
  final IconData icone;
  final List<ItemModel> subcategorias; // lista de subcategorias

  const CategoriaModel({
    required this.id,
    required this.nome,
    required this.icone,
    required this.subcategorias,
  });
}