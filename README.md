# ⚡ CotaZap - Elite Procurement & WhatsApp Automation

<p align="center">
  <img src="cota_zap/assets/images/logo.png" alt="CotaZap Logo" width="220"/>
</p>

O **CotaZap** transcende o conceito de um simples app de cotação. Ele é uma plataforma de **Inteligência de Suprimentos** desenhada para aniquilar a ineficiência no processo de compras via WhatsApp. Transformamos conversas informais em workflows estruturados e decisões baseadas em dados.

---

## 🚀 O Estado da Arte (v1.5)

Atualmente, o CotaZap já opera com um ecossistema robusto que integra o melhor do desenvolvimento mobile e automação de mensageria:

### 💎 Funcionalidades de Core (Desenvolvidas)
*   **🔑 Arquitetura Multi-User (Roles)**: Sistema baseado em papéis — **Comprador**, **Fornecedor** e **Admin** — com fluxos de interface e segurança totalmente distintos.
*   **📡 Automação WhatsApp (Evolution API v2)**: Disparos inteligentes de cotações diretamente para fornecedores, simulando comportamento humano para máxima taxa de entrega.
*   **☁️ Sincronização Híbrida (Drift + Supabase)**: Experiência *Offline-First* com banco local SQLite (Drift) e sincronização em tempo real na nuvem via Supabase.
*   **📊 Dashboard Estratégico**: Visão panorâmica de cotações em andamento, economias geradas e performance de fornecedores.
*   **🛒 Gestão de Itens e Unidades**: Sistema flexível de cadastro de produtos com conversão inteligente de unidades de medida.
*   **🤖 Backend Orquestrador (FastAPI)**: Microatendimento especializado em gerenciar o tráfego pesado de notificações e webhooks.
*   **🐳 Infraestrutura Dockerizada**: Deploy simplificado de todo o ecossistema (Evolution API, Postgres, Backend) com um único comando.

---

## 🛠️ Stack Tecnológica

| Camada | Tecnologia | Propósito |
| :--- | :--- | :--- |
| **Mobile** | Flutter (Dart) | UI Premium e Performance Multiplataforma |
| **Local DB** | Drift (SQLite) | Persistência ultra-rápida e offline |
| **Cloud/Auth** | Supabase | Gestão de Usuários e Sincronização |
| **Mensageria** | Evolution API v2 | Motor de WhatsApp de última geração |
| **Backend** | FastAPI (Python) | Gateway de integração e processamento pesado |
| **Infra** | Docker & Compose | Orquestração de containers |

---

## 🎯 AS MISSÕES: Rumo ao Topo do Mercado

Para transformar o CotaZap na ferramenta **Nº 1** global, estabelecemos as seguintes missões de elite:

### 🟢 MISSÃO 1: Inteligência Artificial Cognitiva (AI-OCR)
**Objetivo**: Eliminar o registro manual.
- Implementação de IA capaz de ler tabelas de preços em fotos (JPG) ou arquivos PDF enviados por fornecedores e alimentar automaticamente o sistema de comparação.

### 🔵 MISSÃO 2: Marketplace "Rede CotaZap"
**Objetivo**: Expansão de rede.
- Criar um diretório inteligente onde compradores podem "descobrir" novos fornecedores baseados em geolocalização e reputação dentro da plataforma.

### 🟡 MISSÃO 3: Analytics de Mercado e Tendências
**Objetivo**: Prever o futuro das compras.
- Gráficos comparativos de variação de preços de commodities e sugestão inteligente de "Momento de Compra" (Stock Predictor).

### 🔴 MISSÃO 4: Workflow de Pagamento Integrado
**Objetivo**: Fechar o ciclo.
- Integração de Gateway de Pagamento (Pix/Boleto) diretamente na confirmação do pedido, permitindo que o ciclo de compra seja 100% digital e seguro.

---

## ⚙️ Configuração Rápida (Ambiente Elite)

1. **Infraestrutura**:
   ```bash
   docker-compose up -d
   ```
2. **Backend**:
   Certifique-se que o `.env` no `backend/` está configurado com suas chaves Supabase.
3. **App**:
   ```bash
   cd cota_zap
   flutter run
   ```

---

## 🤝 O Compromisso CotaZap
Nossa missão é dar ao comprador o **superpoder** de negociar com 100 fornecedores com o esforço de quem fala com apenas um. Se é eficiente, está no CotaZap.

---
<p align="center">
  <strong>CotaZap Team - 2026</strong><br>
  <em>Construindo o futuro do Procurement.</em>
</p>
