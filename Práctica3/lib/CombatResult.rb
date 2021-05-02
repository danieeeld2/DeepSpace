#encoding: utf-8

# Enumerado que representa todos los resultados posibles de un combate
# ente una estación espacial y una nave enemiga

module Deepspace
    module CombatResult
        ENEMYWINS= :enemywins
        NOCOMBAT= :nocombat
        STATIONESCAPES= :stationescapes 
        STATIONWINS= :stationwins
    end
end

# Código de comprobación
# puts Deepspace::CombatResult::NOCOMBAT