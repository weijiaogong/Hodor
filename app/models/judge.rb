class Judge < ActiveRecord::Base
	#attr_accessible :name, :company_name, :access_code, :scores_count, :role
	has_many :scores, dependent: :destroy
	has_many :posters, through: :scores

    validates :name, :company_name, presence: true
    before_save :create_remember_token

    private
        def create_remember_token
            self.remember_token = SecureRandom.urlsafe_base64
        end
end
