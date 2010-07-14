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

This works by overriding the <, >, <=, and >= operators on the class in question, as well as in FalseClass. I probably wouldn't override built-in classes this way without thinking pretty hard about the consequences.