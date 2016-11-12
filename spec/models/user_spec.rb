require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.create(:user, :client_user) }

  describe '#basic_attributes' do
    it 'should have a name' do
      expect(user.name).to_not be nil
    end

    it 'should have a password' do
      expect(user.encrypted_password).to_not be nil
    end

    it 'should have an email' do
      expect(user.email).to_not be nil
    end

    it 'should have a role' do
      expect(user.role).to_not be nil
    end
  end

  let(:admin) { FactoryGirl.create(:user, :admin_user) }

  describe '#admin_attributes' do
    it 'should pass #verify_if_admin' do
      expect(admin.admin?).to be true
    end
  end
end
