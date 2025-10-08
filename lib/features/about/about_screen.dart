import 'package:flutter/material.dart';
import '../../core/widgets/custom_appbar.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Sobre e Equipe',
        showBackButton: true, 
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Sobre o Aplicativo',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Divider(),
            const Text(
              'O "Explore o Piauí" foi desenvolvido como primeira avaliação da matéria de PDM.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 30),
            Text(
              'Membros da Equipe',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.person, color: Colors.blue),
              title: Text('Desenvolvedor'),
              subtitle: Text('Juliano Farias'),
            ),
            const ListTile(
              leading: Icon(Icons.people, color: Colors.blue),
              title: Text('Desenvolvedor'),
              subtitle: Text('Mateus Castro'),
            ),
            const ListTile(
              leading: Icon(Icons.people, color: Colors.blue),
              title: Text('Design'),
              subtitle: Text('Yago Braga'),
            ),
            const ListTile(
              leading: Icon(Icons.people, color: Colors.blue),
              title: Text('Conteúdo'),
              subtitle: Text('Carlos Eduardo'),
            ),
          ],
        ),
      ),
    );
  }
}