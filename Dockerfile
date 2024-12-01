# Use an official PHP-Apache image
FROM php:8.2-apache

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    default-mysql-client

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Set working directory
WORKDIR /var/www/html

# Clone the WeMakeDevHackathon repository
RUN git clone https://github.com/Tarun9005/WeMakeDevHackathon.git /var/www/html/WeMakeDevHackathon

# Set the correct permissions for Apache
RUN chown -R www-data:www-data /var/www/html/WeMakeDevHackathon \
    && chmod -R 755 /var/www/html/WeMakeDevHackathon

# Install MySQL and import the database
COPY hospitalblood.sql /docker-entrypoint-initdb.d/

# Environment variables for MySQL
ENV MYSQL_ROOT_PASSWORD=root \
    MYSQL_DATABASE=hospitalblood

# Start script to initialize MySQL and Apache
COPY init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

# Expose the required port
EXPOSE 80

# Command to run on container start
CMD ["/usr/local/bin/init.sh"]
