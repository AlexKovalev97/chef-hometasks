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

#content = data_bag_item('landing', 'simple')

#template "/var/www/#{node['nginx']['dest']}/index.html" do   
#  source "index.html.erb"
#  mode "0644"
#  action :create
#  variables( ct: content )
#  notifies :reload, "service[nginx]"
#end

#ip = ''

#ip: 'search(:node, 'roles:jboss')[0]["network"]["interfaces"]["enp0s8"]["addresses"].detect{|k,v| v[:family] == "inet" }.first' #do |result|
#ip: search(:node, 'role:jboss', :filter_result => { 'ip' => [0]['network']['interfaces']['enp0s8']['addresses'].detect{|k,v| v[:family] == 'inet'}).first #do |result|
#  ip = result['ip']
# ip = node["jboss"]["network"]["interfaces"]["enp0s8"]["addresses"].detect{|k,v| v[:family] == "inet" }.first
#end
#ip = Array.new

#search(:node, "role:jboss") do |n|
#  n["network"]["interfaces"]["enp0s8"]["addresses"].each do |address,value|
#    ip << address if value.has_key?("broadcast")
#end

template "/etc/nginx/conf.d/jboss.conf" do   
  source "nginx.conf.erb"
  variables(
#    ip_address: ip,
    ip_nginx: search(:node, 'roles:nginx')[0]["network"]["interfaces"]["enp0s8"]["addresses"].detect{|k,v| v[:family] == "inet" }.first,
    ip_jboss: search(:node, 'roles:jboss')[0]["network"]["interfaces"]["enp0s8"]["addresses"].detect{|k,v| v[:family] == "inet" }.first,
    port: node['nginx']['port'],
    app_dest: node['nginx']['dest'] 
  )
  notifies :reload, "service[nginx]"
end
