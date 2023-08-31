require 'rails_helper'

RSpec.describe Request, type: :model do
    describe "#request_validation" do
        context "with valid attributes" do
            it "is valid" do
                user = create(:user)
                project = create(:project)
                request = Request.new(user: user, project: project, note: "Note test", stato_accettazione: "In attesa")
                expect(request).to be_valid
            end
        end
   
        context "without a user" do
            it "is not valid" do
                project = create(:project)
                request = Request.new(project: project, note: "Note test", stato_accettazione: "In attesa")
                expect(request).not_to be_valid
            end
        end

        context "without a project" do
            it "is not valid" do
                user = create(:user)
                request = Request.new(user: user, note: "Note test", stato_accettazione: "In attesa")
                expect(request).not_to be_valid
            end
        end
    end
end
