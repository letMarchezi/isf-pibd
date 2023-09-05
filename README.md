# isf-pibd

## Inicialização da base de dados localmente com o docker

  ```bash
  docker build -t isf-pibd .
  docker run -dp 127.0.0.1:5555:5432 isf-pibd
  ```
- Com isso, será criado um server do postgres com a base de dados Isf que pode ser acessado na `5555`
- A senha para o server é `docker` e o usuário é postgres
  
