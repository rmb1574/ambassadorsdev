class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  devise :encryptable, :encryptor => :md5

  has_many :registrations
  has_many :events, :through => :registrations

  belongs_to :committee

  mount_uploader :image, ImageUploader

  acts_as_birthday :birthday

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :password, :password_confirmation, :name, :email, :remember_me, :confirmed_at, :phone, :birthday, :local_street, :local_city, :local_state, :local_zip, :local_apt, :permanent_street, :permanent_city, :permanent_state, :permanent_zip, :permanent_apt, :same_address, :tour_trained, :role_ids, :image, :image_cache, :remove_image, :major, :hours_enrolled, :graduation_date, :hometown, :committee_id, :old_id

  validates_integrity_of :image
  validates_processing_of :image

  def valid_password?(password)
    return false if encrypted_password.blank?
    Devise.secure_compare(Devise::Encryptable::Encryptors::Md5.digest(password, nil, nil, nil), self.encrypted_password)
  end

  def password_salt
    'no salt'
  end

  def password_salt=(new_salt)
  end

  def name
    if(last_name.blank?)
      first_name
    end
    [first_name,last_name].join(' ')
  end

  def committee_hours_year(year=Year.order("start DESC").first)
    committee_id = CreditType.where('name = ?', 'Committee').first.id
    attended_id = RegistrationStatus.where('name = ?', 'Attended').first.id
    @events=events.where('credit_type_id = ? AND date >= ? AND date <= ?', committee_id, year.start, year.end).where(:registrations => { :registration_status_id => attended_id })
    @events.sum(:hours)
  end

  def event_hours_year(year=Year.order("start DESC").first)
    event_id = CreditType.where('name = ?', 'Event').first.id
    attended_id = RegistrationStatus.where('name = ?', 'Attended').first.id
    @events=events.where('credit_type_id = ? AND date >= ? AND date <= ?', event_id, year.start, year.end).where(:registrations => { :registration_status_id => attended_id })
    @events.sum(:hours)
  end

  def committee_hours_month(date=Date.today)
    committee_id = CreditType.where('name = ?', 'Committee').first.id
    attended_id = RegistrationStatus.where('name = ?', 'Attended').first.id
    @events=events.where('credit_type_id = ? AND date >= ? AND date <= ?', committee_id, date.beginning_of_month, date.end_of_month).where(:registrations => { :registration_status_id => attended_id })
    @events.sum(:hours)
  end

  def event_hours_month(date=Date.today)
    event_id = CreditType.where('name = ?', 'Event').first.id
    attended_id = RegistrationStatus.where('name = ?', 'Attended').first.id
    @events=events.where('credit_type_id = ? AND date >= ? AND date <= ?', event_id, date.beginning_of_month, date.end_of_month).where(:registrations => { :registration_status_id => attended_id })
    @events.sum(:hours)
  end

  def service_hours_month(date=Date.today)
    attended_id = RegistrationStatus.where('name = ?', 'Attended').first.id
    @events = events.includes(:credit_type).where('date >= ? AND date <= ?', date.beginning_of_month, date.end_of_month).where(:credit_types => {:service => true}).where(:registrations => { :registration_status_id => attended_id })
    @events.sum(:hours)
  end

  def service_hours_year(year=Year.order("start DESC").first)
    attended_id = RegistrationStatus.where('name = ?', 'Attended').first.id
    @events = events.includes(:credit_type).where('date >= ? AND date <= ?', year.start, year.end).where(:credit_types => {:service => true}).where(:registrations => { :registration_status_id => attended_id })
    @events.sum(:hours)
  end

  def tours_year(year=Year.order("start DESC").first)
    attended_id = RegistrationStatus.where('name = ?', 'Attended').first.id
    @events = events.includes(:event_type).where('date >= ? AND date <= ?', year.start, year.end).where(:event_types => {:name => "Tour"}).where(:registrations => { :registration_status_id => attended_id }).count
  end

  def ceremonies_year(year=Year.order("start DESC").first)
    attended_id = RegistrationStatus.where('name = ?', 'Attended').first.id
    @events = events.includes(:event_type).where('date >= ? AND date <= ?', year.start, year.end).where(:event_types => {:name => "Commencement"}).where(:registrations => { :registration_status_id => attended_id }).count
  end
end
