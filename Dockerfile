# Start with a base node image
FROM node:20.9.0

# Add image metadata
LABEL version=1.0
LABEL maintainer="Scott Offen"
LABEL key="value"

# Copy the package files to the application directory
COPY package*.json /app/

# Create the application directory
WORKDIR /app

# Restore dependencies
RUN ["npm", "install", "@nestjs/cli", "-g"]
RUN ["npm", "ci", "--omit=dev"]

# Copy the application
COPY . /app/

# Build the application
RUN ["npm", "run", "build"]

# Create a non-root user to run the application
RUN useradd -ms /bin/bash apiuser && \
    chown apiuser:apiuser /app
USER apiuser

# Start the application
CMD ["npm", "run", "start:prod"]