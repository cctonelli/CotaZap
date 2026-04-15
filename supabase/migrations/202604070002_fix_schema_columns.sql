-- 202604070002_fix_schema_columns.sql

-- For Suppliers (app_contacts / suppliers)
ALTER TABLE IF EXISTS public.suppliers 
ADD COLUMN IF NOT EXISTS is_rede_cotazap BOOLEAN DEFAULT FALSE;

-- For Products
-- Renomeia atributos para bater com o código se necessário, mas vamos garantir is_from_rede
ALTER TABLE IF EXISTS public.products 
ADD COLUMN IF NOT EXISTS is_from_rede BOOLEAN DEFAULT FALSE;

-- Se o código está usando attributes_json, vamos renomear ou adicionar a coluna
ALTER TABLE IF EXISTS public.products 
RENAME COLUMN attributes TO attributes_json;

-- Garante que o owner_id seja UUID
-- (Já foi feito na 202604030002, mas vamos garantir as permissões)

-- Atualiza RLS policies se necessário
DROP POLICY IF EXISTS "Products access policy" ON public.products;
CREATE POLICY "Products access policy" ON public.products
  FOR ALL USING (
    auth.uid() = owner_id OR 
    is_from_rede = true
  );

DROP POLICY IF EXISTS "Suppliers access policy" ON public.suppliers;
CREATE POLICY "Suppliers access policy" ON public.suppliers
  FOR ALL USING (
    auth.uid() = owner_id OR 
    is_rede_cotazap = true
  );

-- v1.5: Tabela de Usage Quotas (Cotas de Uso)
CREATE TABLE IF NOT EXISTS public.usage_quotas (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    owner_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    quota_type TEXT NOT NULL,
    used_count INT DEFAULT 0,
    limit_count INT NOT NULL,
    last_reset_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    UNIQUE(owner_id, quota_type)
);

-- RLS para Usage Quotas
ALTER TABLE public.usage_quotas ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view their own usage quotas" ON public.usage_quotas
  FOR SELECT USING (auth.uid() = owner_id);

CREATE POLICY "Users can update their own usage quotas" ON public.usage_quotas
  FOR UPDATE USING (auth.uid() = owner_id);

CREATE POLICY "Users can insert their own usage quotas" ON public.usage_quotas
  FOR INSERT WITH CHECK (auth.uid() = owner_id);
