Chef::Log.info("Feedback IP: #{node[:deploy]['feedback_debug'][:environment_variables][:ELASTICIP]}")

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

#  log 'message' do
#	message 'Create config.json in #{deploy[:deploy_to]}/current/modules'
#	level :info
#  end
	
  Chef::Log.info("Create config.json in #{deploy[:deploy_to]}/current/modules")

  template "#{deploy[:deploy_to]}/current/modules/config.json" do
	cookbook 'opsworks_nodejs'
    source 'config.json.erb'
    mode '0644'
    owner deploy[:user]
    group deploy[:group]
    variables(:DB => deploy[:environment_variables][:DBNAME], :DBHOST => deploy[:environment_variables][:DBHOST], :ELASTICIP => deploy[:environment_variables][:ELASTICIP])
  end
	
  Chef::Log.info("Remove config.js from #{deploy[:deploy_to]}/current/modules")

  file "#{deploy[:deploy_to]}/current/modules/config.js" do
	action :delete
    owner deploy[:user]
    group deploy[:group]
  end
  
end
