# dev_portafolio

Personal developer portfolio: a static page plus serverless functions, deployed on Vercel.

## Run locally

```bash
npm run dev
```

This runs `vercel dev`, which serves `index.html` and the functions in `api/`.

## Deploy

1. Import this repo at [vercel.com/new](https://vercel.com/new).
2. Keep the defaults. There is no build step.
3. Every push to the default branch deploys to production; other branches get previews.

## Working with Claude Code in the cloud

Start a session at [claude.ai/code](https://claude.ai/code) with this repo selected, or run `claude --cloud "your task"` from a clone. Project instructions live in `CLAUDE.md`.
