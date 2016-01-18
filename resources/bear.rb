module Cowsay
  module Character
    class Bear < Base
      def initialize
        @thoughts = '\\'
        @eyes = 'oo'
        @tongue = '  '
      end
      def template
        <<-TEMPLATE
      #{@thoughts}
       #{@thoughts}
        #{@thoughts}
          ( )___( )
          /__#{@eyes}   \\
         ( \\/     )
         | `=/    |
        /   #{@tongue}    \\
       /  /    \\   \\
      /  (      \\   \\ 
     ( ,_/_      \\   \\
      \\_ '=       \\   )
        ""'       /  /
        ;        /  /'?
        :       (((( /
         `._   \\  _ (
          __|   |  /_    
        ("__,.."'_._.)
        TEMPLATE
      end
    end

  end
end