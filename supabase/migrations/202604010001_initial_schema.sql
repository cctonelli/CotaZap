-- initial_schema.sql

-- Buyers / Comprador
CREATE TABLE buyers (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name TEXT NOT NULL,
    company TEXT NOT NULL,
    whatsapp TEXT NOT NULL,
    email TEXT,
    role TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Suppliers / Fornecedor
CREATE TABLE suppliers (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    trade_name TEXT NOT NULL,
    whatsapp TEXT NOT NULL,
    address TEXT,
    observations TEXT,
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Products / Produto
CREATE TABLE products (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    sku TEXT,
    description TEXT NOT NULL,
    unit_measure TEXT NOT NULL,
    packaging_type TEXT NOT NULL,
    attributes JSONB,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- ProductSuppliers (Many-to-Many)
CREATE TABLE product_suppliers (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    product_id BIGINT REFERENCES products(id) ON DELETE CASCADE,
    supplier_id BIGINT REFERENCES suppliers(id) ON DELETE CASCADE,
    UNIQUE(product_id, supplier_id)
);

-- Quotations / Cotação
CREATE TABLE quotations (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    buyer_id BIGINT REFERENCES buyers(id) ON DELETE CASCADE,
    status TEXT DEFAULT 'pending',
    template_message TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- QuotationItems / Item Cotação
CREATE TABLE quotation_items (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    quotation_id BIGINT REFERENCES quotations(id) ON DELETE CASCADE,
    product_id BIGINT REFERENCES products(id) ON DELETE SET NULL,
    quantity NUMERIC NOT NULL,
    requested_price NUMERIC,
    delivery_type TEXT,
    desired_lead_time INT,
    payment_term_days INT, -- prazo_pagamento_dias (0 = à vista) 
    payment_condition TEXT, -- condicao_pagamento
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- SupplierResponses / Resposta Fornecedor
CREATE TABLE supplier_responses (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    quotation_item_id BIGINT REFERENCES quotation_items(id) ON DELETE CASCADE,
    supplier_id BIGINT REFERENCES suppliers(id) ON DELETE CASCADE,
    message_received TEXT,
    price_extracted NUMERIC,
    payment_term_days INT,
    payment_condition TEXT,
    early_discount_percent NUMERIC,
    response_date TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    status TEXT DEFAULT 'received',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);
