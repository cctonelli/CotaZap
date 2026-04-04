# ⚡ CotaZap - Modern Procurement Platform

CotaZap é uma plataforma inteligente de aquisição (procurement) projetada para modernizar a interação entre compradores e fornecedores via WhatsApp. Focada em agilidade, análise de dados e scoring inteligente de propostas.

## 🚀 Funcionalidades Principais

*   **Cotações Reativas**: Envio de listas de produtos para múltiplos fornecedores com um clique.
*   **Scoring Inteligente (BI)**: Motor de avaliação que ranqueia fornecedores com base em:
    *   Preço (Peso 60%)
    *   Prazo de Pagamento (Peso 20%)
    *   Prazo de Entrega (Peso 20%)
*   **Gestão de Cadastros**: Cadastro de parceiros, produtos e vínculos privados para cada comprador.
*   **Integração com WhatsApp**: Placeholder para Evolution API visando automação de mensagens.
*   **Arquitetura Limpa**: Implementado com Flutter + Riverpod + Drift (Local DB) + Supabase (Sincronização).

## 🏗️ Arquitetura

O projeto segue os princípios da **Clean Architecture**:

*   **Presentation**: Widgets reativos (Riverpod ConsumerWidget) e Controllers (Notifiers).
*   **Domain**: Entidades de negócio e serviços puramente lógicos (ex: `ProcurementEngine`).
*   **Data**: Persistência local robusta com Drift e integração remota com Supabase.

## 🛠️ Tecnologias Utilizadas

*   **Framework**: [Flutter](https://flutter.dev)
*   **State Management**: [Riverpod](https://riverpod.dev)
*   **Database**: [Drift](https://drift.simonbinder.eu/) (SQLite for Flutter)
*   **Backend**: [Supabase](https://supabase.com)
*   **Routing**: [GoRouter](https://pub.dev/packages/go_router)

## 📦 Como Executar

1.  Clone o repositório:
    ```bash
    git clone https://github.com/usuario/CotaZap.git
    ```
2.  Instale as dependências:
    ```bash
    flutter pub get
    ```
3.  Gere os arquivos do banco de dados (Drift):
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```
4.  Execute o projeto:
    ```bash
    flutter run
    ```

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para detalhes.

---
Desenvolvido com ❤️ pela equipe CotaZap.
