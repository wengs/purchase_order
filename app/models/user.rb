class User < ActiveRecord::Base
  TEST_EMAIL= "shelms@imageoptions.net"

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :graphics
  belongs_to :region
  belongs_to :role

  validates :name, presence: true
  validates :email, presence: true

  def admin?
    role.name == 'admin'
  end

  def client?
    client_user? || client_admin?
  end

  def client_user?
    role.name == 'client_user'
  end

  def client_admin?
    role.name == 'client_admin'
  end

  def io_user?
    role.name == 'io_user'
  end

  def can_create_graphic?(po)
    admin? || io_user? || (client? && !po.ready_for_quote )
  end

  scope :with_role, lambda { |name|
    joins(:role).
    where(roles: { name: name.to_s })
  }
end
