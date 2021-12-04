import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_agenda/data/model/persona.dart';
import 'package:flutter_agenda/domain/controllers/autenticar_controller.dart';
import 'package:flutter_agenda/domain/controllers/persona_controller.dart';
import 'package:get/get.dart';

// Widget encargado de la creacion de una persona
class CrearWidget extends StatefulWidget {
  const CrearWidget({Key? key}) : super(key: key);

  @override
  _CrearWidgetState createState() => _CrearWidgetState();
}

class _CrearWidgetState extends State<CrearWidget> {
  // Llave del formulario para manejo de estados
  final _formKey = GlobalKey<FormState>();
  // Controladores de campos de texto
  final tipoCtrl = TextEditingController();
  final docuCtrl = TextEditingController();
  final nombCtrl = TextEditingController();
  final apelCtrl = TextEditingController();
  final mailCtrl = TextEditingController();
  final teleCtrl = TextEditingController();
  // Inyeccion de controladores
  PersonaController personaController = Get.find();
  AutenticarController authenticationController = Get.find();

  // Metodo para crear una persona
  _crearPersona(Persona persona) async {
    try {
      // Se invoca futuro para la creacion
      await personaController.agregar(persona);
      // Limpiar el formulario
      tipoCtrl.clear();
      docuCtrl.clear();
      nombCtrl.clear();
      apelCtrl.clear();
      mailCtrl.clear();
      teleCtrl.clear();
      // Mensaje informativo
      Get.snackbar(
        "Creacion de Personas",
        "Persona creada exitosamente!",
        icon: const Icon(
          Icons.person_add,
          color: Colors.red,
        ),
      );
    } catch (e) {
      Get.snackbar(
        "Creacion de Personas",
        "Error: ${e.toString()}",
        icon: const Icon(
          Icons.person_add,
          color: Colors.red,
        ),
      );
    }
  }

  // Crear widget para representar el formulario
  Widget formulario() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Expanded(
            child: ListView(
              children: [
                const Text(
                  "Registro de Personas",
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Campo para el tipo
                TextFormField(
                  controller: tipoCtrl,
                  decoration: const InputDecoration(labelText: "Tipo"),
                  validator: (value) {
                    // Valida que no se vacio
                    if (value!.isEmpty) {
                      return "Tipo es obligatorio!";
                      // Valida que sea encuentre en las siguientes opciones
                    } else if (value != 'CC' &&
                        value != 'CE' &&
                        value != 'TI' &&
                        value != 'PS') {
                      return "Tipo no es valido (CC, CE, TI, PS)!";
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                // Campo para el documento
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: docuCtrl,
                  decoration: const InputDecoration(labelText: "Documento"),
                  validator: (value) {
                    // Valida que no se vacio
                    if (value!.isEmpty) {
                      return "Documento es obligatorio!";
                      // Valida que sea encuentre con la longitud correcta
                    } else if (value.length < 4) {
                      return "Documento debe tener longitud superior a 4 digitos!";
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                // Campo para el nombre
                TextFormField(
                  controller: nombCtrl,
                  decoration: const InputDecoration(labelText: "Nombres"),
                  validator: (value) {
                    // Valida que no se vacio
                    if (value!.isEmpty) {
                      return "Nombre es obligatorio!";
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                // Campo para el apellido
                TextFormField(
                  controller: apelCtrl,
                  decoration: const InputDecoration(labelText: "Apellidos"),
                  validator: (value) {
                    // Valida que no sea vacio
                    if (value!.isEmpty) {
                      return "Apellido es obligatorio!";
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
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
                    // Valida que no sea vacio
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
                // Campo para el telefono
                TextFormField(
                  keyboardType: TextInputType.phone,
                  controller: teleCtrl,
                  decoration: const InputDecoration(labelText: "Telefono"),
                  validator: (value) {
                    // Valida que no sea vacio
                    if (value!.isEmpty) {
                      return "Telefono es obligatorio!";
                      // Valida que sea un correo correcto
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
                      Persona persona = Persona(
                          tipoCtrl.text,
                          docuCtrl.text,
                          nombCtrl.text,
                          apelCtrl.text,
                          mailCtrl.text,
                          teleCtrl.text);
                      _crearPersona(persona);
                    }
                  },
                  child: const Text("Crear"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: formulario(),
        ),
      ],
    );
  }
}