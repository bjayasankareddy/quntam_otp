# Use an official Python runtime as a parent image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container at /app
COPY requirements.txt .

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application's code into the container at /app
COPY chatapp.py .
COPY quantum_otp_generator.py .

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define environment variables (can be overridden at runtime)
# It's better to pass these at runtime for security
ENV FLASK_APP=chatapp.py
ENV FLASK_RUN_HOST=0.0.0.0

# Command to run the application
CMD ["flask", "run"]
