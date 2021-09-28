require 'rails_helper'

describe User, type: :model do
  context 'Begin' do
    it 'Should be able has none to begin with' do
      expect(User.count).to eq 0
    end

    it 'Should be able has one after adding one' do
      User.create(email: 'jonh@doe.com', password_digest: '123mudar')
      expect(User.count).to eq 1
    end

    it 'Should be able has none after one was created in a previous example' do
      expect(User.count).to eq 0
    end
  end
end

describe User, type: :model do
  context 'Validates' do

    subject { User.new(email: 'jonh@doe.com', password_digest: '123456') }
    it { should validate_presence_of(:email) }
    it { should_not allow_value('jonhdoe.com').for(:email) }
    it { should_not validate_uniqueness_of(:email) }

    it { should validate_presence_of(:password_digest) }
    it { should have_secure_password_digest(:password_digest) }
    it { should validate_length_of(:password_digest).is_at_least(6) }
  end
  xcontext 'Format' do
    it 'before save' do
      User.new(email: 'JONH@DOE.COM', password_digest: '')
    end
  end
end
