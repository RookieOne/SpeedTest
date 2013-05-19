class ARArray < Array
  
  def initialize(klass_string)
    @klass = klass_string.constantize    
  end

  def create!(args)
    obj = @klass.create(args)
    # obj.set_attributes(args) 
    callbacks = Xchema.find_callbacks(@klass)
    callbacks[:before_creates].each do |method|
      obj.send(method)
    end
    self << obj

    obj
  end

  def create(args)
    create!(args)
  end

end