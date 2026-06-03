-- Migration para dar suporte à Missão 5 (Multi-Usuários e Gestão Centralizada)
-- Adiciona a estrutura de Organizações (Empresas) sem quebrar o uso atual do owner_id.

-- 1. Cria a tabela de Organizações (Empresas)
CREATE TABLE public.organizations (
    id uuid NOT NULL DEFAULT gen_random_uuid(),
    name text NOT NULL,
    tax_id text, -- CNPJ ou CPF
    plan_type text DEFAULT 'free'::text,
    created_at timestamp with time zone DEFAULT now(),
    owner_identity uuid NOT NULL REFERENCES auth.users(id),
    CONSTRAINT organizations_pkey PRIMARY KEY (id)
);

-- 2. Atualiza a tabela profiles vinculando o usuário a uma empresa
ALTER TABLE public.profiles
ADD COLUMN organization_id uuid REFERENCES public.organizations(id);

-- 3. Prepara as tabelas de negócio para receberem o conceito de Organização
-- Na transição futura no Flutter, as queries passarão a filtrar por organization_id em vez de owner_id sozinho
ALTER TABLE public.app_contacts ADD COLUMN organization_id uuid REFERENCES public.organizations(id);
ALTER TABLE public.products ADD COLUMN organization_id uuid REFERENCES public.organizations(id);
ALTER TABLE public.quotations ADD COLUMN organization_id uuid REFERENCES public.organizations(id);
ALTER TABLE public.usage_quotas ADD COLUMN organization_id uuid REFERENCES public.organizations(id);

-- 4. Exemplo de Nova Política RLS Segura (Preparação)
-- Compradores da mesma empresa poderão enxergar cotações uns dos outros
ALTER TABLE public.organizations ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Usuários veem suas próprias organizações" ON public.organizations
    FOR SELECT USING (
        id IN (
            SELECT organization_id FROM public.profiles 
            WHERE id = auth.uid()
        )
        OR owner_identity = auth.uid()
    );
