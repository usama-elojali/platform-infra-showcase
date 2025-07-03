# Use an official Python image
FROM python:3.11

# Set working directory in container
WORKDIR /usr/src/app

# Copy requirements and install them
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the app code
COPY app.py ./

# Expose port 5000
EXPOSE 5000

# Run the app
CMD ["python", "app.py"]
