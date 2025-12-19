import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/data/app_data.dart';
import '../../core/widgets/custom_appbar.dart';
import '../subcategory_list/subcategory_list_screen.dart';
import 'widgets/category_button.dart';
import '../subcategory_list/widgets/subcategory_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // BottomNavigationBar
  late final List<Widget> _widgetOptions = <Widget>[
    const CategorySelectionBody(), 
    const FavoritesScreen(), // usa Provider
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Explore o Piauí'),
      body: _widgetOptions.elementAt(_selectedIndex),
      
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Categorias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class CategorySelectionBody extends StatelessWidget {
  const CategorySelectionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: AppData.categorias.map((categoria) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: CategoryButton(
              categoria: categoria,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubcategoryListScreen(
                      categoria: categoria,
                    ),
                  ),
                );
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(
      builder: (context, favoritesProvider, child) {
        
        final favoriteItems = favoritesProvider.getFavoriteItems();

        if (favoriteItems.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_border, size: 80, color: Colors.grey),
                SizedBox(height: 10),
                Text(
                  'Você ainda não adicionou nenhum item aos favoritos.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemCount: favoriteItems.length,
          itemBuilder: (context, index) {
            final item = favoriteItems[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: SubcategoryCard(item: item),
            );
          },
        );
      },
    );
  }
}