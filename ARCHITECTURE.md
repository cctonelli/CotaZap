# 🧠 Arquitetura CotaZap: Neural Memory & Escalabilidade

Este documento descreve a infraestrutura técnica e os princípios de design que permitem ao CotaZap escalar de uma ferramenta local para uma plataforma global de suprimentos, mantendo a integridade e a inteligência dos dados.

---

## 1. Visão Geral do Ecossistema
O CotaZap opera em uma arquitetura de **Três Camadas de Memória**, inspirada em sistemas neurais:

*   **Camada 1: Memória de Curto Prazo (Local - Drift)**
    *   Foco em performance e resiliência offline.
    *   Utiliza o banco de dados Drift (SQLite) para garantir que o comprador nunca perca dados por instabilidade de rede.
*   **Camada 2: Memória de Longo Prazo (Nuvem - Supabase)**
    *   Foco em persistência global e sincronismo multidevice.
    *   Gerencia o isolamento de dados via **Row Level Security (RLS)** através do `owner_id`.
*   **Camada 3: Memória Neural (Insights - pgvector/Future)**
    *   Foco em inteligência preditiva.
    *   Analisa padrões de fornecedores, variações de preço e comportamentos de mercado.

---

## 2. Estrutura de Dados e Segurança (Multitenancy)
A escalabilidade é garantida pelo isolamento total entre compradores:

### Row Level Security (RLS)
Todas as tabelas críticas (`products`, `app_contacts`, `quotations`) implementam políticas de RLS baseadas em:
1.  **Isolamento**: `owner_id = auth.uid()` garante que nenhum comprador acesse dados de outro.
2.  **Hibridismo**: Atributos como `is_from_rede` ou `is_rede_cotazap` permitem que dados públicos/curados pela rede sejam acessados sem violar a privacidade do usuário.

### Vínculos de Produtos-Fornecedores
Implementamos uma tabela de junção `product_suppliers` que permite mapear relacionamentos N:N, essencial para a escalabilidade do catálogo de compras.

---

## 3. Resiliência Offline-First (Windows & Web)
O CotaZap v1.5+ introduz o conceito de **Sincronismo Resiliente**:
*   **Timeouts Controlados**: Requisições ao Supabase possuem timeout de 15s para evitar travamentos em redes instáveis (ex: erro de semáforo do Windows).
*   **Silent Upsert**: O salvamento local (Drift) é prioritário. Se o sincronismo remoto falhar, o sistema marca o registro para sincronização posterior (is_synced = false).

---

## 4. Integração de Mensageria (Evolution API)
A comunicação externa é delegada a um backend especializado (FastAPI + Evolution API):
*   **Backend Stateless**: O backend Python não armazena dados de cotação; ele atua como um gateway de alta performance para o WhatsApp.
*   **Webhook Resilience**: Respostas dos fornecedores via WhatsApp são processadas e injetadas no Supabase, disparando notificações em tempo real para o app Flutter via Realtime.

---

## 5. Princípios de Desenvolvimento para Escalabilidade
Para adicionar novas funcionalidades, deve-se seguir o padrão **Feature-First**:
1.  **Domain**: Definir o modelo e o contrato do repositório.
2.  **Data**: Implementar o DAO (Drift) e o Service (Supabase).
3.  **Presentation**: Utilizar Riverpod para gestão de estado reativa.

---

## 6. Roadmap de Inteligência (Neural Memory)
*   [ ] **Fase 1**: Implementação de `pgvector` para busca semântica de produtos.
*   [ ] **Fase 2**: Sugestão automática de fornecedores baseada em cotações anteriores de sucesso.
*   [ ] **Fase 3**: Dashboard de Score Composto (Preço x Prazo x Confiança) usando IA Generativa.

---
*Atualizado em: 24 de Abril de 2026*
