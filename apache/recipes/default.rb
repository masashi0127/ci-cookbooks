package 'httpd' do
  action :install
end

service "httpd" do
  action [:enable]
  supports :start => true, :status => true, :restart => true, :reload => true
end

template "/etc/httpd/conf/httpd.conf" do
  source "httpd.conf.erb"
  variables(
    :document_root => node["apache"]["document_root"],
    :port => node["apache"]["port"]
  )
  notifies :start, 'service[httpd]'
  notifies :reload, 'service[httpd]'
end

execute "chkconfig httpd" do
  command "chkconfig httpd on"
end

directory "/var/www/html" do
  owner 'apache'
  group 'apache'
  mode '0755'
  action :create
end
