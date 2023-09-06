-- ITVF para filtrar a view de docentes para apenas dados de contato-- Correção de erros na função
create or replace function DadosViewDocentes()
returns table (
    primeiro_nome varchar,
    sobrenome varchar,
    link_cnpq VARCHAR
)
as $$
begin 
    return query
        select 
            primeiro_nome,
            sobrenome,
            link_cnpq
        from docente_especialista;
end;
$$ language plpgsql;

SELECT * FROM public.DadosViewDocentes();

