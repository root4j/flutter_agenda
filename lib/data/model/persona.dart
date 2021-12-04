import 'package:cloud_firestore/cloud_firestore.dart';

// Clase que representa la entidad Persona
class Persona {
  // Atributos
  final String tipo;
  final String docu;
  final String nomb;
  final String apel;
  final String mail;
  final String tele;
  // Auditoria
  late String usua;
  late Timestamp fecha;
  // Documento de Referencia en Firestore [Obligatorio]
  late DocumentReference reference;

  // Constructor
  Persona(this.tipo, this.docu, this.nomb, this.apel, this.mail, this.tele);

  // Metodo que se encarga de convertir un mapa en un objeto de registros [Obligatorio]
  Persona.fromMap(Map<String, dynamic> map, {required this.reference})
      : assert(map['tipo'] != null),
        assert(map['docu'] != null),
        assert(map['nomb'] != null),
        assert(map['apel'] != null),
        assert(map['mail'] != null),
        assert(map['tele'] != null),
        assert(map['usua'] != null),
        tipo = map['tipo'],
        docu = map['docu'],
        nomb = map['nomb'],
        apel = map['apel'],
        mail = map['mail'],
        tele = map['tele'],
        usua = map['usua'],
        fecha = map['fecha'];

  // Metodo que se encarga de convertir un Documento de la base de datos
  // a un mapa de flutter [Obligatorio]
  Persona.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data() as Map<String, dynamic>,
            reference: snapshot.reference);

  // Metodo para serializar a JSON
  toJson(String? usuario) {
    return {
      'tipo': tipo,
      'docu': docu,
      'nomb': nomb,
      'apel': apel,
      'mail': mail,
      'tele': tele,
      'usua': usuario,
      'fecha': Timestamp.now(),
    };
  }

  // Se sobre escribe el metodo de toString
  @override
  String toString() => "Persona<$docu:$nomb:$apel>";
}
