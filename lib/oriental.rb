require "oriental/version"
require "orientdb4r"

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

      self.after_save :oriental_after_save
    end
  end

  module InstanceMethods
    def oriental_after_save
      client = Orientdb4r.client
      config = YAML.load_file("#{Rails.root}/config/orientdb.yml")[Rails.env]
      client.connect :database => config['url'].split('/').last, :user => config['user'], :password => config['password']

      # docs: https://github.com/rails/arel/blob/master/test/test_update_manager.rb
      table = Arel::Table.new(self.class.name)
      um = Arel::UpdateManager.new table.engine
      um.table table
      um.where table[self.class.primary_key].eq(send self.class.primary_key)

      ar = []
      changes.select{|c| oriental_config[:attributes].include?(c.to_sym)}.each do |k,v|
        ar << [table[k], v[1]]
      end

      if !ar.blank?
        um.set ar
        puts client.command um.to_sql
      end
    end
  end
end

require "oriental/railtie"
