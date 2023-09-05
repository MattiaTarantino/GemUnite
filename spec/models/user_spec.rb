require 'rails_helper'

RSpec.describe User, type: :model do
    # password test
  describe '#password_complexity' do
    context 'with a valid password' do
      it 'does not add any errors' do
        user = User.new(password: 'Abcdefgh123')
        user.valid?
        expect(user.errors[:password]).to be_empty
      end
    end
    
    context 'with an invalid password' do
      it 'adds an error for password complexity' do
        user = User.new(password: 'invalidpassword')
        user.valid?
        expect(user.errors[:password]).to include("deve includere almeno una lettera minuscola, una maiuscola e un numero")
      end
    end
    
    context 'with a password missing a lowercase letter' do
      it 'adds an error for missing lowercase letter' do
        user = User.new(password: 'ABC123')
        user.valid?
        expect(user.errors[:password]).to include("deve includere almeno una lettera minuscola, una maiuscola e un numero")
      end
    end
    
    context 'with a password missing an uppercase letter' do
      it 'adds an error for missing uppercase letter' do
        user = User.new(password: 'abc123')
        user.valid?
        expect(user.errors[:password]).to include("deve includere almeno una lettera minuscola, una maiuscola e un numero")
      end
    end
    
    context 'with a password missing a digit' do
      it 'adds an error for missing digit' do
        user = User.new(password: 'Abcdef')
        user.valid?
        expect(user.errors[:password]).to include("deve includere almeno una lettera minuscola, una maiuscola e un numero")
      end
    end
  end

  # firstname and lastname test

  describe '#custom_validations' do
    context 'with valid first and last names' do
      it 'does not add any errors' do
        user = User.new(firstname: 'John', lastname: 'Doe')
        user.valid?
        expect(user.errors[:firstname]).to be_empty
        expect(user.errors[:lastname]).to be_empty
      end
    end
    
    context 'with invalid first name' do
      it 'adds an error for firstname pattern' do
        user = User.new(firstname: 'John123', lastname: 'Doe')
        user.valid?
        expect(user.errors[:firstname]).to include("deve contenere solo lettere")
      end
    end
    
    context 'with invalid last name' do
      it 'adds an error for lastname pattern' do
        user = User.new(firstname: 'John', lastname: 'Doe123')
        user.valid?
        expect(user.errors[:lastname]).to include("deve contenere solo lettere")
      end
    end
    
    context 'with both names invalid' do
      it 'adds errors for firstname and lastname patterns' do
        user = User.new(firstname: 'John123', lastname: 'Doe123')
        user.valid?
        expect(user.errors[:firstname]).to include("deve contenere solo lettere")
        expect(user.errors[:lastname]).to include("deve contenere solo lettere")
      end
    end
    
    context 'with missing first and last names' do
      it 'does not add any errors' do
        user = User.new
        user.valid?
        expect(user.errors[:firstname]).to be_empty
        expect(user.errors[:lastname]).to be_empty
      end
    end
  end
end
