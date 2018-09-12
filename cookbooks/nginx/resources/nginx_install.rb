resource_name :nginx_install

property :ip_nginx, String, required: true
property :ip_jboss, String, required: true
property :port, String, default: node['nginx']['port']
#property :dest, String, default: node['nginx']['dest']

default_action :install

action :install do
 package 'nginx' do
   action :install
 end

 service 'nginx' do
   action [:enable, :start]
 end

#directory "/var/www/#{new_resource.dest}" do
#  recursive true
#  action :create
#end

 template '/etc/nginx/conf.d/jboss.conf' do
   source 'jboss.conf.erb'
   variables(
     ip_nginx: new_resource.ip_nginx,
     ip_jboss: new_resource.ip_jboss,
     port: new_resource.port
   )
   action :create
   notifies :reload, 'service[nginx]'
 end
end
