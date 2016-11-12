class Role < ActiveRecord::Base
  DEFINED_ROLES = [
    :admin,
    :io_tester,
    :io_user,
    :client_admin,
    :client_user
  ]

  has_many :users
end
