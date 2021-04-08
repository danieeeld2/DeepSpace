#encoding: utf-8

# Representa a los tipos de arma del juego. Cda tipo tendrá 
# un valor numérico asociado a la potencia de disparo

module Deepspace
    module WeaponType
        class Type
            def initialize(p)   #Constructor
                @power = p
            end

            def power           # Método get
                @power
            end
        end

        LASE=Type.new(2.0)
        MISSILE=Type.new(3.0)
        PLASMA=Type.new(4.0)
    end
end

# Código de comprobación
#puts Deepspace::WeaponType::PLASMA.power