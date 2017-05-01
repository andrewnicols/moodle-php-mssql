FROM andrewnicols/moodle-php
ENV DEBIAN_FRONTEND noninteractive

# Setup mssql dependencies
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
ADD https://packages.microsoft.com/config/ubuntu/16.04/prod.list /etc/apt/sources.list.d/mssql-tools.list
ENV ACCEPT_EULA Y
RUN apt-get update && apt-get -y install msodbcsql mssql-tools
RUN pecl install sqlsrv

RUN echo "; priority=20\nextension=sqlsrv.so"  >> /etc/php/7.0/mods-available/sqlsrv.ini
RUN phpenmod sqlsrv

CMD php-fpm7.0 -R
