require "oriental/version"

module Oriental
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def oriental type, options
      return if self.included_modules.include?(Oriental::InstanceMethods)
      return unless self.table_exists?

      include Oriental::InstanceMethods

      cattr_accessor :oriental_config

      self.oriental_config = {:type => type, :attributes => [], :in => [], :out => []}.merge(options)

      self.after_save :oriental
    end
  end

  module InstanceMethods
    def oriental

    end
  end
end

require "oriental/railtie"
