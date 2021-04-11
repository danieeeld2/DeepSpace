#enconding: utf-8

require_relative "WeaponType"

# Representa a las armas de las que puede disponer una estación 
# espacial para potenciar su energá al disparar

module Deepspace
    class Weapon 
        def initialize(a_name, a_type, a_uses)
            @name = a_name
            @type = a_type 
            @uses = a_uses 
        end

        def self.newCopy(weapon)
            new(weapon.name, weapon.type, weapon.uses)
        end

        def name 
            @name 
        end

        def type 
            @type 
        end

        def uses 
            @uses
        end

        def power()
            type.power
        end

        def useIt
            if uses > 0
                @uses-=1
                power()
            else
                1.0 
            end
        end

        # String representacion
        # @return [String] representacion
        def to_s
            getUIversion().to_s
        end

        # To UI
        def getUIversion
            return WeaponToUI.new(self)
        end
    end
end

# Código de prueba
# prueba = Deepspace::Weapon.new('prueba', Deepspace::WeaponType::PLASMA, 8)
# puts prueba.type.power
# puts prueba.power()
# puts prueba.useIt()
# prueba2 = Deepspace::Weapon.new('prueba2', Deepspace::WeaponType::LASE, 10)
# prueba3 = Deepspace::Weapon.newCopy(prueba2)
# puts prueba3.type.power
