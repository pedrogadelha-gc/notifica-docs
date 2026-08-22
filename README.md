# notifica.dev docs

Documentação pública da notifica.dev, publicada em [Mintlify](https://mintlify.com). Cobre o guia de integração (canais, SDKs) e a referência da API, gerada a partir do OpenAPI exportado pelo backend (`bun run docs:openapi` em `backend/`, veja `backend/scripts/export-openapi.ts`).

## Estrutura

- `docs.json` — navegação, tema, cores e configuração do site.
- `index.mdx`, `quickstart.mdx` — visão geral e primeiro fluxo de integração.
- `canais/` — um guia por canal (email, SMS, push, inbox) e a visão geral multicanal.
- `sdks/` — integração via servidor, web e mobile.
- `api-reference/openapi.json` — spec pública, gerada a partir dos controllers marcados `@ApiPublic()` no backend. Não editar à mão: rode `bun run docs:openapi` no backend depois de mudar um endpoint público.

## Desenvolvimento

Instale a [Mintlify CLI](https://www.npmjs.com/package/mint):

```
npm i -g mint
```

Rode a partir desta pasta, onde está o `docs.json`:

```
mint dev
```

Preview local em `http://localhost:3000`.

## Publicação

O GitHub app da Mintlify propaga mudanças do repo pro deploy. Push na branch default publica em produção automaticamente.
