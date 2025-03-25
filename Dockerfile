# Use an official lightweight Node.js image
FROM node:18-alpine as build

# Set working directory
WORKDIR /usr/src/app

# Copy package.json and package-lock.json separately for caching dependencies
COPY package*.json ./

# Install dependencies
RUN npm install --only=production

# Copy the application source
COPY . .

# Use a minimal runtime image for production
FROM node:18-alpine

# Set working directory
WORKDIR /usr/src/app

# Copy only necessary files from the builder stage
COPY --from=build /usr/src/app /usr/src/app

# Expose the application port
EXPOSE 3000

# Run the application
CMD ["npm", "start"]
