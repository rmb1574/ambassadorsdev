class Event < ActiveRecord::Base
  attr_accessible :ait, :date, :end_time, :hours, :instructions, :location, :members_needed, :start_time, :title, :event_type_id, :credit_type_id, :apparel_id, :old_id
  has_many :registrations, :dependent => :destroy
  has_many :users, :through => :registrations
  belongs_to :event_type
  belongs_to :credit_type
  belongs_to :apparel
  validates_presence_of :date, :end_time, :hours, :members_needed, :start_time, :title, :event_type, :credit_type
  accepts_nested_attributes_for :registrations

  scope :by_month, lambda { |date| where("date >= ? AND date <= ?", date.beginning_of_month, date.end_of_month) }

  def datetime_start
    datetime = DateTime.new(date.year, date.month, date.day, start_time.hour, start_time.min, start_time.sec, DateTime.now.offset)
  end

  def datetime_end
    datetime = DateTime.new(date.year, date.month, date.day, end_time.hour, end_time.min, end_time.sec, DateTime.now.offset)
  end

  def start_past?
    datetime_start.past?
  end

  def end_past?
    datetime_end.past?
  end

  def filled?
    open_slots <= 0
  end

  def open_slots
    canceled_id = RegistrationStatus.find_by_name("Canceled").id
    open_slots = members_needed - registrations.count(:conditions => ["registration_status_id != ?", canceled_id])
  end
end
