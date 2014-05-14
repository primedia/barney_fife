class Repository < ActiveRecord::Base
  validates :name, :organization, presence: true
  validate :repo_full_name_is_unique

  def full_name
    "#{organization}/#{name}"
  end

  def repo_full_name_is_unique
    unless full_name_unique?
      errors.add(:name, 'There is already a repository with that name for this organization.')
    end
  end

  def full_name_unique?
    self.class.where(organization: organization, name: name).count == 0
  end
end
