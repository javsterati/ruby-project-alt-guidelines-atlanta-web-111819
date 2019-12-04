class User < ActiveRecord::Base
    has_many :order
    has_many :dog, through: :order
end 