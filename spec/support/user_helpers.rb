require 'faker'

module UserHelpers
  def build_user
    first_name = Faker::Name
    last_name = Faker::Name
    username = Faker::Internet
    bio = Faker::Lorem
    email = Faker::Internet.email
    password = Faker::Internet.password(min_length: 8)
    password_confirmation = password

    FactoryBot.build(:user, first_name: first_name, last_name: last_name, username: username, bio: bio, email: email, password: password, password_confirmation: password_confirmation)
  end

  def create_user
    first_name = Faker::Name
    last_name = Faker::Name
    username = Faker::Internet
    bio = Faker::Lorem
    email = Faker::Internet.email
    password = Faker::Internet.password(min_length: 8)
    password_confirmation = password

    FactoryBot.create(:user, first_name: first_name, last_name: last_name, username: username, bio: bio, email: email, password: password, password_confirmation: password_confirmation)
  end
end
