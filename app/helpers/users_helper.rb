module UsersHelper

  def translate_rank rank
    case rank
    when "observer"     then "Наблюдател"
    when "speaker"      then "Говорител"
    when "orator"       then "Оратор"
    when "enthusiast"   then "Ентусиаст"
    when "activist"     then "Активист"
    when "policy_maker" then "Полиси мейкър"
    end
  end

  def user_role_label user
    translation, klass = case user.role
    when "registered" then ["регистриран", "label-primary"]
    when "moderator" then ["модератор", "label-warning"]
    when "admin" then ["администратор", "label-danger"]
    end
    "<span class='label #{klass}'>#{translation}</span>".html_safe
  end

  def pretty_date date
    a = (Time.now-date).to_i

    case a
      when 0 then 'току-що'
      when 1 then 'преди секунда'
      when 2..59 then 'преди ' + a.to_s + ' секунди'
      when 60..119 then 'преди минута' #120 = 2 minutes
      when 120..3540 then 'преди ' + (a/60).to_i.to_s + ' минути'
      when 3541..7100 then 'преди час' # 3600 = 1 hour
      when 7101..82800 then 'преди ' + ((a+99)/3600).to_i.to_s + ' часа'
      when 82801..172000 then 'преди ден' # 86400 = 1 day
      when 172001..518400 then 'преди ' + ((a+800)/(60*60*24)).to_i.to_s + ' дена'
      when 518400..1036800 then 'преди седмица'
      else 'преди ' + ((a+180000)/(60*60*24*7)).to_i.to_s + ' седмици'
    end
  end

  def comments_rank user
    html = case user.comments_rank
    when "observer" then "<a href='/rank/observer' class='btn btn-lg btn-primary'><i class='fa fa-binoculars fa-lg'></i> Наблюдател</a>"
    when "speaker"  then "<a href='/rank/speaker' class='btn btn-lg btn-warning'><i class='fa fa-bullhorn fa-lg'></i> Говорител</a>"
    when "orator"   then "<a href='/rank/orator' class='btn btn-lg btn-danger'><i class='fa fa-microphone fa-lg'></i> Оратор</a>"
    end
    html.html_safe
  end

  def proposals_rank user
    html = case user.proposals_rank
    when "enthusiast"     then "<a href='/rank/enthusiast' class='btn btn-lg btn-primary'><i class='fa fa-eye fa-lg'></i> Ентусиаст</a>"
    when "activist"       then "<a href='/rank/activist' class='btn btn-lg btn-warning'><i class='fa fa-gavel fa-lg'></i> Активист</a>"
    when "policy_maker"   then "<a href='/rank/policy_maker' class='btn btn-lg btn-danger'><i class='fa fa-institution fa-lg'></i> Полиси мейкър</a>"
    end
    html.html_safe
  end

end

