class Registration < ApplicationRecord
  has_paper_trail
  attr_accessor :current_step
  # STATUS = ["pending", "confirmed"]
  STATUS = ["pending", "confirmed", "cancalled"]
  validates_inclusion_of :status, :in => STATUS
  validates_presence_of :status, :ticket_id
  validates_presence_of :name, :email, :cellphone, :if => :should_validate_basic_data?
  validates_presence_of :name, :email, :cellphone, :bio, :if => :should_validate_all_data?
  validate :check_event_status, :on => :create


  belongs_to :event
  belongs_to :ticket
  belongs_to :user, :optional => true

  scope :by_status, ->(s){ where( :status => s ) }
  scope :by_ticket, ->(t){ where( :ticket_id => t ) }

  before_validation :generate_uuid, :on => :create

  def to_param
    self.uuid
  end

  protected

  def check_event_status
    if self.event.status == "draft"
      errors.add(:base, "活动尚未开放报名")
    end
  end

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end

  def should_validate_basic_data?
    current_step == 2
  end

  def should_validate_all_data?
    current_step == 3 || status == "confirmed" # 做到第三步，或最后状态是 confirmed 时需要验证
  end
end
