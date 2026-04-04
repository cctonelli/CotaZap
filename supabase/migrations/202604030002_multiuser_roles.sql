-- v1.5: Multi-user Roles & Profiles Integration

-- 1. Create Role Enum
DO $$ BEGIN
    CREATE TYPE user_role AS ENUM ('buyer', 'supplier', 'admin');
EXCEPTION
    WHEN duplicate_object THEN null;
END $$;

-- 2. Create Profiles Table (Linked to Auth)
CREATE TABLE IF NOT EXISTS public.profiles (
  id uuid REFERENCES auth.users ON DELETE CASCADE NOT NULL PRIMARY KEY,
  full_name text,
  role user_role DEFAULT 'buyer',
  plan_type text DEFAULT 'free',
  avatar_url text,
  updated_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 3. Update Existing Tables with owner_id for Isolatation
-- Note: Some of these tables might already exist from previous migrations.

ALTER TABLE IF EXISTS public.suppliers 
ADD COLUMN IF NOT EXISTS owner_id uuid REFERENCES public.profiles(id),
ADD COLUMN IF NOT EXISTS plan_type text DEFAULT 'free',
ADD COLUMN IF NOT EXISTS product_limit int DEFAULT 15,
ADD COLUMN IF NOT EXISTS rede_cotazap_status text DEFAULT 'pending';

ALTER TABLE IF EXISTS public.products 
ADD COLUMN IF NOT EXISTS owner_id uuid REFERENCES public.profiles(id);

ALTER TABLE IF EXISTS public.quotations 
ADD COLUMN IF NOT EXISTS owner_id uuid REFERENCES public.profiles(id);

-- 4. Enable RLS (Row Level Security)
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.suppliers ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.quotations ENABLE ROW LEVEL SECURITY;

-- 5. Policies (Self-Access only)
CREATE POLICY "Users can view their own profile" ON public.profiles
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update their own profile" ON public.profiles
  FOR UPDATE USING (auth.uid() = id);

-- For Suppliers: Buyers see their private suppliers OR everyone sees Rede CotaZap suppliers
CREATE POLICY "Suppliers access policy" ON public.suppliers
  FOR ALL USING (
    auth.uid() = owner_id OR 
    is_rede_cotazap = true
  );

CREATE POLICY "Products access policy" ON public.products
  FOR ALL USING (
    auth.uid() = owner_id OR 
    is_from_rede = true
  );

CREATE POLICY "Quotations access policy" ON public.quotations
  FOR ALL USING (auth.uid() = owner_id);

-- 6. Trigger for profile creation on signup
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS trigger AS $$
BEGIN
  INSERT INTO public.profiles (id, full_name, avatar_url)
  VALUES (new.id, new.raw_user_meta_data->>'full_name', new.raw_user_meta_data->>'avatar_url');
  RETURN new;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE public.handle_new_user();
