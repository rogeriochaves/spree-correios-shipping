require 'spree_core'

module SpreeCorreiosShipping
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/models/calculator/**/*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
      
      Dir.glob(File.join(File.dirname(__FILE__), "spree/**/*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
      
      [Shipping::Sedex, Shipping::Sedex10, Shipping::SedexHoje, Shipping::Pac, Shipping::Esedex, Shipping::PacAR, Shipping::SedexAR].each(&:register)
      
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
