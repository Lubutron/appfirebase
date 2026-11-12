import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class EditUsuario extends StatefulWidget {
  const EditUsuario({super.key});

  @override
  State<EditUsuario> createState() => _EditUsuarioState();
}

class _EditUsuarioState extends State<EditUsuario> {
  TextEditingController nombreController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cuentaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    nombreController.text = arguments['nombre'] ?? '';
    emailController.text = arguments['email'] ?? '';
    cuentaController.text = arguments['numero de cuenta'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Usuario'),
        backgroundColor: Colors.amber,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            TextField(
              controller: nombreController,
              decoration: const InputDecoration(hintText: 'Modifica el nombre'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(hintText: 'Modifica el email'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: cuentaController,
              decoration: const InputDecoration(hintText: 'Modifica el número de cuenta'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await editUsuario(
                  arguments['uid'],
                  nombreController.text,
                  emailController.text,
                  cuentaController.text,
                ).then((_) {
                  if (mounted) Navigator.pop(context);
                });
              },
              child: const Text('Actualizar'),
            ),
          ],
        ),
      ),
    );
  }
}