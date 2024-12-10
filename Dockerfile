#Multi stage Docker Build
# Stage 1: Build Stage
FROM python:3.12-slim AS build

# Set environment variables for the build stage
ENV PYTHONUNBUFFERED 1

# Set working directory inside the container
WORKDIR /app

# Install system dependencies needed for building Python packages
RUN apt-get update && apt-get install -y \
    libpq-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install pip dependencies from requirements.txt
COPY requirements.txt /app/
RUN pip install --upgrade pip && pip install -r requirements.txt

# Stage 2: Runtime Stage (final, production-ready image)
FROM python:3.12-slim AS runtime

# Set working directory for the runtime container
WORKDIR /app

# Install only runtime dependencies (from the build stage)
COPY --from=build /app /app

# Expose the port that the app will run on
EXPOSE 8000

# Set environment variable for Django settings module
ENV DJANGO_SETTINGS_MODULE=coffee_queen.settings

# Run the Django app using Gunicorn (production server)
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "coffee_queen.wsgi:application"]

