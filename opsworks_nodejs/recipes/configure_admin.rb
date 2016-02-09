node[:deploy].each do |application, deploy|
  if deploy[:application_type] != 'nodejs'
    Chef::Log.debug("Skipping deploy::nodejs application #{application} as it is not a node.js app")
    next
  end

  template "#{deploy[:deploy_to]}/shared/config/opsworks.js" do
    cookbook 'opsworks_nodejs'
    source 'opsworks.js.erb'
    mode '0660'
    owner deploy[:user]
    group deploy[:group]
    variables(:database => deploy[:database], :memcached => deploy[:memcached], :layers => node[:opsworks][:layers])
  end
	
  Chef::Log.info("Create modules dir in /srv/www/feedback_admin")

  directory "/srv/www/feedback_admin/modules" do
	action :create
    mode '0755'
    owner deploy[:user]
    group deploy[:group]
  end
	
  Chef::Log.info("Create config.json in /srv/www/feedback_admin/modules")

  template "/srv/www/feedback_admin/modules/config.json" do
	cookbook 'opsworks_nodejs'
    source 'config.json.erb'
    mode '0644'
    owner deploy[:user]
    group deploy[:group]
  end
  
end
