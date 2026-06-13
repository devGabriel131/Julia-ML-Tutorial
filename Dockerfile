# Serves the Julia ML Competitor book on Railway.
# Bare URL -> the book. /exams, /lessons, /notebooks browsable as files.
FROM caddy:2-alpine
WORKDIR /srv
COPY . /srv
RUN cp /srv/julia_ml_book.html /srv/index.html
CMD ["sh", "-c", "caddy file-server --root /srv --listen :${PORT:-8080}"]
