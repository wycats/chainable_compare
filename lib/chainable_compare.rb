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
  def <(other)
    if (self <=> other) == -1
      ChainableCompare.new(other)
    else
      false
    end
  end

  def >(other)
    if (self <=> other) == 1
      ChainableCompare.new(other)
    else
      false
    end
  end

  def <=(other)
    if (self <=> other) <= 0
      ChainableCompare.new(other)
    else
      false
    end
  end

  def >=(other)
    if (self <=> other) >= 0
      ChainableCompare.new(other)
    else
      false
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