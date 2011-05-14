require 'rails'

module ActsAsKing
  class Railtie < Rails::Railtie
    initializer "acts_as_king" do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send(:include, ActsAsKing)
      end
    end
  end
end

