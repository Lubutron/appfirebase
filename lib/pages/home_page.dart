import 'package:flutter/material.dart';
import '../services/firebase_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase CRUD'),
        backgroundColor: Colors.amber,
      ),
      body: FutureBuilder(
        future: getUsuarios(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final usuario = snapshot.data?[index];
                return Dismissible(
                  key: Key(usuario['uid']),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    bool result = false;
                    result = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('¿Estás seguro de eliminar a ${usuario['nombre']}?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancelar', style: TextStyle(color: Colors.red)),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Sí, estoy seguro'),
                            ),
                          ],
                        );
                      },
                    );
                    return result;
                  },
                  onDismissed: (direction) async {
                    await deleteUsuario(usuario['uid']);
                    snapshot.data?.removeAt(index);
                  },
                  child: ListTile(
                    title: Text(usuario['nombre'] ?? ''),
                    subtitle: Text('${usuario['email'] ?? ''} - Cuenta: ${usuario['numero de cuenta'] ?? ''}'),
                    onTap: () async {
                      await Navigator.pushNamed(
                        context,
                        '/edit',
                        arguments: {
                          'uid': usuario['uid'],
                          'nombre': usuario['nombre'],
                          'email': usuario['email'],
                          'numero de cuenta': usuario['numero de cuenta'],
                        },
                      );
                      setState(() {});
                    },
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}