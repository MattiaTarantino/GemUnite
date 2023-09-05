require 'rails_helper'

RSpec.describe "Project Requests", type: :request do
    include Devise::Test::IntegrationHelpers
    let(:user) { create(:user) }  
    let(:project) { create(:project) }

    before do
        project.update(stato: "aperto")
        sign_in user
    end

    it 'user creates a new project request' do
        request_params = attributes_for(:request, user_id: user.id, project_id: project.id)

        expect {
        post "/users/#{user.id}/projects/#{project.id}/requests", params: { request: request_params }
        }.to change(Request, :count).by(1)

        expect(response).to redirect_to(user_project_request_url(user, project, assigns(:request)))
    end

    it 'user does not create a new project request with invalid params' do
        request_params = { user_id: user.id, project_id: project.id, note: nil }

        expect {
        post "/users/#{user.id}/projects/#{project.id}/requests", params: { request: request_params }
        }.to change(Request, :count).by(0)

        expect(response).to render_template(:new)
    end

    it 'user cannot create a new project request for a closed project' do
        project.update(stato: "chiuso")
        request_params = attributes_for(:request, user_id: user.id, project_id: project.id)

        expect {
        post "/users/#{user.id}/projects/#{project.id}/requests", params: { request: request_params }
        }.to change(Request, :count).by(0)

        expect(response).to redirect_to(root_path)
    end

    it 'user cannot create a new project request if already a member' do
        UserProject.create(user_id: user.id, project_id: project.id, role: 'member')
        request_params = attributes_for(:request, user_id: user.id, project_id: project.id)

        expect {
        post "/users/#{user.id}/projects/#{project.id}/requests", params: { request: request_params }
        }.to change(Request, :count).by(0)

        expect(response).to redirect_to(root_path)
    end

    it 'user can view their project request' do
        request = create(:request, user_id: user.id, project_id: project.id)

        get "/users/#{user.id}/projects/#{project.id}/requests/#{request.id}"
        
        expect(response).to render_template(:show)
    end
end