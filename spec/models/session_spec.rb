require 'rails_helper'

RSpec.describe Session, type: :model do

  before do
    create(:user)
  end

  context 'valid' do
    let(:correct_params) { attributes_for(:user) }

    it 'with correct user credentials' do
      session = Session.new(correct_params)
      expect(session.valid?).to be_truthy
    end
  end

  context 'invalid' do
    let(:no_email) { attributes_for(:user, email: '') }
    let(:invalid_email) { attributes_for(:user, email: '223112') }
    let(:not_existed_email) { attributes_for(:user, email: 'user@user.com') }
    let(:no_email_and_password) { attributes_for(:user,
                                                 email: '',
                                                 password: '') }
    let(:incorrect_password) { attributes_for(:user, password: '4244') }

    it 'with blank email' do
      session = Session.new(no_email)
      expect(session.valid?).to be_falsey
      expect(session.errors[:email]).to include("can't be blank")
    end

    it 'with not valid email' do
      session = Session.new(invalid_email)
      expect(session.valid?).to be_falsey
      expect(session.errors[:email]).to include('is not a valid email')
    end

    it 'with not existed email' do
      session = Session.new(not_existed_email)
      expect(session.valid?).to be_falsey
      expect(session.errors[:email]).to include('User not found')
    end

    it 'with blank email and password' do
      session = Session.new(no_email_and_password)
      expect(session.valid?).to be_falsey
      expect(session.errors[:email]).to include("can't be blank")
      expect(session.errors[:password]).to include("can't be blank")
    end

    it 'with incorrect password' do
      session = Session.new(incorrect_password)
      expect(session.valid?).to be_falsey
      expect(session.errors[:password]).to include('Password incorrect')
    end
  end
end
