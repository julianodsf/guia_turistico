import 'package:flutter/material.dart';
import '../../../core/models/categoria_model.dart';

class CategoryButton extends StatelessWidget {
  final CategoriaModel categoria;
  final VoidCallback onTap;

  const CategoryButton({
    super.key,
    required this.categoria,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, 
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(categoria.icone, size: 30),
          const SizedBox(width: 15),
          Text(
            categoria.nome,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}