# frozen_string_literal: true

require 'rails_compatibility'

class << RailsCompatibility
  if ActiveSupport::VERSION::MAJOR >= 7
    def setup_autoload_paths(paths)
      require 'zeitwerk'
      loader = Zeitwerk::Loader.new

      paths.each do |path|
        ActiveSupport::Dependencies.autoload_paths << path
        loader.push_dir(path)
      end

      loader.setup
    end
  else
    def setup_autoload_paths(paths)
      paths.each do |path|
        ActiveSupport::Dependencies.autoload_paths << path
      end
    end
  end
end
