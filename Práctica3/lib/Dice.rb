#enconding: utf-8

require_relative 'GameCharacter'

# Se encarga de todo lo relacionado con el azar

module Deepspace
    class Dice  
        def initialize()
            @NHANGARSPROB=0.25
            @NSHIELDSPROB=0.25
            @NWEAPONSPROB=0.33
            @FIRSTSHOTPROB=0.5
            @generator=Random.new
        end

        # Determina el número de hangares que recibe la estación
        def initWithNHangars()
            if @generator.rand()<@NHANGARSPROB  #Si no pones argumento a rand genera x tal que 0<=x<1
                0
            else
                1
            end
        end

        # Determina el número de armas que recibirá la estación
        def initWithNWeapons()
            prob = @generator.rand()
            if prob < @NWEAPONSPROB
                return 1
            else
                if prob < 2 * @NWEAPONSPROB
                    return 2
                else
                    return 3
                end
            end
        end

        # Determina el número de potenciadores de escudo que recibirá la estación
        def initWithNShields()
            if @generator.rand() < @NSHIELDSPROB
                return 0
            else
                return 1
            end
        end

        # Define el número de jugadores
        def whoStarts(nPlayers)
            return @generator.rand(nPlayers)
        end

        # Determina quién dispara primeroen el combate
        def firstShot()
            if @generator.rand() < @FIRSTSHOTPROB
                return GameCharacter::SPACESTATION
            else
                return GameCharacter::ENEMYSTARSHIP
            end
        end

        # Determina la probabilidad de moverse de la estación espacial
        def spaceStationMoves(speed)
            if @generator.rand() < speed
                return true
            else
                return false
            end
        end
    end
end



 #Código de comprobación
 #prueba = Deepspace::Dice.new
 #puts prueba.initWithNHangars()
 #puts prueba.initWithNWeapons()
 #puts prueba.initWithNShields()
 #puts prueba.whoStarts(5)
 #puts prueba.firstShot()
 #puts prueba.spaceStationMoves(1)

