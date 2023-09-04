CREATE OR REPLACE FUNCTION ValidarCNPJ(cnpj_param VARCHAR(14))
RETURNS BOOLEAN AS $$
BEGIN
    -- Verifica se o CNPJ tem 14 dígitos numéricos
    RETURN cnpj_param ~ '^[0-9]{14}$';
END;
$$ LANGUAGE plpgsql;