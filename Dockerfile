# Python 3.12 (not 3.13): pydub depends on audioop, which was removed in 3.13
FROM python:3.12-slim

WORKDIR /app

# ffmpeg is used by pydub for audio processing
RUN apt-get update && apt-get install -y --no-install-recommends ffmpeg \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

# app.py hard-codes port 3000, so use the Flask CLI to run on 5000
ENV FLASK_APP=app.py
CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]
