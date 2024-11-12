# spec/models/user_spec.rb
require 'spec_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:phone_number_iso) }
    it { should validate_presence_of(:password_digest) }

    it { should validate_length_of(:first_name).is_at_most(50) }
    it { should validate_length_of(:last_name).is_at_most(50) }
    it { should validate_length_of(:phone_number_iso).is_at_most(2) }
    it { should validate_length_of(:password_recovery_token).is_at_most(150) }
    it { should validate_length_of(:password_recovery_code).is_at_most(4) }
  end

  describe 'password security' do
    it 'should have a secure password' do
      expect(user).to have_secure_password
    end
  end

  describe 'workflow state transitions' do
    subject { create(:user) }

    it 'has initial state :pending' do
      expect(subject.workflow_state).to eq('pending')
    end

    context 'when the user is in the pending state' do
      it 'can transition to active' do
        subject.active!
        expect(subject.workflow_state).to eq('active')
      end

      it 'can transition to abandoned' do
        subject.abandon!
        expect(subject.workflow_state).to eq('abandoned')
      end
    end

    context 'when the user is in the active state' do
      before do
        subject.active!
      end

      it 'can transition to suspended' do
        subject.suspend!
        expect(subject.workflow_state).to eq('suspended')
      end

      it 'can transition to deleted' do
        subject.delete!
        expect(subject.workflow_state).to eq('deleted')
      end
    end

    context 'when the user is in the suspended state' do
      before do
        subject.active!
        subject.suspend!
      end

      it 'can transition back to active' do
        subject.unsuspend!
        expect(subject.workflow_state).to eq('active')
      end
    end
  end
end
