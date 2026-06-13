# Julia ML Tutorial

A self-contained course in idiomatic Julia and competitive ML, built around a
single reading-style book (`julia_ml_book.html`).

## What's here
- `julia_ml_book.html` — the book. Deployed, this is the bare URL.
- `exams/` — Pluto exam notebooks, one per module.
- `lessons/` — long-form lesson notes, plus the book changelog and feedback log.
- `notebooks/` — **your** working Pluto notebooks. Push these so they can be graded.
- `Dockerfile` — Railway deploy: serves the book at the root URL, auto-redeploys on push.

## Deploy (one time)
Railway → New Project → Deploy from GitHub repo → pick this repo. It builds the
Dockerfile and serves the book. Every push redeploys, so the link is always current.

## Feedback
Add requests to `lessons/BOOK_FEEDBACK.md` — the daily run treats them as top priority.
