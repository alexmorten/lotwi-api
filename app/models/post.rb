class Post < ApplicationRecord
  has_one :location, dependent: :destroy
  acts_as_mappable :through => :location
end
