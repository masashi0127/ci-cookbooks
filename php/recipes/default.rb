packages = %w{gcc-c++ autoconf httpd-devel zlib-devel openssl-devel gd-devel libxml2-devel mysql-devel t1lib-devel bzip2-devel curl-devel gmp-devel aspell-devel recode-devel icu libicu-devel libmcrypt libmcrypt-devel php-intl}

packages.each do |p|

  package p do
    action :install
  end
end

execute "Install PHP7" do
  command <<-EOC
    wget http://jp2.php.net/get/php-7.0.0.tar.gz/from/this/mirror -O php-7.0.0.tar.gz
    tar zxf php-7.0.0.tar.gz
    cd php-7.0.0
    ./buildconf --force
    ./configure \
      --prefix=/usr/local/php \
      --with-config-file-path=/usr/local/php/etc \
      --enable-mbstring \
      --enable-zip \
      --enable-bcmath \
      --enable-pcntl \
      --enable-ftp \
      --enable-exif \
      --enable-intl \
      --enable-calendar \
      --enable-sysvmsg \
      --enable-sysvsem \
      --enable-sysvshm \
      --enable-wddx \
      --with-curl \
      --with-mcrypt \
      --with-iconv \
      --with-gmp \
      --with-pspell \
      --with-gd \
      --with-jpeg-dir=/usr \
      --with-png-dir=/usr \
      --with-zlib-dir=/usr \
      --with-xpm-dir=/usr \
      --with-freetype-dir=/usr \
      --enable-gd-native-ttf \
      --enable-gd-jis-conv \
      --with-openssl \
      --with-pdo-mysql=/usr \
      --with-gettext=/usr \
      --with-zlib=/usr \
      --with-bz2=/usr \
      --with-recode=/usr \
      --with-mysqli=/usr/bin/mysql_config \
      --with-apxs2=/usr/sbin/apxs
    make && make test
    sudo make install
    sudo cp -p php.ini-development /usr/local/php/etc/php.ini
    echo 'export PATH=$PATH:/usr/local/php/bin' >> /etc/profile
    source /etc/profile
  EOC
end
