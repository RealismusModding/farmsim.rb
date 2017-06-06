require "spec_helper"

RSpec.describe FarmSim::Project do
  it "loads project files" do
    # project = FarmSim::Project.new("/Users/joskuijpers/Development/RealismusModding/fs17_seasons/farmsim.yml")

    # expect(project.main).to eq "src/loader.lua"
    # expect(project.multiplayer).to be true
  end

  it "can be empty" do
    project = FarmSim::Project.new

    expect(project.main).to eq "src/loader.lua"
    expect(project.multiplayer).to be false
  end

  describe "zip" do
    it "uses git" do
      # project = FarmSim::Project.new("/Users/joskuijpers/Development/RealismusModding/fs17_seasons/farmsim.yml")

      # expect(project.zip_name).to eq "FS17_RM_S0_Seasons.zip"
    end
  end
end
