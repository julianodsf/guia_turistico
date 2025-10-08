import 'package:flutter/material.dart';
import '../../../core/models/item_model.dart';
import '../../item_details/item_details_screen.dart';

class SubcategoryCard extends StatelessWidget {
  final ItemModel item;

  const SubcategoryCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    // GestureDetector simula o 'botão' da subcategoria
    return GestureDetector(
      onTap: () {
        // Navegação para a tela de detalhes
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemDetailsScreen(item: item),
          ),
        );
      },
      child: Card(
        color: item.corDestaque.withOpacity(0.1),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: item.corDestaque, width: 2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Icon(Icons.arrow_right, color: item.corDestaque),
              const SizedBox(width: 10),
              // Nome do item
              Expanded(
                child: Text(
                  item.nome,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: item.corDestaque,
                  ),
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
        ),
      ),
    );
  }
}