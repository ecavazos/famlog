module Famlog::DateTimeParser
  def self.parse(date_val = '', time_val = '')
    return if date_val.to_s.empty?

    date_val.gsub!(/-/, '/')

    if time_val.to_s.empty?
      DateTime.strptime(date_val, '%m/%d/%Y')
    else
      DateTime.strptime(date_val + ' ' + time_val, '%m/%d/%Y %I:%M %p')
    end
  end
end
