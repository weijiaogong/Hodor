class Judge < ActiveRecord::Base
	#attr_accessible :name, :company_name, :access_code, :scores_count, :role
	has_many :scores, dependent: :destroy
	has_many :posters, through: :scores

    validates :name, :company_name, presence: true
    validates :access_code, uniqueness: true # not sure whether the number should be unique

    before_save :create_remember_token

    def self.find_available_judges
      judges = judges.where("scores_count < 3", leave: false)

      if judges.empty?
        judges = Judge.where(leave: false)
      end
      return judges
	end
    private
        def create_remember_token
            self.remember_token = SecureRandom.urlsafe_base64
        end
end
