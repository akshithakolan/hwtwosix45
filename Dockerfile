# Use the official Apache HTTP Server image from the Docker Hub
FROM httpd:2.4

# Copy the static website files into the container
COPY survey.html /usr/local/apache2/htdocs/
# Set the appropriate permissions for the HTML file
RUN chmod 644 /usr/local/apache2/htdocs/survey.html
# Expose port 80
EXPOSE 80