import 'package:flutter/material.dart';

// Função principal: ponto de entrada da aplicação Flutter
void main() {
  runApp(const MyApp()); // Executa o widget raiz da aplicação
}

// Widget raiz da aplicação
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // Método build: constrói a interface do usuário
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Demo', // Título do app
      theme: ThemeData(primarySwatch: Colors.blue), // Tema principal (cor azul)
      home: const LoginPage(), // Define a tela inicial como a tela de login
    );
  }
}

// Tela de Login - Stateful porque os campos podem mudar
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// Estado da tela de login
class _LoginPageState extends State<LoginPage> {
  // Chave global para identificar o formulário e permitir validações
  final _formKey = GlobalKey<FormState>();

  // Controladores para capturar o texto digitado nos campos
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Função chamada ao clicar no botão "Entrar"
  void _login() {
    // Valida os campos do formulário
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text; // Pega o valor do email
      String password = _passwordController.text; // Pega o valor da senha

      // Mostra uma mensagem temporária na parte inferior da tela
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email: $email, Senha: $password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Estrutura básica com AppBar e corpo
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(
          16.0,
        ), // Espaçamento em volta do formulário
        child: Form(
          key: _formKey, // Vincula o formulário à chave para validações
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Centraliza os campos
            children: [
              // Campo de texto para Email
              TextFormField(
                controller: _emailController, // Controlador do campo
                decoration: const InputDecoration(
                  labelText: "Email", // Texto que aparece dentro do campo
                  border: OutlineInputBorder(), // Borda ao redor do campo
                ),
                keyboardType: TextInputType.emailAddress, // Teclado de email
                // Validação do campo
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite seu email';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16), // Espaçamento entre os campos
              // Campo de texto para Senha
              TextFormField(
                controller: _passwordController, // Controlador do campo
                decoration: const InputDecoration(
                  labelText: "Senha",
                  border: OutlineInputBorder(),
                ),
                obscureText: true, // Esconde os caracteres digitados
                // Validação do campo
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Digite sua senha';
                  }
                  if (value.length < 6) {
                    return 'A senha deve ter pelo menos 6 caracteres';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20), // Espaço antes do botão
              // Botão de Login
              ElevatedButton(
                onPressed: _login, // Chama a função de login
                child: const Text("Entrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
