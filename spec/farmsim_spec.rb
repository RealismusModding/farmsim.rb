require "spec_helper"

require "farmsim/tools/system"

RSpec.describe FarmSim do
  it "has a version number" do
    expect(FarmSim::VERSION).not_to be nil
  end

  it "finds fs 17" do
    # expect(FarmSim::Tools::System.gameLocation).not_to be nil
  end
end
