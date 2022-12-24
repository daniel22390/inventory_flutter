import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:inventory/core/services/auth_service.dart';
import 'package:inventory/pages/bar_code_screen.dart';
import 'package:inventory/pages/create_screen.dart';
import 'package:inventory/pages/list_products_screen.dart';
import 'package:inventory/utils/app_routes.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  int _selectedScreenIndex = 0;

  List<Map<String, Object>>? _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      {
        'title': 'Produtos',
        'screen': const ListProductsScreen(),
      },
      {
        'title': 'Leitura de Código',
        'screen': const BarCodeScreen(),
      },
      {
        'title': 'Cadastro',
        'screen': const CreateScreen(),
      },
    ];
  }

  _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _screens![_selectedScreenIndex]['title'] as String,
        ),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.black87,
                        ),
                        SizedBox(width: 10),
                        Text('Sair'),
                      ],
                    ),
                  ),
                ),
              ],
              onChanged: (value) {
                if (value == 'logout') {
                  AuthService().logout();
                }
              },
            ),
          ),
        ]
      ),
      body: _screens![_selectedScreenIndex]['screen'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        backgroundColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedScreenIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.view_module_outlined),
            label: 'Produtos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.photo_camera_back),
            label: 'Código de Barras',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.create),
            label: 'Cadastro',
          ),
        ],
      ),
      floatingActionButton: _selectedScreenIndex == 0 ? FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            AppRoutes.newproduct
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.add),
      ) : null,
    );
  }
}