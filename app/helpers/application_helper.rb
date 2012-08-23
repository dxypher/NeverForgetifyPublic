module ApplicationHelper
  # a robust method to display flash messages
  def flash_helper keys=[:notice, :alert, :errors]
    puts "keys:: #{keys.inspect}"
    # allow keys to be a symbol or an array of symbols
    keys = [keys] unless keys.kind_of? Array
    
    # html from each message
    html = ''
    flash.each do |key, msg|
      html = html + content_tag(:div, msg, :class => "notification #{key}") if keys.index key
    end
    html.html_safe
  end
end
