module StatusHelper
  def status_color_by_type(type)
    case type
      when 'notice'
        'blue'
      when 'alert' || 'fail' || 'error'
        'red'
      when 'warning'
        'yellow'
      when 'success'
        'green'
    end
  end
end
