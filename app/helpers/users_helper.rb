module UsersHelper
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
      when 0 then 'току що'
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
    when "observer" then "<i class='fa fa-binoculars fa-2x'></i>"
    when "speaker"  then "<i class='fa fa-bullhorn fa-2x'></i>"
    when "orator"   then "<i class='fa fa-microphone fa-2x'></i>"
    end
    html.html_safe
  end

  def proposals_rank user
    html = case user.proposals_rank
    when "enthusiast"     then "<i class='fa fa-eye fa-2x'></i>"
    when "activist"       then "<i class='fa fa-gavel fa-2x'></i>"
    when "policy_maker"   then "<i class='fa fa-institution fa-2x'></i>"
    end
    html.html_safe
  end


end

