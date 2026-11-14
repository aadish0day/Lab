FROM python:3.12-slim
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY server.py .
# jwks.json is written at runtime by the exploit script via a shared volume
EXPOSE 6000
CMD ["python", "server.py"]
