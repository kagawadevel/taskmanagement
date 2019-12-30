class Task < ApplicationRecord

  validates :title, presence: true
  validates :content, presence: true
  enum priority: {'高':0,'中':1,'低':2}

  scope :sort_expired_asc, -> {order(limit: :asc)}
  scope :sort_priority_asc, -> {order(priority: :asc)}

  scope :title_search, -> (title){ where("title LIKE ?", "%#{title}%") }
  scope :status_search, -> (status) { where(status: status)}

  belongs_to :user

end
