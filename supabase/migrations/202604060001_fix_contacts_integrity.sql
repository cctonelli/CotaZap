-- Migration: Fix Contacts Integrity & Prevent Duplicates
-- v1.5.1: CotaZap

-- 1. Garante que a tabela app_contacts existe com a estrutura correta
CREATE TABLE IF NOT EXISTS public.app_contacts (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    trade_name TEXT NOT NULL,
    whatsapp TEXT NOT NULL,
    address TEXT,
    observations TEXT,
    active BOOLEAN DEFAULT TRUE,
    owner_id UUID REFERENCES public.profiles(id),
    plan_type TEXT DEFAULT 'free',
    product_limit INT DEFAULT 15,
    is_rede_cotazap BOOLEAN DEFAULT FALSE,
    priority_score INT DEFAULT 0,
    approved BOOLEAN DEFAULT TRUE,
    cnpj_cpf TEXT,
    contact_name TEXT,
    email TEXT,
    city TEXT,
    state TEXT,
    neighborhood TEXT,
    zip_code TEXT,
    complement TEXT,
    is_buyer BOOLEAN DEFAULT FALSE,
    is_supplier BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 2. LIMPEZA: Deleta duplicados (mantém apenas o registro mais recente por owner_id + email)
DELETE FROM public.app_contacts a
USING public.app_contacts b
WHERE a.id < b.id
  AND a.owner_id = b.owner_id
  AND a.email = b.email
  AND a.email IS NOT NULL;

-- 3. BLINDAGEM: Adiciona constraint de unicidade para evitar futuras duplicatas
-- Nota: Isso permite múltiplos emails nulos, mas apenas um e-mail específico por dono.
ALTER TABLE public.app_contacts 
DROP CONSTRAINT IF EXISTS unique_owner_email;

ALTER TABLE public.app_contacts 
ADD CONSTRAINT unique_owner_email UNIQUE (owner_id, email);

-- 4. RLS: Segurança de Linha
ALTER TABLE public.app_contacts ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Contacts access policy" ON public.app_contacts;
CREATE POLICY "Contacts access policy" ON public.app_contacts
  FOR ALL USING (
    auth.uid() = owner_id OR 
    is_rede_cotazap = true
  );

-- 5. Trigger para atualizar o updated_at automaticamente
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ language 'plpgsql';

DROP TRIGGER IF EXISTS update_app_contacts_updated_at ON public.app_contacts;
CREATE TRIGGER update_app_contacts_updated_at
    BEFORE UPDATE ON public.app_contacts
    FOR EACH ROW
    EXECUTE PROCEDURE update_updated_at_column();
