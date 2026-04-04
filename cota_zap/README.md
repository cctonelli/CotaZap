# ⚡ CotaZap v1.5 - Smart Procurement Ecosystem

O **CotaZap** é uma plataforma disruptiva de aquisição estratégica (*e-procurement*) que automatiza a negociação entre compradores e fornecedores via WhatsApp. O sistema utiliza algoritmos de **Scoring Inteligente** para ranquear propostas em segundos, garantindo a melhor compra baseada em múltiplos critérios.

---

## 🚀 O que há de novo na v1.5 (Multi-User)

Recentemente evoluímos para a versão **1.5**, introduzindo uma arquitetura multi-usuário escalável:

-   **🎭 Perfis de Acesso (Roles)**: 
    -   **Comprador**: Gestão de produtos, cotações e rede privada de fornecedores.
    -   **Fornecedor**: Cadastro na rede global, recebimento de demandas e gestão de respostas.
    -   **Admin**: Painel de controle para moderação de rede, categorias e unidades de medida.
-   **🔐 Segurança de Dados (RLS)**: Implementação de *Row Level Security* no Supabase, garantindo isolamento total entre usuários.
-   **🔄 Sincronização Híbrida (Drift + Supabase)**: 
    -   Persistência local (Offline-First) com **Drift (SQLite)**.
    -   Sincronização reativa em nuvem com **Supabase**.
    -   Auto-fetch de perfil na inicialização do app.
-   **📊 Dashboards Especializados**: Telas de controle personalizadas para cada tipo de usuário.

---

## 🛠️ Stack Tecnológica

-   **Frontend**: [Flutter](https://flutter.dev) (Windows/Web/Mobile)
-   **State Management**: [Riverpod 2.x](https://riverpod.dev) com Geração de Código.
-   **Persistência Local**: [Drift](https://drift.simonbinder.eu/) (SQLite de alto desempenho).
-   **Backend & Auth**: [Supabase](https://supabase.com) (Auth, PostgreSQL, RLS).
-   **Roteamento**: [GoRouter](https://pub.dev/packages/go_router) para navegação declarativa.

---

## 🏗️ Arquitetura de Software

Seguimos rigidamente os princípios da **Clean Architecture** para garantir manutenibilidade:

1.  **Presentation Tier**: Controllers reativos e UI baseada em States.
2.  **Domain Tier**: Lógica pura de negócio (Ex: `ProcurementEngine` para scoring de propostas).
3.  **Data Tier**: DAOs robustos para SQLite e Repositórios para integração com APIs externas.

---

## 💡 Funcionalidades Chave

-   **⚡ Cotações Turbo**: Envio de listas de produtos para múltiplos fornecedores via WhatsApp em um clique.
-   **🧠 Motor de Scoring (BI)**: Algoritmo ponderado (Preço 60%, Prazo Pagamento 20%, Prazo Entrega 20%).
-   **🛒 Catálogo Inteligente**: Cadastro de produtos com unidades de medida padronizadas.
-   **🌐 Rede CotaZap**: Acesso a fornecedores públicos verificados e gestão de rede privada.

---

## ⚙️ Como Executar

1.  **Instale as dependências**:
    ```bash
    flutter pub get
    ```
2.  **Gere o código (Drift/Riverpod)**:
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```
3.  **Configuração Supabase**:
    Configure suas credenciais em `lib/core/network/supabase_service.dart`.
4.  **Launch**:
    ```bash
    flutter run
    ```

---

## 📄 Licença

Este projeto é propriedade privada do ecossistema CotaZap.

---
*Desenvolvido com excelência técnica para o mercado de Procurement.*
