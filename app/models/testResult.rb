class TestResult < ApplicationRecord
  has_many :test
  belongs_to :user
end
