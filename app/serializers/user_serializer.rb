class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name, :username, :bio, :created_at, :updated_at, :avatar

  DEFAULT_AVATAR = 'https://res-2.cloudinary.com/dhatgaadw/image/upload/v1661765174/e0eiopj9eqt5dwnt5n2v.jpg'

  def avatar
    if object.avatar.url.present?
      object.avatar.url
    else
      DEFAULT_AVATAR
    end
  end
end
