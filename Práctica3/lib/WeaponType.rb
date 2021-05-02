#encoding:utf-8

module Deepspace
  module WeaponType

    class Type

      def initialize(pow, _name)
        @POWER = pow
        @name = _name
      end

      def power
        return @POWER
      end

      def to_s
        return "#{@name}"
      end
    end

    LASER = Type.new(2.0, "LASER")
    MISSILE = Type.new(3.0, "MISSILE")
    PLASMA = Type.new(4.0, "PLASMA")
  end
end
    
