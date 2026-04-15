import '../controllers/auth_controller.dart';
import 'package:cota_zap/core/di/injection.dart';
import 'package:cota_zap/core/theme/app_theme.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: const Color(0xFF0F172A),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F172A), Color(0xFF1E293B), Color(0xFF0F172A)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: 120,
                      errorBuilder: (context, error, stackTrace) => Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.05),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.bolt_rounded,
                          size: 80,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'CotaZap',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Elite Procurement & WhatsApp Automation',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: const Color(0xFF94A3B8),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 56),
                  
                  Container(
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'E-mail Profissional',
                            labelStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                            hintText: 'comprador@empresa.com',
                            hintStyle: TextStyle(color: Colors.white.withOpacity(0.2)),
                            prefixIcon: Icon(Icons.alternate_email_rounded, color: Colors.white.withOpacity(0.5)),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.05),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (val) => val == null || !val.contains('@') ? 'E-mail inválido' : null,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            labelText: 'Senha de Acesso',
                            labelStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                            prefixIcon: Icon(Icons.lock_person_rounded, color: Colors.white.withOpacity(0.5)),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.05),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          validator: (val) => val == null || val.length < 6 ? 'Mínimo 6 caracteres' : null,
                        ),
                        const SizedBox(height: 40),
                        SizedBox(
                          width: double.infinity,
                          height: 64,
                          child: ElevatedButton(
                            onPressed: authState.isLoading ? null : _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              elevation: 0,
                            ),
                            child: authState.isLoading 
                                ? const CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    'ACESSAR PLATAFORMA', 
                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w800, 
                                      fontSize: 14, 
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Novo na rede?', style: GoogleFonts.plusJakartaSans(color: const Color(0xFF94A3B8))),
                      TextButton(
                        onPressed: () => context.go('/register'),
                        child: Text(
                          'Crie sua cotação free', 
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.white, 
                            fontWeight: FontWeight.w800, 
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
