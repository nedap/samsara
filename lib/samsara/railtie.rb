class Samsara::Railtie < Rails::Railtie
  initializer 'samsara.initialize' do

    ActiveSupport.on_load(:active_record) do
      include Samsara::Model
    end

    ActiveSupport.on_load(:action_controller) do
      include Samsara::Controller
    end

  end
end
