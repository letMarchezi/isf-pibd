-- CRIAR VIEWS
-- Com dados dos materiais agrupados por tipos
-- tabela "material"
create or replace view material_por_tipo as
select * 
from material
group by tipo_material, id_material;
--ver views
select * from material_por_tipo

