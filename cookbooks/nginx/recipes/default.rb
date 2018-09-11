#package "nginx-#{node['nginx']['version']}" do
package "nginx" do
  action :install
end

service "nginx" do
  action [:enable, :start]
end

directory "/var/www/#{node['nginx']['dest']}" do
  recursive true
  action :create
end

template "/etc/nginx/conf.d/jboss.conf" do   
  source "nginx.conf.erb"
  variables(
    ip_nginx: search(:node, 'roles:nginx')[0]["network"]["interfaces"]["enp0s8"]["addresses"].detect{|k,v| v[:family] == "inet" }.first,
    ip_jboss: search(:node, 'roles:jboss')[0]["network"]["interfaces"]["enp0s8"]["addresses"].detect{|k,v| v[:family] == "inet" }.first,
    port: node['nginx']['port'],
    app_dest: node['nginx']['dest'] 
  )
  notifies :reload, "service[nginx]"
end
