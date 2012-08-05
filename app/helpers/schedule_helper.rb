module ScheduleHelper
  ##############Schedule calendar methods
   def create_month_rows(time, user)
    html = ""
    day = time.beginning_of_month
    
    html << create_padding_days(day) unless day.wday == 0
    
    month_appointments = month_appointments_query(user, day)
    
    while day < time.end_of_month 
      html << "<tr>" if day.wday == 0
      
      html << "<td>" + day.day.to_s + day_appointments(day, month_appointments) + "</td>"
      
      html << "</tr>" if day.wday == 6 
      
      day = day + 1.days
    end
    
    return html.html_safe
    
  end
  
  def create_padding_days(time)
    html ="<tr>"
    days_before = time.wday.to_i
    
    time.wday.times do |i|
      days = days_before - i
      prev_day = time - days.days
      html << "<td>" + prev_day.day.to_s + "</td>"
    end
    
    return html
  end
  
  def month_appointments_query(user, day)
    return user.appointment.where(["start >= ? AND start <= ?", day, day.end_of_month]).order("start asc")
  end
  
  def day_appointments(day, apps)
    html = "<ul>"
    apps.each do |app|
      html << '<li><a href="' << user_appointment_path(app.user_id, app.id) << '">' << app.start.strftime("%l:%M%P") << " " << app.contact.first_name << " " << app.contact.last_name << "</a></li>" if day.mday == app.start.mday
    end
    html << "</ul>"
    
    return html
  end
  
  def create_week_rows(time, user)
    html = ""
    day = time.beginning_of_week
    
    while day < time.end_of_week
      html << create_day_rows(day, user)
      
      day = day + 1.days
    end
    
    return html.html_safe 
  end
  
  def create_day_rows(day, user)
    html = "<td><ul>"
    appointments = user.appointment.where(["start >= ? AND start <= ?", day, day.end_of_day]).order("start asc")
    time = day.beginning_of_day 
    
    while time < day.end_of_day
      html << "<li>" 
      appointments.each do |app|
        if app.start >= time && app.start < time + 1.hours
          html << '<a href="' << user_appointment_path(app.user_id, app.id) << '">' << app.start.strftime("%l:%M%P") << " " << app.contact.first_name << " " << app.contact.last_name << "</a>"
        end
      end
      html << "</li>"
      
      time = time + 1.hours
    end
    
    html << "</ul></td>"
    
    return html
  end
  
  def previous_month(time)
    return time - 1.months
  end
  
  def next_month(time)
    return time + 1.months
  end
  
  def previous_week(time)
    return time - 1.weeks
  end
  
  def next_week(time)
    return time + 1.weeks
  end
  
  def previous_day(time)
    return time - 1.days
  end
  
  def next_day(time)
    return time + 1.days
  end
  ##############create and edit schedule methods
  
  def time_html( day, second, time_start_stop)
    time_html = ""
  
    time_html += create_select(day, second, time_start_stop, "hour")
  	time_html += create_select(day, second, time_start_stop, "min")
  
    return time_html.html_safe
  end

  def create_select(day, second, start_end, hour_min)
    
    name = create_name(day, second, start_end, hour_min)
    value = current_value(day, second, start_end, hour_min) unless @schedule.schedule.blank?
    
    return select( :schedule_times, name, options(hour_min, name, value), {:include_blank => "None"} )
  end
  
  def create_name(day, second, start_end, hour_min)
    name = day + "_" + start_end
    name += "_second" if second
    name +="[" + hour_min + "]"
    
    return name
  end
  
  def current_value(day, second, start_end, hour_min)
    name = day + "_" + start_end
    name += "_second" if second
    return value = @schedule.schedule[name][hour_min]
  end
  
  def options(hour_min, name, value)
    if @schedule.schedule.blank?
      if hour_min == "hour" 
        options = option_hours
      elsif hour_min == "min"
        options = option_min
      end
    else
      if hour_min == "hour"
        options = option_hours_edit(name, value)
      elsif hour_min == "min"
        options = option_min_edit(name, value)
      end
    end
    
    return options
  end
  
  def option_hours
  	return options_for_select(@@hours_array)
  end
  
  def option_min
    return options_for_select(@@min_array)
  end
  
  def option_hours_edit(name, value)
  	return options_for_select(@@hours_array, value )
  end
  
  def option_min_edit(name, value)
    return options_for_select(@@min_array, value)
  end
  
  @@min_array = [[':00', 0],[':05', 5],[':10',10],[':15', 15],[':20', 20],[':25',25],[':30',30],[':35', 35],[':40', 40],[':45', 45],[':50',50],[':55',55]]
  
  @@hours_array = [['1 am', 1],['2 am', 2],['3 am', 3],['4 am', 4],['5 am', 5],['6 am', 6],['7 am', 7],['8 am', 8],['9 am', 9],['10 am', 10],['11 am', 11],['12 am', 12],['1 pm', 13],['2 pm', 14],['3 pm', 15],['4 pm', 16],['5 pm', 17],['6 pm', 18],['7 pm', 19],['8 pm', 20],['9 pm', 21],['10 pm', 22],['11 pm', 24],['12 pm', 24]]
end
