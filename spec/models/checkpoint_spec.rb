require 'rails_helper'

RSpec.describe Checkpoint, type: :model do
 
    #! CHECKING VALIDATIONS
  describe 'validations' do
    
    it 'validates nome format' do
      checkpoint = Checkpoint.new(nome: 'invalid!')
      checkpoint.valid?
      expect(checkpoint.errors[:nome]).to include("non può contenere caratteri speciali")
    end

    it 'validates descrizione format' do
      checkpoint = Checkpoint.new(descrizione: 'invalid!')
      checkpoint.valid?
      expect(checkpoint.errors[:descrizione]).to include("non può contenere caratteri speciali")
    end
  end

  describe 'custom_validations' do
    it 'validates nome and descrizione format' do
      checkpoint = Checkpoint.new(nome: 'invalid!', descrizione: 'invalid!')
      checkpoint.send(:custom_validations)  # Manually call the private method
      expect(checkpoint.errors[:nome]).to include("non può contenere caratteri speciali")
      expect(checkpoint.errors[:descrizione]).to include("non può contenere caratteri speciali")
    end
    
    it 'valid nome and descrizione' do
      checkpoint = Checkpoint.new(nome: 'Valid Nome', descrizione: 'Valid Descrizione')
      checkpoint.send(:custom_validations)  # Manually call the private method
      expect(checkpoint.errors[:nome]).to be_empty
      expect(checkpoint.errors[:descrizione]).to be_empty
    end


  end

  
#! CHECKING ASSOCIATIONS

  describe 'associations' do 
    it 'presence of project' do
        checkpoint = Checkpoint.new(project_id: nil)
        checkpoint.valid?
        expect(checkpoint.errors[:project]).to include("can't be blank")
      end
    it 'belongs to a project' do
      project = Project.create(name: 'Test Project')
      checkpoint = Checkpoint.new(project: project)
      expect(checkpoint.project).to eq(project)
    end
  end


  #! ATTRIBUTES THAT CAN BE SEARCHED BY RANSACK
  describe 'ransackable_attributes' do
    it 'returns an array of ransackable attributes' do
      expect(Checkpoint.ransackable_attributes).to match_array(["completato", "created_at", "descrizione", "id", "nome", "project_id", "updated_at"])
    end
  end
end
