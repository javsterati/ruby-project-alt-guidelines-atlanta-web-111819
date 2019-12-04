class Dog < ActiveRecord::Base
    has_many :order
    has_many :user, through: :order
end 