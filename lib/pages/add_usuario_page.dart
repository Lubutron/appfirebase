import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class AddUsuario extends StatefulWidget {
  const AddUsuario({super.key});

  @override
  State<AddUsuario> createState() => _AddUsuarioState();
}

class _AddUsuarioState extends State<AddUsuario> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cuentaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Usuario'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(hintText: 'Ingresa el nombre'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Ingresa el email'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: cuentaController,
              decoration: const InputDecoration(hintText: 'Ingresa el número de cuenta'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await agregarUsuario(
                  nombreController.text,
                  emailController.text,
                  cuentaController.text,
                ).then((_) {
                  if (mounted) Navigator.pop(context);
                });
              },
              child: const Text('Guardar'),
            ),
          ],
        ),
      ),
    );
  }
}