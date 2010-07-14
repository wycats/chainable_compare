class ChainableCompare
  def initialize(obj)
    @obj = obj
  end

  %w(< > <= >=).each do |operator|
    class_eval <<-RUBY, __FILE__, __LINE__ + 1
      def #{operator}(other)
        if @obj #{operator} other
          ChainableCompare.new(other)
        else
          false
        end
      end
    RUBY
  end
end

module ChainablyComparable
  def self.included(klass)
    %w(< > <= >=).each do |operator|
      klass.class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def #{operator}(other)
          if super
            ChainableCompare.new(other)
          else
            false
          end
        end
      RUBY
    end
    
  end
end

class FalseClass
  %w(< > <= >=).each do |operator|
    class_eval <<-RUBY, __FILE__, __LINE__ + 1
      def #{operator}(other)
        false
      end
    RUBY
  end
end