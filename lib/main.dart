import 'package:flutter/material.dart';
import 'dart:convert'; // Para convertir los datos JSON
import 'package:http/http.dart' as http; // Para realizar solicitudes HTTP

void main() {
  runApp(const MyApp());
}

// MyApp es el widget principal de la aplicación
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo API Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProductPage(),
    );
  }
}

// ProductPage es la pantalla principal que muestra los productos obtenidos de la API
class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  // Variable para almacenar la lista de productos
  List<dynamic> products = [];

  // Función asíncrona para obtener los productos desde la API simulada
  Future<void> fetchProducts() async {
    // Endpoint de la API simulada (puede ser reemplazado por una URL real)
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final response = await http.get(url);

    // Verificamos si la solicitud fue exitosa
    if (response.statusCode == 200) {
      // Convertimos la respuesta en una lista de productos
      setState(() {
        products = json.decode(response.body);
      });
    } else {
      // Si algo sale mal, mostramos un mensaje de error
      throw Exception('Error al cargar los productos');
    }
  }

  // Inicializamos la carga de productos al inicio
  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  // Método para construir la UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Productos'),
      ),
      body: products.isEmpty
          ? const Center(
              child:
                  CircularProgressIndicator()) // Muestra un loader mientras carga
          : ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(products[index]['title']), // Título del producto
                  subtitle:
                      Text(products[index]['body']), // Descripción del producto
                );
              },
            ),
    );
  }
}
