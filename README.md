# Painel Financeiro Online com Supabase

Este projeto já vem pronto para:
- login e cadastro por e-mail/senha
- dados separados por usuário
- entradas, gastos, investimentos e metas
- comparação mensal
- gráfico visual
- publicação gratuita como site estático

## 1) Criar projeto no Supabase
1. Crie um projeto no Supabase.
2. Vá em **SQL Editor**.
3. Cole o conteúdo do arquivo `schema.sql` e execute.
4. Vá em **Authentication > Providers** e deixe **Email** ativo.
5. Em **Project Settings > API**, copie:
   - Project URL
   - anon public key

## 2) Configurar o app
Abra `index.html` e substitua estas duas linhas:

```js
const SUPABASE_URL = 'COLE_SUA_SUPABASE_URL_AQUI';
const SUPABASE_ANON_KEY = 'COLE_SUA_SUPABASE_ANON_KEY_AQUI';
```

## 3) Testar localmente
Basta abrir o `index.html` no navegador ou publicar direto.

## 4) Publicar grátis
### Opção A: Vercel
- crie uma conta
- crie um repositório com estes arquivos
- importe o repositório na Vercel
- deploy

### Opção B: Netlify
- crie uma conta
- arraste a pasta do projeto para um novo site na Netlify
- deploy

## 5) Ajustes importantes no Supabase
### URL de redirecionamento para recuperação de senha
Em **Authentication > URL Configuration**, coloque a URL do site publicado.
Exemplo:
- `https://seu-site.vercel.app`

## Observações
- Cada usuário vê só os próprios dados por causa do RLS do Supabase.
- O app usa a chave pública `anon`, não a service key.
- O salário foi modelado como 1 salário principal por mês.
- O gasto recorrente mensal gera os próximos meses automaticamente quando o usuário entra no sistema.

## Arquivos
- `index.html` → aplicação completa
- `schema.sql` → banco de dados e regras de acesso
- `README.md` → guia rápido
