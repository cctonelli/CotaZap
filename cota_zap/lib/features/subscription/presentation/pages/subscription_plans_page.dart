import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/di/injection.dart';
import '../controllers/subscription_controller.dart';

class SubscriptionPlansPage extends ConsumerWidget {
  const SubscriptionPlansPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subscriptionState = ref.watch(subscriptionControllerProvider);
    final currentPlan = ref.watch(planTypeProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Nossos Planos', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildHero(),
                const SizedBox(height: 20),
                _buildPlanCard(
                  context,
                  title: 'Gratuito',
                  price: r'R$ 0',
                  description: 'Para pequenos negócios começando agora.',
                  features: [
                    'Até 5 cotações/mês',
                    'Acesso a fornecedores locais',
                    'Suporte por e-mail',
                  ],
                  isPopular: false,
                  buttonText: currentPlan == 'free' ? 'Plano Atual' : 'Downgrade',
                  onPressed: currentPlan == 'free' ? null : () => _handleUpgrade(context, ref, 'free'),
                ),
                _buildPlanCard(
                  context,
                  title: 'Profissional',
                  price: r'R$ 149',
                  description: 'Otimize seu procurement com inteligência.',
                  features: [
                    'Cotações ilimitadas',
                    'Procurement Engine (Scoring)',
                    'Rede CotaZap Premium',
                    'Suporte prioritário (WhatsApp)',
                    'Relatórios de economia',
                  ],
                  isPopular: true,
                  buttonText: currentPlan == 'premium' ? 'Plano Atual' : 'Fazer Upgrade',
                  color: AppTheme.primaryColor,
                  onPressed: currentPlan == 'premium' ? null : () => _handleUpgrade(context, ref, 'premium'),
                ),
                _buildPlanCard(
                  context,
                  title: 'Enterprise',
                  price: 'Consulte',
                  description: 'Solução sob medida para grandes operações.',
                  features: [
                    'Tudo do Profissional',
                    'API de integração',
                    'Múltiplos usuários/filiais',
                    'Gestor de conta dedicado',
                    'Dashboard personalizado',
                  ],
                  isPopular: false,
                  buttonText: 'Falar com Consultor',
                  onPressed: () => _handleContact(context),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
          if (subscriptionState is AsyncLoading)
            Container(
              color: Colors.black45,
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildHero() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppTheme.primaryColor, AppTheme.primaryColor.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Column(
        children: [
          Text(
            'Escolha o plano ideal para crescer',
            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            'Economize tempo e dinheiro em cada negociação com a inteligência do CotaZap.',
            style: TextStyle(color: Colors.white70, fontSize: 14),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCard(
    BuildContext context, {
    required String title,
    required String price,
    required String description,
    required List<String> features,
    required bool isPopular,
    required String buttonText,
    Color color = Colors.grey,
    VoidCallback? onPressed,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isPopular ? AppTheme.primaryColor.withOpacity(0.3) : Colors.grey[200]!, width: isPopular ? 2 : 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          if (isPopular)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)),
              ),
              child: const Text('MAIS POPULAR', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[800])),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(price, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF1A1A1A))),
                    if (price != 'Consulte')
                      Text('/mês', style: TextStyle(fontSize: 14, color: Colors.grey[500])),
                  ],
                ),
                const SizedBox(height: 12),
                Text(description, style: TextStyle(fontSize: 13, color: Colors.grey[600])),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Divider(),
                ),
                ...features.map((f) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle_outline, size: 18, color: Colors.green),
                      const SizedBox(width: 12),
                      Expanded(child: Text(f, style: const TextStyle(fontSize: 13, color: Color(0xFF2D3436)))),
                    ],
                  ),
                )),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isPopular ? AppTheme.primaryColor : Colors.grey[50],
                      foregroundColor: isPopular ? Colors.white : AppTheme.primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), 
                        side: isPopular ? BorderSide.none : const BorderSide(color: AppTheme.primaryColor)
                      ),
                    ),
                    child: Text(buttonText, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleUpgrade(BuildContext context, WidgetRef ref, String planName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Icon(Icons.rocket_launch_outlined, size: 48, color: AppTheme.primaryColor),
            const SizedBox(height: 16),
            Text('Upgrade para $planName', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            const Text(
              'Você está prestes a turbinar seu negócio. O pagamento será processado de forma segura pelo Stripe.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  try {
                    await ref.read(subscriptionControllerProvider.notifier).upgradePlan(planName == 'Profissional' ? 'premium' : planName.toLowerCase());
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Bem-vindo ao plano $planName!')),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Erro no upgrade: $e'), backgroundColor: Colors.red),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Ir para o Pagamento', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
            ),
          ],
        ),
      ),
    );
  }

  void _handleContact(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Abrindo WhatsApp para consultoria Enterprise...')),
    );
  }
}
