require "ffeature/helper"

module FFeature
  class Railtie < Rails::Railtie
    initializer "ffeature.configure_view_controller" do |_app|
      ActiveSupport.on_load :action_controller do
        include FFeature::Helper
      end
    end
  end
end
