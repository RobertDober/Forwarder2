class Integer
  class << self
    def sum; ->(*args){ args.reduce :+ } end
  end
end
