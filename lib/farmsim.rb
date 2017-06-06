require "farmsim/version"

module FarmSim
  autoload :CLI,            "farmsim/cli"
  autoload :Version,        "farmsim/version"

  autoload :BuildConfig,    "farmsim/buildconfig"
  autoload :ConsolidatedBuildConfig, "farmsim/consolidatedbuildconfig"
  autoload :Project,        "farmsim/project"
end
