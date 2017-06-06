require "farmsim/cli"
require "farmsim/tools/system"

module FarmSim
  module CLI
    class Log < Command
      description "get log from Farming Simulator"

      def run
        path = FarmSim::Tools::System.userdataLocation
        error "Location of log not found" if not path

        path = path + "log.txt"
        error "Log file does not exist" if not path.exist?

        File.foreach(path.to_path) { |x| print x }
      end

    end
  end
end
