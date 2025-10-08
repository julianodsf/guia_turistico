import 'package:flutter/material.dart';

class ItemModel {
  final String id;
  final String nome;
  final String descricao;
  final String imagemPath; // caminho para pasta assets de imagem
  final Color corDestaque;

  const ItemModel({
    required this.id,
    required this.nome,
    required this.descricao,
    required this.imagemPath,
    this.corDestaque = Colors.blue,
  });
}