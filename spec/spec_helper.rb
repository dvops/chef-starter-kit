require 'infrataster/rspec'
require 'chefspec'

RSpec.configure do |config|
  # Specify the path for Chef Solo to find cookbooks (default: [inferred from
  # the location of the calling spec file])
  config.cookbook_path = 'cookbooks'

  # Specify the path for Chef Solo to find roles (default: [ascending search])
  config.role_path = 'roles'

  # Specify the Chef log_level (default: :warn)
  config.log_level = :warn

  config.filter_run_excluding integration: true
end
