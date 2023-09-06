-- verifica se os ultimos caracteres do nome do arquivo dado correspondem a um pdf
CREATE OR REPLACE FUNCTION valida_pocafile(poca_filename VARCHAR(50))
RETURNS boolean AS $$
BEGIN
  RETURN lower(right(poca_filename, 4)) = '.pdf';
END;
$$ LANGUAGE plpgsql;