import 'package:flutter/material.dart';
import 'package:flutter_agenda/domain/controllers/autenticar_controller.dart';
import 'package:get/get.dart';

// Widget para el manejo de creacion de usuario
class RegistrarPage extends StatefulWidget {
  const RegistrarPage({Key? key}) : super(key: key);

  @override
  _RegistrarPageState createState() => _RegistrarPageState();
}

class _RegistrarPageState extends State<RegistrarPage> {
  // Llave del formulario para manejo de estados
  final _formKey = GlobalKey<FormState>();
  // Controladores de campos de texto
  final mailCtrl = TextEditingController();
  final pswdCtrl = TextEditingController();
  // Controlador de autenticacion
  AutenticarController autCtrl = Get.find();

  // Metodo para crear un usuario
  _registrar(correo, password) async {
    try {
      await autCtrl.signUp(correo, password);
      // Mensaje de informacion
      Get.snackbar(
        "Registrar Usuario",
        'Usuario registrado exitosamente!',
        icon: const Icon(Icons.person_add, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (err) {
      // Mensaje de error
      Get.snackbar(
        "Registrar Usuario",
        err.toString(),
        icon: const Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Registro de Usuario",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Campo para el Correo Electronico
                TextFormField(
                  // El campo me va proporcionar un teclado exclusivo
                  // para escribir correos electronicos
                  keyboardType: TextInputType.emailAddress,
                  controller: mailCtrl,
                  decoration:
                      const InputDecoration(labelText: "Correo Electronico"),
                  validator: (value) {
                    // Valida que haya digitado un correo
                    if (value!.isEmpty) {
                      return "Correo Electronico es obligatorio!";
                      // Valida que sea un correo correcto
                    } else if (!value.contains('@')) {
                      return "Correo Electronico no cumple las politicas!";
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                // Campo para la Contrase??a
                TextFormField(
                  // El campo me va proporcionar un teclado exclusivo
                  // para escribir solo numeros
                  keyboardType: TextInputType.number,
                  controller: pswdCtrl,
                  decoration: const InputDecoration(labelText: "Contrase??a"),
                  obscureText: true,
                  validator: (value) {
                    // Valida que haya digitado una contrase??a
                    if (value!.isEmpty) {
                      return "Contrase??a es obligatoria!";
                      // Valida longitud del campo
                    } else if (value.length < 6) {
                      return "Contrase??a debe ser mayor o igual a 6 digitos!";
                    }
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  onPressed: () {
                    final form = _formKey.currentState;
                    form!.save();
                    // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                    FocusScope.of(context).requestFocus(FocusNode());
                    if (_formKey.currentState!.validate()) {
                      _registrar(mailCtrl.text, pswdCtrl.text);
                    }
                  },
                  child: const Text("Registrar"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}