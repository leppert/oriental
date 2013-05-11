module Oriental
  if defined?(Rails::Railtie)
    require "rails"
    
    class Railtie < Rails::Railtie
      initializer "orientdb.extend_active_record" do
        ActiveSupport.on_load(:active_record) do
          Oriental::Railtie.insert
        end
      end
    end
  end
  
  class Railtie
    def self.insert
      ActiveRecord::Base.send(:include, Oriental)
    end
  end
end
