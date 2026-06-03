-- WARNING: This schema is for context only and is not meant to be run.
-- Table order and constraints may not be valid for execution.

CREATE TABLE public.app_contacts (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  trade_name text NOT NULL,
  whatsapp text,
  email text,
  cnpj_cpf text,
  contact_name text,
  address text,
  city text,
  state text,
  neighborhood text,
  zip_code text,
  complement text,
  active boolean DEFAULT true,
  is_rede_cotazap boolean DEFAULT false,
  priority_score integer DEFAULT 0,
  approved boolean DEFAULT false,
  is_buyer boolean DEFAULT false,
  is_supplier boolean DEFAULT false,
  owner_id uuid,
  created_at timestamp with time zone DEFAULT now(),
  organization_id uuid,
  updated_at timestamp with time zone DEFAULT now(),
  CONSTRAINT app_contacts_pkey PRIMARY KEY (id),
  CONSTRAINT app_contacts_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id),
  CONSTRAINT app_contacts_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES auth.users(id)
);
CREATE TABLE public.category_requests (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  requested_by uuid NOT NULL,
  category_name text NOT NULL,
  reason text,
  status text DEFAULT 'pending'::text CHECK (status = ANY (ARRAY['pending'::text, 'approved'::text, 'rejected'::text])),
  created_at timestamp with time zone DEFAULT now(),
  admin_comment text,
  CONSTRAINT category_requests_pkey PRIMARY KEY (id),
  CONSTRAINT category_requests_requested_by_fkey FOREIGN KEY (requested_by) REFERENCES auth.users(id)
);
CREATE TABLE public.organizations (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  name text NOT NULL,
  tax_id text,
  plan_type text DEFAULT 'free'::text,
  created_at timestamp with time zone DEFAULT now(),
  owner_identity uuid NOT NULL,
  CONSTRAINT organizations_pkey PRIMARY KEY (id),
  CONSTRAINT organizations_owner_identity_fkey FOREIGN KEY (owner_identity) REFERENCES auth.users(id)
);
CREATE TABLE public.product_categories (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  name text NOT NULL UNIQUE,
  description text,
  icon_name text,
  created_at timestamp with time zone NOT NULL DEFAULT timezone('utc'::text, now()),
  CONSTRAINT product_categories_pkey PRIMARY KEY (id)
);
CREATE TABLE public.product_suppliers (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  product_id bigint,
  supplier_id bigint,
  CONSTRAINT product_suppliers_pkey PRIMARY KEY (id),
  CONSTRAINT product_suppliers_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id),
  CONSTRAINT product_suppliers_app_contact_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.app_contacts(id)
);
CREATE TABLE public.products (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  sku text,
  description text NOT NULL,
  unit_measure text NOT NULL,
  packaging_type text NOT NULL,
  attributes_json jsonb,
  created_at timestamp with time zone NOT NULL DEFAULT timezone('utc'::text, now()),
  category_id bigint,
  owner_id uuid,
  is_from_rede boolean DEFAULT false,
  organization_id uuid,
  CONSTRAINT products_pkey PRIMARY KEY (id),
  CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.product_categories(id),
  CONSTRAINT products_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id),
  CONSTRAINT products_owner_id_fkey FOREIGN KEY (owner_id) REFERENCES auth.users(id)
);
CREATE TABLE public.profiles (
  id uuid NOT NULL,
  full_name text,
  avatar_url text,
  role text DEFAULT 'buyer'::text CHECK (role = ANY (ARRAY['buyer'::text, 'supplier'::text, 'admin'::text])),
  plan_type text DEFAULT 'free'::text,
  updated_at timestamp with time zone NOT NULL DEFAULT timezone('utc'::text, now()),
  quota_messages_daily integer DEFAULT 10,
  quota_quotations_daily integer DEFAULT 2,
  whatsapp text,
  organization_id uuid,
  CONSTRAINT profiles_pkey PRIMARY KEY (id),
  CONSTRAINT profiles_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id),
  CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id)
);
CREATE TABLE public.quotation_items (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  quotation_id bigint,
  product_id bigint,
  quantity numeric NOT NULL,
  requested_price numeric,
  delivery_type text,
  desired_lead_time integer,
  created_at timestamp with time zone NOT NULL DEFAULT timezone('utc'::text, now()),
  desired_payment_term_days integer,
  desired_payment_condition text,
  CONSTRAINT quotation_items_pkey PRIMARY KEY (id),
  CONSTRAINT quotation_items_quotation_id_fkey FOREIGN KEY (quotation_id) REFERENCES public.quotations(id),
  CONSTRAINT quotation_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id)
);
CREATE TABLE public.quotations (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  status text DEFAULT 'pending'::text,
  template_message text,
  created_at timestamp with time zone NOT NULL DEFAULT timezone('utc'::text, now()),
  buyer_id uuid NOT NULL,
  winner_supplier_id bigint,
  organization_id uuid,
  CONSTRAINT quotations_pkey PRIMARY KEY (id),
  CONSTRAINT quotations_winner_supplier_id_fkey FOREIGN KEY (winner_supplier_id) REFERENCES public.app_contacts(id),
  CONSTRAINT quotations_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id),
  CONSTRAINT quotations_buyer_uuid_fkey FOREIGN KEY (buyer_id) REFERENCES public.profiles(id)
);
CREATE TABLE public.supplier_categories (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  supplier_id bigint,
  category_id bigint,
  created_at timestamp with time zone NOT NULL DEFAULT timezone('utc'::text, now()),
  CONSTRAINT supplier_categories_pkey PRIMARY KEY (id),
  CONSTRAINT supplier_categories_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.product_categories(id),
  CONSTRAINT supplier_categories_app_contact_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.app_contacts(id)
);
CREATE TABLE public.supplier_interactions (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  buyer_owner_id uuid NOT NULL,
  supplier_id bigint NOT NULL,
  rating integer DEFAULT 0 CHECK (rating >= 0 AND rating <= 5),
  comment text,
  is_favorite boolean DEFAULT false,
  updated_at timestamp with time zone NOT NULL DEFAULT timezone('utc'::text, now()),
  CONSTRAINT supplier_interactions_pkey PRIMARY KEY (id),
  CONSTRAINT supplier_interactions_app_contact_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.app_contacts(id),
  CONSTRAINT supplier_interactions_buyer_owner_id_fkey FOREIGN KEY (buyer_owner_id) REFERENCES auth.users(id)
);
CREATE TABLE public.supplier_responses (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  item_quotation_id bigint,
  supplier_id bigint,
  message_received text,
  price_extracted numeric,
  response_date timestamp with time zone NOT NULL DEFAULT timezone('utc'::text, now()),
  status text DEFAULT 'received'::text,
  created_at timestamp with time zone NOT NULL DEFAULT timezone('utc'::text, now()),
  payment_term_days integer,
  payment_condition text,
  calculated_score numeric,
  CONSTRAINT supplier_responses_pkey PRIMARY KEY (id),
  CONSTRAINT supplier_responses_item_quotation_id_fkey FOREIGN KEY (item_quotation_id) REFERENCES public.quotation_items(id),
  CONSTRAINT supplier_responses_app_contact_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.app_contacts(id)
);
CREATE TABLE public.units_of_measure (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  code text NOT NULL UNIQUE,
  name text NOT NULL,
  description text,
  category text,
  is_active boolean DEFAULT true,
  created_at timestamp with time zone DEFAULT now(),
  CONSTRAINT units_of_measure_pkey PRIMARY KEY (id)
);
CREATE TABLE public.usage_quotas (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  owner_id uuid NOT NULL,
  date date NOT NULL DEFAULT CURRENT_DATE,
  messages_sent_today integer DEFAULT 0,
  quotations_count_today integer DEFAULT 0,
  last_reset timestamp with time zone DEFAULT now(),
  organization_id uuid,
  CONSTRAINT usage_quotas_pkey PRIMARY KEY (id),
  CONSTRAINT usage_quotas_organization_id_fkey FOREIGN KEY (organization_id) REFERENCES public.organizations(id),
  CONSTRAINT usage_quotas_user_id_fkey FOREIGN KEY (owner_id) REFERENCES auth.users(id)
);