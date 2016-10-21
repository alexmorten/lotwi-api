class Location < ApplicationRecord
  belongs_to :post
  acts_as_mappable
end
