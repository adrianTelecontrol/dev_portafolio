# dev_portafolio

Personal developer portfolio, deployed on Vercel.

## Layout
- `index.html`: the site (single static page, no build step)
- `api/*.js`: Vercel serverless functions, each served at `/api/<name>`
- `vercel.json`: Vercel config (keep minimal)

## Commands
- `npm run dev`: run locally with `vercel dev` (needs a Vercel login, so not available in cloud sessions)
- No build step and no tests yet. When adding either, document the command here.

## Conventions
- Keep it dependency-free until a feature needs a dependency.
- Serverless functions use CommonJS (`module.exports`) and return JSON.
- Never commit secrets. Configure them as Vercel environment variables, and list names only in `.env.example`.
- Pages must work at phone width and in light and dark mode.

## Deploy
Pushes to the default branch deploy to production once the repo is imported in the Vercel dashboard. Other branches and PRs get preview deployments.
