CREATE OR REPLACE PROCEDURE InserirEndereco(
    cep_param VARCHAR(8),
    rua_param VARCHAR(100),
    bairro_param VARCHAR(50),
    cidade_param VARCHAR(50),
    estado_param VARCHAR(2),
    pais_param VARCHAR(50)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO cep_endereco (
        cep,
        rua,
        bairro,
        cidade,
        estado,
        pais
    ) VALUES (
        cep_param,
        rua_param,
        bairro_param,
        cidade_param,
        estado_param,
        pais_param
    );

    COMMIT;
END;
$$;
/*CALL InserirEndereco(
    '12345678',
    'Rua da Amostra',
    'Bairro dos Testes',
    'Cidade dos Dados',
    'AA',
    'País da Informação'
);
*/