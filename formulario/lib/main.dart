import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.blue.shade50,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          labelStyle: TextStyle(color: Colors.blue.shade700),
        ),
      ),
      home: FormularioScreen(),
    );
  }
}

class FormularioScreen extends StatefulWidget {
  @override
  _FormularioScreenState createState() => _FormularioScreenState();
}

class _FormularioScreenState extends State<FormularioScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _cedulaController = TextEditingController();
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _fechaNacimientoController = TextEditingController();

  String? _generoSeleccionado = 'Masculino';
  bool _esCasado = false;

  int? calcularEdad(DateTime fechaNacimiento) {
    final DateTime hoy = DateTime.now();
    int edad = hoy.year - fechaNacimiento.year;
    if (hoy.month < fechaNacimiento.month ||
        (hoy.month == fechaNacimiento.month && hoy.day < fechaNacimiento.day)) {
      edad--;
    }
    return edad;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario de Registro'),
        backgroundColor: Colors.blue.shade600,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Campo Cédula
                TextFormField(
                  controller: _cedulaController,
                  decoration: InputDecoration(labelText: 'Cedula'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su cedula';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                // Campo Nombres
                TextFormField(
                  controller: _nombresController,
                  decoration: InputDecoration(labelText: 'Nombres'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese sus nombres';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                // Campo Apellidos
                TextFormField(
                  controller: _apellidosController,
                  decoration: InputDecoration(labelText: 'Apellidos'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese sus apellidos';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                // Campo Fecha de nacimiento
                TextFormField(
                  controller: _fechaNacimientoController,
                  decoration: InputDecoration(labelText: 'Fecha de Nacimiento (yyyy-mm-dd)'),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su fecha de nacimiento';
                    }
                    try {
                      DateTime.parse(value);
                    } catch (e) {
                      return 'Fecha invalida';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                // Radio Buttons para Género
                Text('Genero:', style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Radio<String>(
                      value: 'Masculino',
                      groupValue: _generoSeleccionado,
                      onChanged: (String? value) {
                        setState(() {
                          _generoSeleccionado = value;
                        });
                      },
                    ),
                    Text('Masculino'),
                    Radio<String>(
                      value: 'Femenino',
                      groupValue: _generoSeleccionado,
                      onChanged: (String? value) {
                        setState(() {
                          _generoSeleccionado = value;
                        });
                      },
                    ),
                    Text('Femenino'),
                  ],
                ),
                SizedBox(height: 16.0),
                // Checkbox para Estado Civil
                Row(
                  children: [
                    Checkbox(
                      value: _esCasado,
                      onChanged: (bool? value) {
                        setState(() {
                          _esCasado = value!;
                        });
                      },
                    ),
                    Text('Esta casado?'),
                  ],
                ),
                SizedBox(height: 24.0),
                // Botones
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Salir'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Formulario Enviado'),
                                content: Text('Formulario valido y enviado!'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Aceptar'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      child: Text('Siguiente'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
