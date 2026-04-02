import 'package:flutter/material.dart';

class QuotationListPage extends StatelessWidget {
  const QuotationListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Histórico de Cotações')),
      body: const Center(child: Text('Aqui serão listadas as cotações ativas e finalizadas.')),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/new-quotation'),
      ),
    );
  }
}
