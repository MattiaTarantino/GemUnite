require 'rails_helper'

RSpec.describe "Creating Checkpoints", type: :request do
  include Devise::Test::IntegrationHelpers
  let(:user) { create(:user) }  # Assuming you have a User factory set up
  let(:project) { create(:project) }  # Assuming you have a Project factory set up

  before do
    sign_in user
  end

  it 'leader creates a new checkpoint' do
    UserProject.create(user_id: user.id, project_id: project.id, role: 'leader')
    checkpoint_params = attributes_for(:checkpoint, project_id: project.id)

    expect {
      post "/users/#{user.id}/projects/#{project.id}/checkpoints", params: { checkpoint: checkpoint_params }
    }.to change(Checkpoint, :count).by(1)

    expect(response).to redirect_to(user_project_checkpoint_url(user, project, assigns(:checkpoint)))
  end

  it 'member does not create a new checkpoint' do
    UserProject.create(user_id: user.id, project_id: project.id, role: 'member')
    checkpoint_params = attributes_for(:checkpoint, project_id: project.id)

    expect {
      post "/users/#{user.id}/projects/#{project.id}/checkpoints", params: { checkpoint: checkpoint_params }
    }.to change(Checkpoint, :count).by(0)

    expect(response).to redirect_to(my_projects_user_projects_url(user))
  end

  it 'guest does not create a new checkpoint' do
    checkpoint_params = attributes_for(:checkpoint, project_id: project.id)

    expect {
      post "/users/#{user.id}/projects/#{project.id}/checkpoints", params: { checkpoint: checkpoint_params }
    }.to change(Checkpoint, :count).by(0)

    expect(response).to redirect_to(my_projects_user_projects_url(user))
  end

  it 'leader does not creates a new checkpoint with invalid params' do
    UserProject.create(user_id: user.id, project_id: project.id, role: 'leader')
    checkpoint_params = { nome: nil, descrizione: nil, project_id: project.id }

    expect {
      post "/users/#{user.id}/projects/#{project.id}/checkpoints", params: { checkpoint: checkpoint_params }
    }.to change(Checkpoint, :count).by(0)

    expect(response).to render_template(:new)
  end

end
