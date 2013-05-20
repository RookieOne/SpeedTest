class ARArray < Array
  
  def initialize(klass_string)
    @klass = klass_string.constantize    
  end

  def set_parent(parent)
    @parent = parent
  end

  def create!(args)
    obj = @klass.create(args)
    # obj.set_attributes(args) 
    callbacks = SpeedSchema.instance.find_callbacks(@klass)
    callbacks[:before_creates].each do |method|
      obj.send(method)
    end
    self << obj

    if @parent
      attribute = "#{@parent.get_id_name_for_relations}=".to_sym
      obj.send(attribute, @parent.id)
    end

    obj
  end

  def create(args)
    create!(args)
  end

  def where(args)
    predicates = args.map do |key, value|
      Proc.new { |x| x.send(key) == value }
    end
    self.select do |x|
      r = predicates.map { |p| p.call(x) }
      !r.any?{|x| x == false}
    end
  end

end