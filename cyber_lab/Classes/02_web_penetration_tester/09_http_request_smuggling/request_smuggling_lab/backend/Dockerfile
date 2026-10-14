FROM python:3.11-alpine

WORKDIR /app
COPY server.py /app/server.py
RUN chmod +x /app/server.py

EXPOSE 8000

CMD ["python3", "-u", "/app/server.py"]
