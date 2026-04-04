-- 202604030001_add_categories.sql
-- Estudo para implementação de Categorias de Produtos/Serviços

-- 1. Tabela de Categorias
CREATE TABLE product_categories (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name TEXT NOT NULL UNIQUE,
    description TEXT,
    icon_name TEXT, -- Nome do ícone (ex: 'inventory', 'shopping_basket')
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 2. Vincular Produtos a uma Categoria
-- Se uma categoria for deletada, o produto fica 'sem categoria' (SET NULL)
ALTER TABLE products ADD COLUMN category_id BIGINT REFERENCES product_categories(id) ON DELETE SET NULL;

-- 3. Vincular Fornecedores às Categorias que eles atendem
-- Um fornecedor pode atender múltiplas categorias (Relacionamento N-N)
CREATE TABLE supplier_categories (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    supplier_id BIGINT REFERENCES suppliers(id) ON DELETE CASCADE,
    category_id BIGINT REFERENCES product_categories(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    UNIQUE(supplier_id, category_id)
);

-- Inserir algumas categorias padrão para teste
INSERT INTO product_categories (name, icon_name) VALUES 
('Mecânica', 'settings_input_component'),
('Elétrica', 'bolt'),
('Funilaria', 'format_paint'),
('Pneus', 'tire_repair'),
('Lubrificantes', 'water_drop'),
('Diversos', 'category');
