class order < ActiveRecord::Base
    belongs_to :dog
    belongs_to :user
end 