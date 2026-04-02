-- 202604020002_enable_rls.sql
-- Habilita o Row Level Security (RLS) para as tabelas do projeto CotaZap
-- e define políticas básicas de acesso para usuários autenticados.

-- 1. Habilitar RLS em todas as tabelas públicas
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.product_suppliers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.suppliers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.buyers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.quotations ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.quotation_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.supplier_responses ENABLE ROW LEVEL SECURITY;

-- 2. Definir Políticas de Acesso
-- Como o app é focado no Comprador e os dados são sincronizados, 
-- permitiremos acesso total para usuários autenticados por enquanto.
-- Em uma fase posterior, podemos restringir usando auth.uid() vinculando a uma coluna user_id.

-- Produtos
CREATE POLICY "Permitir tudo para usuários autenticados em products" 
ON public.products FOR ALL TO authenticated USING (true) WITH CHECK (true);

-- Fornecedores de Produtos (M:M)
CREATE POLICY "Permitir tudo para usuários autenticados em product_suppliers" 
ON public.product_suppliers FOR ALL TO authenticated USING (true) WITH CHECK (true);

-- Fornecedores
CREATE POLICY "Permitir tudo para usuários autenticados em suppliers" 
ON public.suppliers FOR ALL TO authenticated USING (true) WITH CHECK (true);

-- Compradores (Perfis)
CREATE POLICY "Permitir tudo para usuários autenticados em buyers" 
ON public.buyers FOR ALL TO authenticated USING (true) WITH CHECK (true);

-- Cotações
CREATE POLICY "Permitir tudo para usuários autenticados em quotations" 
ON public.quotations FOR ALL TO authenticated USING (true) WITH CHECK (true);

-- Itens de Cotação
CREATE POLICY "Permitir tudo para usuários autenticados em quotation_items" 
ON public.quotation_items FOR ALL TO authenticated USING (true) WITH CHECK (true);

-- Respostas de Fornecedores
CREATE POLICY "Permitir tudo para usuários autenticados em supplier_responses" 
ON public.supplier_responses FOR ALL TO authenticated USING (true) WITH CHECK (true);

-- 3. Permitir leitura anônima para tabelas que podem ser públicas (opcional)
-- Se a Rede CotaZap permitir que fornecedores vejam produtos sem login, descomentar abaixo:
-- CREATE POLICY "Permitir leitura anônima em products" ON public.products FOR SELECT TO anon USING (true);
