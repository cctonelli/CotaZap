import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../controllers/auth_controller.dart';
import 'package:cota_zap/core/di/injection.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      ref.read(authControllerProvider.notifier).signIn(
        _emailController.text,
        _passwordController.text,
      ).then((_) {
        final authState = ref.read(authControllerProvider);
        if (authState.hasValue && authState.value != null) {
          final email = _emailController.text.trim().toLowerCase();
          
          if (email == 'admin@cotazap.com.br') {
            ref.read(userRoleProvider.notifier).state = UserRole.admin;
            context.go('/admin-dashboard');
          } else {
            context.go('/onboarding');
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    
    // Mostra erro caso ocorra
    if (authState.hasError && !authState.isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro no Login: ${authState.error}'), backgroundColor: Colors.red),
        );
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.bolt, size: 80, color: Color(0xFF128C7E)),
                const SizedBox(height: 16),
                const Text(
                  'Bem-vindo ao CotaZap',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF075E54)),
                ),
                const SizedBox(height: 8),
                const Text('Login rápido e manual', style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 48),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  validator: (val) => val == null || !val.contains('@') ? 'Email inválido' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  validator: (val) => val == null || val.length < 6 ? 'Mínimo 6 caracteres' : null,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: authState.isLoading ? null : _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF128C7E),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 0,
                    ),
                    child: authState.isLoading 
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text('ENTRAR', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Não tem conta?', style: TextStyle(color: Colors.black54)),
                    TextButton(
                      onPressed: () => context.go('/register'),
                      child: const Text('Cadastre-se', style: TextStyle(color: Color(0xFF128C7E), fontWeight: FontWeight.bold)),
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
