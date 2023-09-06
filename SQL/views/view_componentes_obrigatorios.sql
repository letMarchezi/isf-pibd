create or replace view componentes_obrigatoriedade as
select * 
from componente_curricular
group by obrigatoriedade;
--ver views
select * from componentes_obrigatoriedade