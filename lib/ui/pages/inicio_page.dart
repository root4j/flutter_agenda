import 'package:flutter/material.dart';
import 'package:flutter_agenda/domain/controllers/autenticar_controller.dart';
import 'package:flutter_agenda/ui/widgets/crear_widget.dart';
import 'package:flutter_agenda/ui/widgets/visualizar_widget.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

// Widget para el manejo principal si tengo sesion o debo iniciar sesion
class InicioPage extends StatefulWidget {
  const InicioPage({Key? key}) : super(key: key);

  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  // Atributo
  int _selectIndex = 0;
  // Controlador de autenticacion
  AutenticarController authenticationController = Get.find();
  // Listado de Widgets a mostrar
  static final List<Widget> _widgets = <Widget>[
    const VisualizarWidget(),
    const CrearWidget()
  ];

  // Metodo para realizar cambio de Widget
  _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  // Metodo para finalizar sesion
  _logout() async {
    try {
      await authenticationController.logOut();
    } catch (e) {
      logError(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(authenticationController.mail()),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              _logout();
            },
          ),
        ],
      ),
      body: _widgets.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.view_agenda), label: "Datos"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_add), label: "Agregar"),
        ],
        currentIndex: _selectIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
