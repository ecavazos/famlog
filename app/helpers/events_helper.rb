module EventsHelper
  def time_opts
    t = []
    format = lambda { |x| x.strftime('%l:%M %P').strip }
    24.times do |i|
      t << format.call(Time.new(1999, 9, 9, i, 00))
      t << format.call(Time.new(1999, 9, 9, i, 30))
    end
    t
  end
end
