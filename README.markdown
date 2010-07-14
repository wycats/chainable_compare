This provides a module which you can mix into any class to get chainable compare properties:

    class String
      include ChainablyComparable
    end

    def pick_line(name)
      if "A" < name < "M"
        "Line a"
      else
        "Line b"
      end
    end

    puts pick_line("Yehuda")
    puts pick_line("Evan")

This works by overriding the <code><</code>, <code>></code>, <code><=</code>, and <code>>=</code> operators on the class in question, as well as in <code>FalseClass</code>. I probably wouldn't override built-in classes this way without thinking pretty hard about the consequences.

This works if you don't need to define your own comparison methods (i.e. your class inherits from a superclass that defines them). Otherwise, you can define <code><=></code> as usual:

    class Version
      include ChainablyComparable

      attr_accessor :version

      def initialize(version)
        @version = version.split(".").map {|segment| segment.to_i }
      end

      def <=>(other)
        a, b = normalize(@version, other.version)
        a <=> b
      end

    private
      def normalize(a, b)
        if a.size > b.size
          [a.dup, b.dup.fill(0, a.size - 1, a.size - b.size)]
        else
          [a.dup.fill(0, b.size - 1, b.size - a.size), b.dup]
        end
      end
    end

    version = Version.new("2.0")
    Version.new("1.0.0") < version < Version.new("3")