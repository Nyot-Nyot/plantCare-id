# Setup and run the FastAPI backend (manual steps)

Follow these steps locally to create a Python virtual environment and run the backend:

1. Create virtual environment and install deps

```fish
python3 -m venv backend/.venv
backend/.venv/bin/pip install --upgrade pip
backend/.venv/bin/pip install -r backend/requirements.txt
```

2. Run the backend

```fish
backend/.venv/bin/uvicorn backend.main:app --reload --port 8001
```

3. Health check

Open in your browser or use curl:

```fish
curl http://127.0.0.1:8001/health
```

Notes:

-   Do not commit the virtual environment (`backend/.venv`) to git. Add it to `.gitignore` if needed.
-   If you need to expose the backend to other devices, change `--host` to `0.0.0.0` and ensure firewall rules allow it.

Environment and API keys

-   Copy `.env.example` to `.env` at the repository root and fill the values. Do NOT commit your real `.env` file with secrets.
-   Required placeholders added to `.env.example`:
    -   `SUPABASE_URL` and `SUPABASE_ANON_KEY` (Supabase project)
    -   `PLANT_ID_API_KEY` (Plant.id API key — get one from https://admin.kindwise.com/)
    -   `ORCHESTRATOR_URL` (backend base URL, e.g. `http://localhost:8001`)

Example (fish):

```fish
cp .env.example .env
# Edit .env and fill real keys
printf "PLANT_ID_API_KEY=your_real_key\n" >> .env
```

For local testing without real API keys, use a mock endpoint for `ORCHESTRATOR_URL` and update `identifyService` to point to the mock.
