# 1. Base Image: partiamo da un sistema operativo leggero con Python già installato
FROM python:3.12-slim

# 2. Definisce la cartella di lavoro DENTRO il container
WORKDIR /app

# 3. Copiamo SOLO i requirements prima (Ottimizzazione Layer Cache)
# Docker salverà questo passaggio in cache. Finché non modifichi requirements.txt, 
# la prossima volta non dovrà riscaricare le dipendenze.
COPY requirements.txt .

# 4. Installiamo le dipendenze
RUN pip install --no-cache-dir -r requirements.txt

# 5. Ora copiamo il resto del nostro codice
COPY . .

# 6. Diciamo a Docker quale porta documentare come "usata" dal container
EXPOSE 8000

# 7. Il comando che parte quando avvii il container
# Notare l'host 0.0.0.0, vitale perché dentro il container non esiste "localhost" esterno!
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
