#!/bin/bash

# Start MySQL in the background
service mysql start

# Import the SQL file into MySQL
mysql -uroot -prootpassword hospitalblood < /docker-entrypoint-initdb.d/hospitalblood.sql

# Start Apache in the foreground
apache2-foreground
