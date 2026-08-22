# Documentation project instructions

## About this project

- Documentação pública da notifica.dev, uma plataforma de notificações multicanal (push, email, SMS, inbox). Veja `index.mdx` para a visão geral do produto.
- Site construído em [Mintlify](https://mintlify.com). Páginas são MDX com frontmatter YAML, configuração em `docs.json`.
- A aba **API Reference** é gerada a partir de `api-reference/openapi.json`, exportado pelo backend NestJS (`bun run docs:openapi`, veja `backend/src/infra/open-api/`). Nunca editar esse arquivo à mão — mudanças em endpoints, tags ou segurança entram pelos decorators do controller (`@ApiOperation`, `@ApiTags`, `ApiKeyHeader`/`CustomerTokenHeader`) e pelo `buildOpenApiDocument`, depois regeneradas.
- Use o servidor MCP da Mintlify, `https://mcp.mintlify.com`, para editar conteúdo e configurações via MCP.
- Use o servidor MCP de docs da Mintlify, `https://www.mintlify.com/docs/mcp`, para consultar como usar a Mintlify via MCP.

## Terminologia

- **App**: o produto que dispara notificações, identificado por uma API key (`x-api-key`). Não confundir com "aplicativo" mobile.
- **Cliente** (não "usuário" ou "customer" em inglês no meio do texto): uma pessoa do sistema do app, identificada por um `code` externo.
- **Dispositivo**: uma instalação de push (`ios`/`android`), associada a um cliente ou anônima.
- **Notificação transacional** vs **campanha**: transacional mira clientes específicos; campanha mira um público via tags.
- **Canal**: email, SMS, push ou inbox — cada um com sua própria cobrança por crédito.
- Sempre "notifica.dev" em minúsculas, mesmo início de frase.

## Style preferences

- Documentação em português (pt-BR), voz ativa, segunda pessoa ("você").
- Frases curtas — uma ideia por frase.
- Sentence case em headings.
- Negrito para termos de domínio na primeira aparição de uma página (**cliente**, **dispositivo**); código para nomes de campo, headers, paths e comandos.
- Exemplos de payload em JSON cru (sem indentação de `curl` em volta), como já feito em `canais/*.mdx`.

## Content boundaries

- Documentar apenas a API pública (`@ApiPublic()` no backend) e os SDKs (server, web, mobile). Endpoints de console (billing, times, apps) não são documentados aqui.
- SDKs (`@notifica.dev/server`, `@notifica.dev/react`) ainda não publicados no npm — manter o aviso `<Note>` de preview em `sdks/*.mdx` até a publicação real, depois removê-lo.
