class Theme < ActiveRecord::Base
  has_many :proposals
  belongs_to :moderator, class_name: :User, foreign_key: :user_id

  private
  def self.en_names
    {
      all: "Всички теми",
      volunteering: "Доброволчество",
      ngo: "НПО",
      participation: "Гражданско участие",
      education: "Гражданско образование",
      meta: "Мета тема"
    }
  end
end
