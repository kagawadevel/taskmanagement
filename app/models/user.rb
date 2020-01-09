class User < ApplicationRecord

  before_destroy :least_one_admin

  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  has_secure_password

  has_many :tasks, dependent: :destroy
  accepts_nested_attributes_for :tasks

  private

  def least_one_admin
    if User.where(admin: true).count == 1 && self.admin == true
      errors.add(:base, '管理者権限ユーザーが１人なので削除できません')
      throw(:abort)
    end
  end

end
