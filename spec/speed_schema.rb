class SpeedSchema

  def initialize
    @models = {}
    @before_creates = {}
  end

  def belongs_to(klass, name, options={})
    model = find_or_create_model(klass)
    model << { type: :belongs_to, name: name, options: options }
  end

  def add_has_many(klass, name, options={})
    model = find_or_create_model(klass)
    model << { type: :has_many, name: name, options: options }
  end

  def add_before_create(klass, args)
    call_backs = find_or_create_before_creates(klass)
    call_backs << args.first
  end

  def find_or_create_model(klass)
    if @models.key? klass
      @models[klass]
    else
      @models[klass] = []        
    end
  end

  def find_or_create_before_creates(klass)
    if @before_creates.key? klass
      @before_creates[klass]
    else
      @before_creates[klass] = []
    end
  end

  def find_relation(klass, name)
    model = find_or_create_model(klass)
    model.select{|r| r[:name] == name.to_sym }.first
  end
  
  def find_callbacks(klass)
    {
      before_creates: @before_creates[klass] || []
    }
  end

end