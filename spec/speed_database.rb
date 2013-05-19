
class SpeedDatabase

  def initialize
    @tables = {}
  end

  def save(object)
    table = find_or_create_table(object.class.to_s)
    record = table.select{|o| o.id == object.id }.first
    if record.nil?
      object.id = table.count+1
      table << object
    end
  end

  def count(table_name)
    find_or_create_table(table_name).count
  end

  def find_or_create_table(table_name)
    if @tables.key? table_name
      @tables[table_name]
    else
      @tables[table_name] = ARArray.new(table_name)
    end
  end

  def get_table_name_from_method(method)
    method.chop.split("_").map{|s| s.capitalize}.join
  end

  def belongs_to(object, method, relation)
    table_name = get_table_name_from_method(method)
    table = find_or_create_table(table_name)   
    binding.pry
    table
  end

  def has_many(object, method, relation)
    table_name = get_table_name_from_method(method)
    table = find_or_create_table(table_name)   

    options = relation[:options]

    if options
      if options.key?(:through)      
        # binding.pry
        table = Db.has_many(object, options[:through].to_s, {})
      end
    end

    # binding.pry
    model_id_attribute = object.get_id_name_for_relations

    result = ARArray.new(table_name)
    table.each do |model|
      result << model
    end
    result
  end

  def belongs_to(object, method, relation)
    binding.pry
  end

end