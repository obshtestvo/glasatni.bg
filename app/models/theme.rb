class Theme < ActiveRecord::Base
  has_many :proposals
  belongs_to :moderator, class_name: :User, foreign_key: :user_id

  private
  def self.en_names
    {
      all: "Всички теми",
      volunteering: "Доброволчество",
      ngo: "Неправителствени организации",
      participation: "Гражданско участие",
      education: "Гражданско образование",
      meta: "Как да подобрим платформата"
    }
  end
end
