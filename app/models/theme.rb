class Theme < ActiveRecord::Base
  has_many :proposals

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
