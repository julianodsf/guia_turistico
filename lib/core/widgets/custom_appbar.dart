import 'package:flutter/material.dart';

// AppBar reutilizável
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBackButton; // controla a exibição do botão de retorno
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton = false,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      centerTitle: true,
      // Se showBackButton for true, usa o padrão do Flutter para retorno, 
      // se não, não exibe o botão.
      automaticallyImplyLeading: showBackButton, 
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}