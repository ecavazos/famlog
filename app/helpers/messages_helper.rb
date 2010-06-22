module MessagesHelper
  def months
    [
      ['January', 1],
      ['February', 2],
      ['March', 3],
      ['April', 4],
      ['May', 5],
      ['June', 6],
      ['July', 7],
      ['August', 8],
      ['September', 9],
      ['October', 10],
      ['November', 11],
      ['December', 12],
    ]
  end

  def years
    years = []
    (1..8).each_with_index { |i| years << 2009 + i }
    years
  end
end
