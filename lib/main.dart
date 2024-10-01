import 'package:flutter/material.dart';

void main() {
  runApp(AppBancario());
}

class AppBancario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aplicação Bancária',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaginaInicial(),
    );
  }
}

class PaginaInicial extends StatefulWidget {
  @override
  _PaginaInicialState createState() => _PaginaInicialState();
}

class _PaginaInicialState extends State<PaginaInicial> {
  final _formKey = GlobalKey<FormState>();
  final _controladorNome = TextEditingController();
  final _controladorSaldo = TextEditingController();
  List<Map<String, String>> contas = [];

  void _adicionarConta() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        contas.add({
          'nome': _controladorNome.text,
          'saldo': _controladorSaldo.text,
        });
        _controladorNome.clear();
        _controladorSaldo.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplicação Bancária'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _controladorNome,
                    decoration: InputDecoration(labelText: 'Nome da Conta'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o nome da conta';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _controladorSaldo,
                    decoration: InputDecoration(labelText: 'Saldo Inicial'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Informe o saldo';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _adicionarConta,
                    child: Text('Adicionar Conta'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: contas.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Icon(Icons.account_balance),
                      title: Text(contas[index]['nome']!),
                      subtitle: Text('Saldo: R\$ ${contas[index]['saldo']}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
