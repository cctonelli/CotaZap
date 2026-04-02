# ⚡ CotaZap - Procurement Inteligente via WhatsApp

<p align="center">
  <img src="cota_zap/assets/images/logo.png" alt="CotaZap Logo" width="200"/>
</p>

O **CotaZap** é uma plataforma inovadora de procurement projetada para simplificar e acelerar o processo de cotação de produtos entre compradores e fornecedores utilizando o WhatsApp como canal principal. Diferente de simples enviadores de mensagens, o CotaZap oferece inteligência de dados, análise de preços e uma experiência de usuário focada em produtividade.

---

## 🌟 Diferenciais de Mercado (v1.4)

*   **Fluxo 3-Toques**: Crie e envie cotações para múltiplos fornecedores em segundos.
*   **Inteligência de Procurement**: Algoritmo que analisa Preço, Prazo de Entrega e Condições de Pagamento para sugerir o "Vencedor".
*   **Offline-First**: Banco de dados local (Drift) que permite trabalhar sem internet, sincronizando com o Supabase quando online.
*   **Multi-Perfil**: Um único usuário pode atuar como Comprador ou Fornecedor de forma fluida.
*   **Parser Automático**: Backend com FastAPI que extrai preços e prazos de mensagens humanas no WhatsApp.

---

## 🛠️ Stack Tecnológica

### Frontend (Mobile & Web)
- **Flutter**: Framework para UI nativa em Android, iOS e Web.
- **Riverpod**: Gerenciamento de estado reativo e robusto.
- **Drift**: Banco de dados relacional offline (SQLite).
- **GoRouter**: Navegação declarativa e profunda.

### Backend & Infraestrutura
- **FastAPI (Python)**: Engine de processamento de mensagens e webhooks.
- **Supabase**: Banco de dados online, Autenticação e Armazenamento.
- **Evolution API**: Integração profissional com a API oficial/não-oficial do WhatsApp.

---

## 📂 Estrutura do Projeto

```bash
CotaZap/
├── cota_zap/           # Aplicativo Flutter (Frontend)
│   ├── lib/            # Código fonte Dart
│   └── assets/         # Imagens, Ícones e Logo
├── backend/            # API FastAPI (Python)
│   ├── app/            # Lógica de processamento e webhooks
│   └── requirements.txt
├── supabase/           # Migrations e configurações do banco online
└── docker-compose.yml  # Orquestração para ambiente local
```

---

## 🚀 Como Executar

### 1. Requisitos Prévios
- Flutter SDK (v3.16+)
- Python 3.10+
- Acesso a um projeto Supabase

### 2. Frontend (Flutter)
```bash
cd cota_zap
flutter pub get
flutter run -d chrome  # Para Web
# ou
flutter run            # Para Mobile
```

### 3. Backend (FastAPI)
```bash
cd backend
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload
```

---

## 📈 Roadmap & Funcionalidades

- [x] Onboarding com escolha de perfil (Comprador/Fornecedor)
- [x] Menu Lateral (Side Drawer) dinâmico
- [x] Sincronização básica com Supabase
- [x] Engine de análise de preços (Procurement Engine)
- [ ] Módulo de Pagamento In-App (Freemium)
- [ ] Dashboard avançado de BI (Economia Total)
- [ ] Integração com Catálogo de Produtos da Rede CotaZap

---

## 🤝 Contribuição

O CotaZap é um projeto focado na produtividade do comprador brasileiro. Sinta-se à vontade para abrir Issues ou enviar Pull Requests.

---

## 📄 Licença

Distribuído sob a licença MIT. Veja `LICENSE` para mais informações.

---
<p align="center">
  Desenvolvido por <strong>CotaZap Team - 2026</strong>
</p>
