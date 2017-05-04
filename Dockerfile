FROM andrewnicols/moodle-php:5.6
ENV DEBIAN_FRONTEND noninteractive

# Install the latest version of freetds manually, because we need it for emoji support (core_dml_testcase::test_four_byte_character_insertion)
RUN curl ftp://ftp.freetds.org/pub/freetds/stable/freetds-1.00.33.tar.gz -o /tmp/freetds-1.00.33.tar.gz
RUN apt-get install -y unixodbc-dev
RUN cd /tmp && tar -xvf freetds-1.00.33.tar.gz && cd freetds-1.00.33 \
        && ./configure --with-unixodbc=/usr --sysconfdir=/etc/freetds --enable-sybase-compat \
        && make -j$(nproc) \
        && make install

RUN docker-php-ext-install -j$(nproc) mssql
COPY freetds.conf /etc/freetds/freetds.conf
