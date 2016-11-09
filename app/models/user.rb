class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, authentication_keys: [:username]
  devise :omniauthable, :omniauth_providers => [:facebook]
  devise :registerable, :recoverable, :rememberable, :trackable, :validatable

end
