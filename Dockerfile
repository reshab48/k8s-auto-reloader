# Base Dockerfile
FROM python:3.9-slim

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip install -r requirements.txt

ENV FLASK_APP=/app/latest/app.py

COPY scripts/watch_and_reload.sh /
RUN chmod +x /watch_and_reload.sh

CMD ["/bin/bash", "/watch_and_reload.sh"]
