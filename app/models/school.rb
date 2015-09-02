class School < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		:rememberable, :trackable, :authentication_keys => [:name]
	has_many :students
	has_many :teachers
	has_many :usages
	has_many :books
	has_many :aliases

	validates :name, :presence => true, :uniqueness => true
	validates :encrypted_password, :presence => true

	before_save :ensure_authentication_token

	def ensure_authentication_token
		if authentication_token.blank?
			self.authentication_token = generate_authentication_token
		end
	end

	private
		def generate_authentication_token
			loop do
				token = Devise.friendly_token
				break token unless School.where(:authentication_token => token).first
			end
		end
end