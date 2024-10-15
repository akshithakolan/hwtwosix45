FROM httpd:latest
COPY ./survey.html /usr/local/apache2/htdocs/
RUN chmod 777 /usr/local/apache2/htdocs/survey.html
EXPOSE 80
