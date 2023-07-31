# isf-pibd

## Inicialização da base de dados localmente com o docker

- Instale o serviço do docker seguindo a documentação

  - Windows: https://docs.docker.com/desktop/install/windows-install/
  - Linux: https://docs.docker.com/desktop/install/linux-install/

- Instale o docker compose seguindo a documentação https://docs.docker.com/compose/install/

- Com os serviços instalados, no diretorio em que se encontra o arquivo `docker-compose.yml` rode o comando (caso esteja no linux rode com sudo)

  ```bash
  docker-compose up -d
  ```

- Com isso, será criado um server do postgres com a base de dados ISF-Dev na porta `5555`, e um pgadmin na porta `5050`
- O PgAdmin pode ser acessado em `localhost:5050` com o email `admin@admin.com` e senha padrão `root`
  - Quando for conectar no server, no Hostname/Addres coloque o nome do container `postgresql` e a porta utlizada no container é a default `5432`. Logue com o user `root` e senha `root`. 
  
