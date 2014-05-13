module Pr

  class Test

    def method_to_overwrite(  args )
      do_something_else_with("{ args }" )
    end
    
    def anotherBadMethod foo
      foo.bar.qux
    end
  end
end
