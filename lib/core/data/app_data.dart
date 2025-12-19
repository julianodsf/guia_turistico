import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/categoria_model.dart';
import '../models/item_model.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<String> _favoriteItemIds = {};
  static const String _storageKey = 'favorite_items';

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? storedList = prefs.getStringList(_storageKey);
    if (storedList != null) {
      _favoriteItemIds.clear();
      _favoriteItemIds.addAll(storedList);
    }
    notifyListeners();
  }

  bool isFavorite(String itemId) => _favoriteItemIds.contains(itemId);

  Future<void> toggleFavorite(String itemId) async {
    if (_favoriteItemIds.contains(itemId)) {
      _favoriteItemIds.remove(itemId);
    } else {
      _favoriteItemIds.add(itemId);
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_storageKey, _favoriteItemIds.toList());
  }

  List<ItemModel> getFavoriteItems() {
    List<ItemModel> allItems = [];
    for (var cat in AppData.categorias) {
      allItems.addAll(cat.subcategorias);
    }
    return allItems
        .where((item) => _favoriteItemIds.contains(item.id))
        .toList();
  }
}

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  static const String _themeKey = 'is_dark_mode';

  bool get isDarkMode => _isDarkMode;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(_themeKey) ?? false; // Padrão é claro
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners(); // Atualiza a UI

    // arquivo local
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _isDarkMode);
  }
}

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  static const String _authKey = 'is_logged_in';

  bool get isAuthenticated => _isAuthenticated;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.getBool(_authKey) ?? false;
    notifyListeners();
  }

  // login simulado
  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw Exception('Preencha todos os campos.');
    }
    
    // Simula delay
    await Future.delayed(const Duration(seconds: 1));

    if (password == '123456') { 
      _isAuthenticated = true;
      notifyListeners();
      
      // Persistência da sessão
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_authKey, true);
    } else {
      throw Exception('Senha incorreta. Tente "123456".');
    }
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    notifyListeners();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_authKey); // remove a chave de sessão
  }
}

class AppData {
  static final List<CategoriaModel> categorias = [
    CategoriaModel(
      id: 'festividades',
      nome: 'Festividades',
      icone: Icons.celebration,
      subcategorias: const [
        ItemModel(
          id: 'corso_de_teresina',
          nome: 'Corso de Teresina',
          descricao: 'Conhecido por ser um dos maiores desfiles de carros decorados do mundo, entrando para o Guinness Book. Acontece no sábado que antecede o carnaval.',
          imagemPath: 'assets/corso_de_teresina.jpg',
          corDestaque: Colors.deepOrange,
        ),
        ItemModel(
          id: 'festejo_de_santo_antonio',
          nome: 'Festejos de Santo Antônio (Campo Maior)',
          descricao: 'Uma das maiores festas religiosas do Piauí, acontece de 31 de maio a 13 de junho, com missas, procissões e uma grande feira popular.',
          imagemPath: 'assets/festejo_de_santo_antonio.jpg',
          corDestaque: Colors.purple,
        ),
         ItemModel(
          id: 'festival_de_inverno',
          nome: 'Festival de Inverno de Pedro II',
          descricao: 'Realizado anualmente no feriado de Corpus Christi, atrai turistas com shows de jazz e blues, ecoturismo e o clima ameno da "Suíça piauiense".',
          imagemPath: 'assets/festival_de_inverno.jpg',
          corDestaque: Colors.blue,
        ),
      ],
    ),
    CategoriaModel(
      id: 'culinaria',
      nome: 'Culinária',
      icone: Icons.restaurant,
      subcategorias: const [
        ItemModel(
          id: 'arroz_com_capote',
          nome: 'Arroz com Capote',
          descricao: 'Capote é como a galinha dangola é conhecida na região. O prato é um arroz cozido com a carne da ave, resultando em um sabor único.',
          imagemPath: 'assets/arroz_com_capote.jpg',
          corDestaque: Colors.brown,
        ),
        ItemModel(
          id: 'panelada',
          nome: 'Panelada',
          descricao: 'Um cozido robusto feito com as vísceras (bucho e tripas) do boi, servido geralmente como um prato revigorante.',
          imagemPath: 'assets/panelada.jpg',
          corDestaque: Colors.amber,
        ),
        ItemModel(
          id: 'cajuina',
          nome: 'Cajuína',
          descricao: 'Bebida feita a partir do suco de caju, clarificada e sem álcool. É Patrimônio Cultural Brasileiro e um símbolo do Piauí..',
          imagemPath: 'assets/cajuina.jpg',
          corDestaque: Colors.blue,
        ),
      ],
    ),
    CategoriaModel(
      id: 'praias',
      nome: 'Praias',
      icone: Icons.beach_access,
      subcategorias: const [
        ItemModel(
          id: 'praia_coqueiro',
          nome: 'Praia do Coqueiro (Luís Correia)',
          descricao: 'Uma das mais conhecidas e estruturadas, com diversas barracas e quiosques. Suas águas calmas e recifes formam piscinas naturais na maré baixa.',
          imagemPath: 'assets/praia_coqueiro.jpg',
          corDestaque: Colors.teal,
        ),
        ItemModel(
          id: 'praia_atalaia',
          nome: 'Praia de Atalaia (Luís Correia)',
          descricao: 'É a praia mais movimentada e com a maior infraestrutura de barracas do litoral. Possui uma larga faixa de areia e mar tranquilo, ideal para famílias.',
          imagemPath: 'assets/praia_atalaia.jpg',
          corDestaque: Colors.lightBlue,
        ),
        ItemModel(
          id: 'praia_pedra',
          nome: 'Praia Pedra do Sal (Parnaíba)',
          descricao: 'Dividida por um conjunto de rochas graníticas, oferece dois cenários: um lado com mar calmo e outro com ondas fortes, perfeito para o surf. O pôr do sol visto das pedras é um espetáculo.',
          imagemPath: 'assets/praia_pedra.jpg',
          corDestaque: Colors.lightBlue,
        ),
      ],
    ),
  ];
}