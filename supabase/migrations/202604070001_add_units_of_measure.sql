-- 202604070001_add_units_of_measure.sql

CREATE TABLE IF NOT EXISTS units_of_measure (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    code TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL,
    description TEXT,
    category TEXT, -- weight, count, volume, etc.
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Enable RLS
ALTER TABLE units_of_measure ENABLE ROW LEVEL SECURITY;

-- Allow read for everyone
CREATE POLICY "Allow public read for units_of_measure" ON units_of_measure 
FOR SELECT USING (true);

-- Insert common units
INSERT INTO units_of_measure (code, name, category) VALUES 
('un', 'Unidade', 'count'),
('kg', 'Quilograma', 'weight'),
('g', 'Grama', 'weight'),
('l', 'Litro', 'volume'),
('ml', 'Mililitro', 'volume'),
('m', 'Metro', 'length'),
('cm', 'Centímetro', 'length'),
('mm', 'Milímetro', 'length'),
('cx', 'Caixa', 'count'),
('pc', 'Peça', 'count'),
('jg', 'Jogo', 'count'),
('kt', 'Kit', 'count'),
('par', 'Par', 'count'),
('dz', 'Dúzia', 'count'),
('ton', 'Tonelada', 'weight');
