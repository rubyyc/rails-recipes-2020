class Event < ApplicationRecord

  validates_presence_of :name
  STATUS = ["draft", "public", "private"]
  validates_inclusion_of :status, :in => STATUS

  before_validation :generate_friendly_id, :on => :create

  belongs_to :category, :optional => true


  # 优化网址第一种方法
  # def to_param
  #   "#{self.id}-#{self.name}"
  # end

  def to_param
    self.friendly_id
  end

  protected

  def generate_friendly_id
    self.friendly_id || SecureRandom.uuid
  end
end
