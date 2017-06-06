require "farmsim/cli"
require "farmsim/tools/system"

require "shellwords"

module FarmSim
  module CLI
    class Log < Command
      description "get log from Farming Simulator"

      def run
        path = FarmSim::Tools::System.userdataLocation
        if not path
          error "Location of log not found"
        end

        path = path + "log.txt"
        if not path.exist?
          error "Log file does not exist"
        end

        File.foreach(path.to_path) { |x| print x }
      end

    end
  end
end
