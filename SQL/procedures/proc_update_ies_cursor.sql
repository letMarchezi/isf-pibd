CREATE OR REPLACE PROCEDURE proc_update_ies_cursor(
    p_CNPJ VARCHAR(14),
    p_column_name VARCHAR,
    p_new_value TEXT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_column_type TEXT;
    v_sql TEXT;
    v_row IES%ROWTYPE;
    v_cursor CURSOR FOR SELECT * FROM IES WHERE CNPJ = p_CNPJ;
BEGIN
    -- Check if the provided column name exists in the IES table
    SELECT data_type INTO v_column_type
    FROM information_schema.columns
    WHERE table_name = 'ies' AND column_name = p_column_name;

    IF v_column_type IS NULL THEN
        RAISE EXCEPTION 'Column % does not exist in the IES table.', p_column_name;
    END IF;

    -- Check if the provided column name is CNPJ
    IF p_column_name = 'CNPJ' THEN
        RAISE EXCEPTION 'Cannot update primary key column (CNPJ).';
    END IF;

    -- Open the cursor
    OPEN v_cursor;

    -- Fetch the row of the IES
    FETCH v_cursor INTO v_row;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'No IES record found with CNPJ %.', p_CNPJ;
    END IF;

    -- Update the specified column with the new value
    v_sql := 'UPDATE IES SET ' || p_column_name || ' = $1 WHERE CURRENT OF v_cursor';
    EXECUTE v_sql USING p_new_value;

    CLOSE v_cursor;
END;
$$;


/*CALL UpdateIESField('12345678901234', 'sigla', 'NewSiglaValue');
CALL proc_update_ies_cursor('12345678901234', 'teste', 'pppp');
CALL proc_update_ies_cursor('12345678901234', 'cnpj', 'pppp');
/*