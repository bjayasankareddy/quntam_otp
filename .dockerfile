# Use an official lightweight Python image as a parent image
FROM python:3.10-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install the Python dependencies
# Using --no-cache-dir makes the image smaller
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application source code into the container
COPY quantum_otp_generator.py .
COPY chatotp_with_api.py .

# IMPORTANT: Set placeholder environment variables for the email credentials.
# You MUST override these with your actual credentials when you run the container.
ENV EMAIL_ADDRESS="your_email@gmail.com"
ENV EMAIL_PASSWORD="your_google_app_password"

# Expose the port the app runs on
EXPOSE 5001

# Define the command to run the application using Gunicorn WSGI server
# It will run the 'app' instance from the 'chatotp_with_api' python file.
CMD ["gunicorn", "--bind", "0.0.0.0:5001", "chatotp_with_api:app"]
