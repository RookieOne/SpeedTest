
module ActiveRecord
  class Base

    def initialize(args = {})
      set_attributes(args)
    end

    def get_id_name_for_relations
      "#{self.class.to_s.downcase}_id"
    end

    def reload
      self
    end

    def set_attributes(attributes)
      attributes.each do |key, value|
        assignment = "#{key}=".to_sym
        send(assignment, value)
      end
    end

    def method_missing(method_sym, *args, &blk)
      p "method missing"
      method = method_sym.to_s
      p method
      
      if method.ends_with?("=")
        attr_name = method.gsub("=", "")
        class_eval { attr_accessor attr_name }
        self.send(method_sym, args[0])
        return
      end

      relation = SpeedSchema.instance.find_relation(self.class, method)
      if !relation.nil?
        case(relation[:type])
        when :has_many
          return Db.has_many(self, method, relation)
        when :belongs_to
          return Db.belongs_to(self, method, relation)
        end
      end
    end

    def save!
      Db.save(self)
    end

    class << self

      def records
        @records ||= []
      end

      def count
        records.count
      end

      def create(*args)
        obj = new
        obj.id = self.count + 1
        obj.set_attributes(args.first)

        records << obj
        obj
      end

      def scopes
        @scopes ||= []
      end

      def scope(*args)
        # @scopes
        binding.pry
        method_name = args.first.to_s
        class_eval(<<-EOS, __FILE__, __LINE__ + 1)
                  def #{method_name}                                          # def user
                    #{foreign_key} && #{class_name}.find(#{foreign_key})      #   user_id && User.find(user_id)
                  end                                                         # end
                                                                              # 
                  def #{to_model}?                                            # def user?
                    #{foreign_key} && #{class_name}.exists?(#{foreign_key})   #   user_id && User.exists?(user_id)
                  end                                                         # end
                                                                              # 
                  def #{to_model}=(object)                                    # def user=(model)
                    self.#{foreign_key} = (object && object.#{primary_key})   #   self.user_id = (model && model.id)
                  end                                                         # end
                EOS
      end

    end

    def self.attr_accessible(*args)
    end

    def self.belongs_to(name, scope = nil, options = {})
      SpeedSchema.instance.belongs_to(self, name, scope)
    end

    def self.has_many(name, scope = nil, options = {})
      SpeedSchema.instance.has_many(self, name, scope)
    end

    def self.has_one(name, scope = nil, options = {})
    end

    def self.validates_presence_of(*attr_names)
    end

    def self.validates_numericality_of(*attr_names)
    end

    def self.validates_email_format_of(*attr_names)
    end

    def self.validate(*attr_names)
    end

    def self.validates(*args)
    end

    def self.default_scope(*args)
    end



    def self.order(*args)
    end

    def self.devise(*args)
    end

    def self.before_save(*args)
    end

    def self.before_create(*args)
      SpeedSchema.instance.add_before_create(self, args)
    end

    def self.after_initialize(*args)
    end

    def self.after_create(*args)
    end

    def self.after_save(*args)
    end

    def self.serialize(*args)
    end

    def self.where(*args)      
      Db.where(self, args.first)
    end

  end 
end