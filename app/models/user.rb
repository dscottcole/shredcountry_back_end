class User < ApplicationRecord
    has_many :orders
    has_many :bikes, through: :orders


    has_secure_password
    
    validates :username, presence: true
    validates :name, presence: true
    validates :email, presence: true
    validates :username, uniqueness: true, on: :create
    # validates :password, length: {in:6..20}
end
