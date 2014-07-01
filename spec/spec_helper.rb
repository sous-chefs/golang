require 'chefspec'
require 'chefspec/berkshelf'

ChefSpec::Coverage.start!

# Conventionally, all specs live under a `spec` directory
# which RSpec adds to the `$LOAD_PATH`. Require this file
# using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'

  # Select the Fauxhai template to load
  config.platform = 'ubuntu'
  config.version = '12.04'

end
