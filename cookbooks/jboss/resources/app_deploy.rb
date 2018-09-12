resource_name :app_deploy

property :owner, String, default: node['jboss']['jboss_user']
property :group, String, default: node['jboss']['jboss_group']

default_action :create

action :create do
  remote_file '/opt/jboss/server/default/deploy/sample.war' do
    source "https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war"
    owner new_resource.owner
    group new_resource.group
    show_progress true
    action :create_if_missing
  end

  http_request 'check' do
    url 'http://10.0.0.20:8080/sample'
  end
end
