composer_path = node["composer"]["path"]

bash "install-composer" do
    code <<-EOC
        mkdir #{composer_path}
        cd #{composer_path}
        curl -s http://getcomposer.org/installer | php
    EOC
    not_if "ls #{composer_path}/composer.phar"
end