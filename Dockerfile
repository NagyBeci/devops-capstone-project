# Use Python 3.9 slim image as the base image
FROM python:3.9-slim

# Set the working directory to /app
WORKDIR /app

# Copy the requirements file into the image's working directory
COPY requirements.txt /app/

# Install dependencies from the requirements file
RUN pip install --no-cache-dir -r requirements.txt

# Copy the service package into the image's working directory
COPY service/ /app/service/

# Create a non-root user 'theia' and set ownership
RUN useradd theia && chown -R theia:theia /app

# Switch to the non-root user
USER theia

# Expose port 8080
EXPOSE 8080

# Run the application using Gunicorn
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]
