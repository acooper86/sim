module ScheduleHelper

  def time_html( day, second, time_start_stop)
    time_html = ""
  
    time_html += create_select(day, second, time_start_stop, "hour")
  	time_html += create_select(day, second, time_start_stop, "min")
  
    return time_html.html_safe
  end

  def create_select(day, second, start_end, hour_min)
    
    name = create_name(day, second, start_end, hour_min)
    
    return select( :schedule_times, name, options(hour_min, name), {:include_blank => "None"} )
  end
  
  def create_name(day, second, start_end, hour_min)
    name = day + "_" + start_end
    name += "_second" if second
    name +="[" + hour_min + "]"
    
    return name
  end
  
  def options(hour_min, name)
    if @schedule.schedule.blank?
      if hour_min == "hour" 
        options = option_hours
      elsif hour_min == "min"
        options = option_min
      end
    else
      if hour_min == "hour"
        options = option_hours_edit(name)
      elsif hour_min == "min"
        options = option_min_edit(name)
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
  
  def option_hours_edit(name)
  	return options_for_select(@@hours_array, current_value(name))
  end
  
  def option_min_edit(name)
    return options_for_select(@@min_array, current_value(name))
  end
  
  def current_value(name)
    return @schedule.schedule[name_part_1(name)][name_part_2(name)]
  end
  
  def name_part_1(name)
    return name.gsub(/\[\w*]/,"")
  end
  
  def name_part_2(name)
    return name.gsub(/\A\w*/,"").gsub(/\[/,"").gsub(/]/)
  end
  
  @@min_array = [[':00', 0],[':05', 5],[':10',10],[':15', 15],[':20', 20],[':25',25],[':30',30],[':35', 35],[':40', 40],[':45', 45],[':50',50],[':55',55]]
  
  @@hours_array = [['1 am', 1],['2 am', 2],['3 am', 3],['4 am', 4],['5 am', 5],['6 am', 6],['7 am', 7],['8 am', 8],['9 am', 9],['10 am', 10],['11 am', 11],['12 am', 12],['1 pm', 13],['2 pm', 14],['3 pm', 15],['4 pm', 16],['5 pm', 17],['6 pm', 18],['7 pm', 19],['8 pm', 20],['9 pm', 21],['10 pm', 22],['11 pm', 24],['12 pm', 24]]
end
