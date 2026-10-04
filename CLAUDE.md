# dev_portafolio

Personal developer portfolio, deployed on Vercel.

## Layout
- `index.html`: the site (single static page, no build step)
- `api/*.js`: Vercel serverless functions, each served at `/api/<name>`
- `vercel.json`: Vercel config (keep minimal)
- `docs/projects.md`: project inventory used as source for the site content. Work projects are confidential: keep architecture/technique level, no code or private links

## Commands
- `npm run dev`: run locally with `vercel dev` (needs a Vercel login, so not available in cloud sessions)
- No build step (deliberate, see Conventions) and no tests yet. When adding tests, document the command here.

## Conventions
- Design quality comes first: add dependencies (design systems, fonts, animation or UI libraries) when they make the site look or feel better, e.g. when the `design-taste-frontend` skill recommends an official package. Prefer a lightweight option when two give the same result.
- No build step, so Vercel serves the repo as-is with zero config. Load front-end dependencies from a CDN (jsDelivr, unpkg, cdnjs, Google Fonts) with an exact pinned version, e.g. `https://cdn.jsdelivr.net/npm/pkg@1.2.3/...`; for ES modules, use an `<script type="importmap">` in `index.html`. Pick the package's prebuilt CSS / web-components / ESM bundle, not a React-only build.
- Don't add a bundler (Vite etc.) or front-end packages to `package.json` unless a dependency truly can't work from a CDN; if that happens, ask first, since it changes the Vercel build settings.
- npm packages in `package.json` are only for `api/` serverless functions.
- Serverless functions use CommonJS (`module.exports`) and return JSON.
- Never commit secrets. Configure them as Vercel environment variables, and list names only in `.env.example`.
- Pages must work at phone width and in light and dark mode.

## Deploy
Pushes to the default branch deploy to production once the repo is imported in the Vercel dashboard. Other branches and PRs get preview deployments.
