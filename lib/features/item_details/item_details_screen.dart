import 'package:flutter/material.dart';
import '../../core/models/item_model.dart';
import '../../core/widgets/custom_appbar.dart';
import '../../core/data/app_data.dart';

class ItemDetailsScreen extends StatefulWidget {
  final ItemModel item;

  const ItemDetailsScreen({super.key, required this.item});

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState();
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    // Inicializa o estado local verificando no gerenciador global
    _isFavorite = FavoriteManager.isFavorite(widget.item.id);
  }

  void _toggleFavorite() {
    setState(() {
      // Alterna o estado de favorito no gerenciador
      FavoriteManager.toggleFavorite(widget.item.id);
      _isFavorite = FavoriteManager.isFavorite(widget.item.id);

      // Exibe uma SnackBar para feedback visual
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isFavorite
              ? '${widget.item.nome} adicionado aos favoritos!'
              : '${widget.item.nome} removido dos favoritos!'),
          duration: const Duration(seconds: 1),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.item.nome,
        showBackButton: true,
        // Botão de favorito na AppBar
        actions: [
          IconButton(
            icon: Icon(
              // Muda o ícone de acordo com seu estado
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagem que representa o item
            Image.asset(
              widget.item.imagemPath,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              // Fallback para quando a imagem não for encontrada
              errorBuilder: (context, error, stackTrace) => Container(
                height: 250,
                color: Colors.grey[300],
                child: const Center(child: Text('Imagem não encontrada')),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.nome,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: widget.item.corDestaque,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Descrição:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Descrição abaixo da imagem
                  Text(
                    widget.item.descricao,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}