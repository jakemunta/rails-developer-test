class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
attr_accessor :role
  ROLES = %i[admin editor vanilla]
  def admin?
	has_role?(:admin)
  end

  def editor?
        has_role?(:editor)
  end

  def vanilla?
      has_role?(:vanilla)
  end

end
