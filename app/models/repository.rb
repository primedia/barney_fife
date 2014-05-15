class Repository < ActiveRecord::Base
  validates :name, :organization, presence: true
  validates_uniqueness_of :name, scope: :organization

  def full_name
    "#{organization}/#{name}"
  end

end
