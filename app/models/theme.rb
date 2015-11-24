class Theme < ActiveRecord::Base
  has_many :proposals
  belongs_to :moderator, class_name: :User, foreign_key: :user_id

  scope :active, -> { where(archived: false) }
  scope :archived, -> { where(archived: true) }

  private
  def self.en_names
    {
      all: "Всички теми",
      volunteering: "Доброволчество",
      ngo: "Неправителствени организации",
      participation: "Гражданско участие",
      education: "Гражданско образование",
      referendum: "Референдум",
      meta: "Как да подобрим платформата",
      social: "Социално предприемачество",
      choose_theme: "Предложи тема"
    }
  end
end
