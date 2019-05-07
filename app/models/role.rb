class Role < ApplicationRecord
  has_many :users
  NORMAL_USER = "Normal User"
end
