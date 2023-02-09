require 'rails_helper'

RSpec.describe User, type: :model do
  include UserHelpers

  before(:each) do
    @user = build_user
  end

  it 'is valid with valid attributes' do
    expect(@user).to be_valid
  end

  it 'is not valid without a first name' do
    @user.first_name = nil
    expect(@user).to_not be_valid
  end

  it 'is not valid without a last name' do
    @user.last_name = nil
    expect(@user).to_not be_valid
  end
  
  it 'is not valid without a username' do
    @user.username = nil
    expect(@user).to_not be_valid
  end
  
  it 'is not valid without an email' do
    @user.email = nil
    expect(@user).to_not be_valid
  end
  
  it 'is not valid without a password' do
    @user.password = nil
    expect(@user).to_not be_valid
  end
  
  it 'is not valid if password and password confirmation do not match' do
    @user.password_confirmation = 'not_the_same'
    expect(@user).to_not be_valid
  end
  
  it 'is not valid if password is less than 8 characters' do
    @user.password = '1234567'
    expect(@user).to_not be_valid
  end
  
  it 'is not valid if email is already taken' do
    existing_user = create_user
    @user.email = existing_user.email
    expect(@user).to_not be_valid
  end
  
  it 'is not valid if username is already taken' do
    existing_user = create_user
    @user.username = existing_user.username
    expect(@user).to_not be_valid
  end
  
  it 'is not valid if username is less than 3 characters' do
    @user.username = '12'
    expect(@user).to_not be_valid
  end
end
