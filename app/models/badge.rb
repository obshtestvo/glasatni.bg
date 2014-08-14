class Badge < ActiveRecord::Base
  has_many :awards
  has_many :users
end
