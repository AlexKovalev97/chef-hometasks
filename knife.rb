# See http://docs.chef.io/config_rb_knife.html for more information on knife configuration options

current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "aliaksandrkavaleu"
client_key               "#{current_dir}/aliaksandrkavaleu.pem"
validation_client_name   "a-c-validator"
validation_key           "#{current_dir}/a-c-validator.pem"
chef_server_url          "https://api.chef.io/organizations/a-c"
cookbook_path            ["#{current_dir}/../cookbooks"]
knife[:editor] = 'vim'
