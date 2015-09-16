module Cowsay
  module Character
    class Bear < Base
      def template
        <<-TEMPLATE
      @thoughts
      \
       \
        \
          ( )___( )
          /__oo   \
         ( \/     )
         | `=/    |
        /         \
       /  /    \   \
      /  (      \   \ 
     ( ,_/_      \   \
      \_ '=       \   )
        ""'       /  /
        ;        /  /'?
        :       (((( /
         `._   \  _ (
          __|   |  /_    
        ("__,.."'_._.)  
        TEMPLATE
      end
    end

  end
end