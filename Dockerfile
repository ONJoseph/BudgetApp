# Use the official Ruby image as the base
FROM ruby:3.0.1

# Set the working directory inside the container
WORKDIR /app

# Copy the Gemfile and Gemfile.lock to the container
COPY Gemfile Gemfile.lock ./

# Install the dependencies
RUN bundle install

# Copy the rest of the application files to the container
COPY . .

# Specify the command to start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
