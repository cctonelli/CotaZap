-- 1. LIMPEZA E UNIFICAÇÃO DE POLÍTICAS: app_contacts
-- Removemos políticas redundantes ou abertas demais para garantir isolamento total

DROP POLICY IF EXISTS "Contacts access policy" ON public.app_contacts;
DROP POLICY IF EXISTS "Usuários veem seus próprios contatos ou contatos da Rede" ON public.app_contacts;
DROP POLICY IF EXISTS "Leitura: Ver próprios contatos ou Rede CotaZap" ON public.app_contacts;

-- Criamos a política mestre de LEITURA para contatos
CREATE POLICY "app_contacts_select_policy" ON public.app_contacts
FOR SELECT TO authenticated
USING (
  owner_id = auth.uid() OR 
  is_rede_cotazap = true
);

-- 2. CORREÇÃO DE SEGURANÇA: product_suppliers
-- Esta tabela ligava produtos a fornecedores e estava aberta (true), vazando dados

DROP POLICY IF EXISTS "Permitir tudo para usuários autenticados em product_suppliers" ON public.product_suppliers;
DROP POLICY IF EXISTS "Vínculos: Usuários gerenciam seus próprios vínculos" ON public.product_suppliers;

-- Criamos a política mestre para vínculos (Baseada no dono do PRODUTO)
CREATE POLICY "product_suppliers_isolation_policy" ON public.product_suppliers
FOR ALL TO authenticated
USING (
  EXISTS (
    SELECT 1 FROM public.products p
    WHERE p.id = product_suppliers.product_id
    AND p.owner_id = auth.uid()
  )
);

-- 3. GARANTIA: products
-- Reforçamos que produtos só são vistos pelo dono ou se forem da rede oficial

DROP POLICY IF EXISTS "Buyers see network products" ON public.products;
DROP POLICY IF EXISTS "Users can manage their own products" ON public.products;

CREATE POLICY "products_select_policy" ON public.products
FOR SELECT TO authenticated
USING (
  owner_id = auth.uid() OR 
  is_from_rede = true
);

CREATE POLICY "products_all_policy" ON public.products
FOR ALL TO authenticated
USING (owner_id = auth.uid())
WITH CHECK (owner_id = auth.uid());
