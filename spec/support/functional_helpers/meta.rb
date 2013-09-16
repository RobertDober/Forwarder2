class Object
  def singl &blk
    class << self
      self
    end
    .tap do | s |
      s.module_eval(&blk) if blk
    end
  end

end
