class Importance
  @@types = {
    :low        => 'Low',
    :medium     => 'Medium',
    :high       => 'High',
    :super_high => 'Super High'
  }

  LOW        = @@types[:low]
  MEDIUM     = @@types[:medium]
  HIGH       = @@types[:high]
  SUPER_HIGH = @@types[:super_high]

  ALL = LOW, MEDIUM, HIGH, SUPER_HIGH

  def self.[](key)
    return @@types.to_a[key][1] if key.is_a? Fixnum
    @@types[key]
  end
end
