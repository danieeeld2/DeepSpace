#encoding: utf-8

require_relative 'ShieldToUI'

# Representa a los potenciadores de escudos que pueden tener
# las naves espaciales

module Deepspace
  class ShieldBooster
    def initialize(a_name, a_boost, a_uses)
      @name = a_name
      @boost = a_boost
      @uses = a_uses
    end

    def self.newCopy(shield)
      new(shield.name, shield.boost, shield.uses)
    end

    def name
      @name
    end

    def boost
      @boost
    end

    def uses
      @uses
    end

    def useIt
      if uses > 0
        @uses -= 1
        @boost
      else
        1.0
      end
    end

    # String representation of the object
    # @return [String] string representation
    def to_s
      message = "[ShieldBooster]-> Boost: #{@boost}, Uses: #{@uses}"
      return message
    end

    # To UI
    def getUIversion
      return ShieldToUI.new(self)
    end
  end
end

# Código de prueba
# prueba =  Deepspace::ShieldBooster.new('prueba', 1, 1)
# puts prueba.name
# prueba2 = Deepspace::ShieldBooster.new('prueba2', 1, 0)
# puts prueba.uses
# pruebacopy = Deepspace::ShieldBooster.new('pruebacopy', 2, 2)
# prueba3 = Deepspace::ShieldBooster.newCopy(pruebacopy)
# puts prueba3.boost