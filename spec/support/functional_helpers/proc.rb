class Proc
  def negated
    ->(*a,&b){ !self.(*a,&b) }
  end
end
