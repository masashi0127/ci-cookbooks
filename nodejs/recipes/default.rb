package "nodejs" do
    action :install
end

bash "install npm - package manager for node" do
    cwd "/usr/local/src"
    user "root"
    code <<-EOF
        mkdir -p npm-v#{node[:npm][:version]} && \
        cd npm-v#{node[:npm][:version]}
        curl -L http://registry.npmjs.org/npm/-/npm-#{node[:npm][:version]}.tgz | tar xzf - --strip-components=1 && \
        make uninstall dev
    EOF
    not_if "rpm npm | grep npm"
    notifies :run, "bash[install gulp]", :delayed
end

bash "install gulp" do
    code <<-EOC
        npm install -g gulp
    EOC
    action :nothing
end
