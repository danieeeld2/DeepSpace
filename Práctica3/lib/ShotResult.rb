#encoding: utf-8

# Enumerado que representa el resultado de un disparo recibido 
# por una nave enemiga o de la estación

module Deepspace
    module ShotResult
        DONOTRESIST= :donotresist 
        RESIST= :resist 
    end
end

# Código de comprobación
# puts Deepspace::ShotResult::RESIST