class User < ApplicationRecord
  include Graphql::Assignable
  include JwtAuthenticatable

  GRAPHQL_ATTRIBUTES = %i[email]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :scripts
end
