#encoding: utf-8

# Representa el botín que se obtiene al vencer a una nave enemiga

module Deepspace
    class Loot
        def initialize(supplies, weapons, shields, hangars, medals)
            @nSupplies = supplies
            @nWeapons  = weapons
            @nShields  = shields
            @nHangars  = hangars
            @nMedals   = medals
        end

        def nSupplies
            @nSupplies
        end

        def nWeapons
            @nWeapons
        end

        def nShields
            @nShields
        end

        def nHangars
            @nHangars
        end

        def nMedals
            @nMedals
        end
        
    end
end

# Código de omprobación
#prueba = Deepspace::Loot.new(1,1,1,1,1)
#puts prueba.nHangars