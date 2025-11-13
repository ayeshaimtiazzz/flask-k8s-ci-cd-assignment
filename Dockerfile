# Build stage: Install dependencies in a separate layer for efficiency
FROM python:3.11-slim AS builder

# Set working directory
WORKDIR /app

# Copy requirements first (for better caching)
COPY requirements.txt .

# Install dependencies to user directory (avoids permission issues)
RUN pip install --user -r requirements.txt

# Runtime stage: Use a clean, slim image for the final app
FROM python:3.11-slim

# Set working directory
WORKDIR /app

# Copy installed dependencies from builder stage
COPY --from=builder /root/.local /root/.local

# Add the local bin to PATH
ENV PATH=/root/.local/bin:$PATH

# Copy the Flask app
COPY app.py .

# Expose the port the app runs on
EXPOSE 5000

# Run the app using Python directly
CMD ["python", "app.py"]