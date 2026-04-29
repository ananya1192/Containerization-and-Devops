# Stage 1: Builder
FROM python:3.11-slim AS builder

WORKDIR /app

COPY requirements.txt .
RUN pip install --user --no-cache-dir -r requirements.txt

# Stage 2: Final (smaller image)
FROM python:3.11-slim

WORKDIR /app

# Copy only installed dependencies from builder
COPY --from=builder /root/.local /root/.local

# Add app code
COPY app ./app

# Add path for installed packages
ENV PATH=/root/.local/bin:$PATH

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]