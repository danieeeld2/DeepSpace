#encondig:utf-8

require_relative 'GameCharacter'

module Deepspace
  class Dice

    # Constructor
    def initialize
      # @!attribute [Float] Probabilidad de hangar
      @NHANGARSPROB = 0.25

      # @!attribute [Float] Probabilidad de escudo
      @NSHIELDSPROB = 0.25

      # @!attribute [Float] Probabilidad de arma
      @NWEAPONSPROB = 0.33

      # @!attribute [Float] Probabilidad de primer disparo
      @FIRSTSHOTPROB = 0.5

      # @!attribute [Random] Generador de números aleatorios
      @generator = Random.new()
    end

    # Determina el número de hangares que recibirá la estación
    # @return [Integer] número de hangares
    def initWithNHangars
      if @generator.rand <= @NHANGARSPROB
        return 0
      else
        return 1
      end
    end

    # Determina el número de armas que recibirá la estación
    # @return [Integer] número de armas
    def initWithNWeapons
      randval = @generator.rand

      if randval <= @NWEAPONSPROB
        return 1
      elsif randval <= @NWEAPONSPROB * 2
        return 2
      else
        return 3
      end
    end

    # Determina el número de escudos que recibirá la estación
    # @return [Integer] número de escudos
    def initWithNShields
      if @generator.rand <= @NSHIELDSPROB
        return 0
      else
        return 1
      end
    end

    # Determina el jugador que coienza la partida
    # @param nPlayers [Integer] numero de jugadores
    # @return [Integer] el número de jugador que empieza
    def whoStarts(nPlayers)
      return @generator.rand(nPlayers)
    end

    # Determina quien dispara antes si la estación o el enemigo
    # @return [GameCharacter] quien dispara
    def firstShot
      if @generator.rand <= @FIRSTSHOTPROB
        return GameCharacter::SPACESTATION
      else
        return GameCharacter::ENEMYSTARSHIP
      end

      # Security check
      raise "WARNING! Unexpected condition at Dice.firstShot"

    end

    # Determina si la estación espacial evade o no un disparo
    # @param speed [Float] velocidad de la estación
    # @return [Boolean] true en caso afirmativo, false en caso negativo
    def spaceStationMoves(speed)
      return @generator.rand < speed
    end

  end
end  
