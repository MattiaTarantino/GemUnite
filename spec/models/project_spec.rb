# spec/models/project_spec.rb

require 'rails_helper'

RSpec.describe Project, type: :model do

  describe "validations" do
    it "is valid with valid attributes" do
      project = Project.new(
        info_leader: "Leader info",
        dimensione: 5,
        descrizione: "Project description",
        stato: "aperto",
        name: "Project Name"
      )
      expect(project).to be_valid
    end

    it "is not valid without info_leader" do
      project = Project.new(info_leader: nil)
      expect(project).not_to be_valid
    end

    it "is not valid without dimensione" do
      project = Project.new(dimensione: nil)
      expect(project).not_to be_valid
    end

    it "is not valid without descrizione" do
      project = Project.new(descrizione: nil)
      expect(project).not_to be_valid
    end

    it "is not valid without stato" do
      project = Project.new(stato: nil)
      expect(project).not_to be_valid
    end

    it "is not valid without name" do
      project = Project.new(name: nil)
      expect(project).not_to be_valid
    end
  end
end
