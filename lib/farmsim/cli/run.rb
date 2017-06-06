require "farmsim/cli"

module FarmSim
  module CLI
    class Run < Command
      description "run Farming Simulator"

      on("-s", "--savegame [ID]", "savegame number") do |c, value|
        puts "run savegame"
        puts value

        # c.config_key = value || "env.global"
      end

      def run(*args)
        puts "Hello WORLD RUN!"
      end

    end
  end
end
