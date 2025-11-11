# Build stage
FROM python:3.10-slim AS build
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Final stage
FROM python:3.10-slim
WORKDIR /app
COPY --from=build /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY app.py .
EXPOSE 5000
CMD ["python", "app.py"]
