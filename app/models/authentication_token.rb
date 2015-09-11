require 'securerandom'
require 'bcrypt'

class AuthenticationToken < ActiveRecord::Base
	belongs_to :school

	validates :secret_id, :presence => true, :uniqueness => :true
	validates :hashed_secret, :presence => true

	before_validation :generate_secret_id, :unless => :secret_id
	before_validation :generate_secret, :unless => :secret

	attr_accessor :secret

	def self.find_authenticated(credentials)
		token = where(:secret_id => credentials[:secret_id]).first
		token if token and token.has_secret?(credentials[:secret])
	end

	def has_secret?(secret)
		Devise::Encryptor.compare(Devise, hashed_secret, secret)
	end

	private
		def generate_secret_id
			begin
				self.secret_id = SecureRandom.hex 8
			end while self.class.exists?(:secret_id => self.secret_id)
		end

		def generate_secret
			self.secret = SecureRandom.urlsafe_base64 32
			self.hashed_secret = Devise::Encryptor.digest(Devise, secret)
		end
end