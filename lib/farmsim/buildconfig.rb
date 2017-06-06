
require "yaml"

module FarmSim
  class BuildConfig

    # @param path Path of the build config file
    def initialize(path)

      x = YAML.load("foo:\n- a\n- b: c")
      puts x

    end

  end
end
