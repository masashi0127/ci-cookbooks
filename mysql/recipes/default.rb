db = node["mysql"]["db"]
user = node["mysql"]["user"]
password = node["mysql"]["password"]

execute "Install MySQL Community Release" do
    command <<-EOC
        rpm -ivh http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
        yum install -y mysql-server
        chkconfig mysqld on
        service mysqld start
        mysqladmin -u root password password
        mysql -uroot -ppassword -e "create database #{db} character set utf8;"
        mysql -uroot -ppassword -e "grant all privileges on #{db}.* to #{user} identified by '#{password}' with grant option;"
        mysql -uroot -ppassword -e "grant all privileges on #{db}.* to '#{user}'@'localhost' identified by '#{password}' with grant option;"
    EOC
    not_if "rpm -qa | grep -q mysqld"
end
