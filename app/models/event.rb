class Event < ApplicationRecord

  include RankedModel
  ranks :row_order

  has_many :tickets, :dependent => :destroy, :inverse_of  => :event

  accepts_nested_attributes_for :tickets, :allow_destroy => true, :reject_if => :all_blank

  validates_presence_of :name
  STATUS = ["draft", "public", "private"]
  validates_inclusion_of :status, :in => STATUS

  before_validation :generate_friendly_id, :on => :create
  # before_commit :generate_friendly_id


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
    puts "kkkk"
    self.friendly_id ||= SecureRandom.uuid
  end
end
