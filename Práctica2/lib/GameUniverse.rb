#encoding: utf-8

require_relative 'GameUniverseToUI'
require_relative 'GameStateController'
require_relative 'Dice'
require_relative 'Loot'
require_relative 'CombatResult'
require_relative 'GameCharacter'
require_relative 'ShotResult'
require_relative 'SpaceStation'
require_relative 'CardDealer'
require_relative 'EnemyStarShip'

module Deepspace
  class GameUniverse
    # @!attribute [Integer] cantidad de medallas necesarias para ganar el juego
    @@WIN = 10

    # Constructor
    def initialize
      # @!attribute [GameStateController] estado del juego
      @gameState = GameStateController.new

      # @!attribute [Integer] número de turnos
      @turns = 0

      # @!attribute [Dice] dado
      @dice = Dice.new

      # @!attribute [Integer] índice de la estación en juego
      @currentStationIndex = -1

      # @!attribute [SpaceStation] estación espacial actual
      @currentStation = nil

      # @!attribute [Array<SpaceStation>] array de las estaciones que están jugando
      @spaceStations = []

      # @!attribute [EnemyStarShip] estación enemiga actual
      @currentEnemy = nil
    end

    # Devuelve el estado de la partida
    # @return [GameState] estado
    def state
      return @gameState.state
    end

    # Descarta un hangar de la estación espacial actualmente en juego
    # Solo lo hace si el estado del juego es INIT o AFTERCOMBAT
    def discardHangar
      if state == GameState::INIT or GameState::AFTERCOMBAT
        @currentStation.discardHangar
      end
    end

    # Descarta un escudo del hangar de la estación espacial actualmente en juego
    # Solo lo hace si el estado del juego es INIT o AFTERCOMBAT
    # @param i [Integer] índice del escudo a descartar
    def discardShieldBoosterInHangar(i)
      if state == GameState::INIT or GameState::AFTERCOMBAT
        @currentStation.discardShieldBoosterInHangar(i)
      end
    end

    # Descarta un arma del hangar de la estación espacial actualmente en juego
    # Solo lo hace si el estado del juego es INIT o AFTERCOMBAT
    # @param i [Integer] índice del arma a descartar
    def discardWeaponInHangar(i)
      if state == GameState::INIT or GameState::AFTERCOMBAT
        @currentStation.discardWeaponInHangar(i)
      end
    end

    # Monta un escudo en la estación espacial actualmente en juego
    # Solo lo hace si el estado del juego es INIT o AFTERCOMBAT
    # @param i [Integer] índice donde montar el escudo
    def mountShieldBooster(i)
      if state == GameState::INIT or GameState::AFTERCOMBAT
        @currentStation.mountShieldBooster(i)
      end
    end

    # Monta un arma en la estación espacial actualmente en juego
    # Solo lo hace si el estado del juego es INIT o AFTERCOMBAT
    # @param i [Integer] índice donde montar el arma
    def mountWeapon(i)
      if state == GameState::INIT or GameState::AFTERCOMBAT
        @currentStation.mountWeapon(i)
      end
    end

    # Comprueba si la estación espacial jugando en ese turno cumple la condición de victoria
    # @return [Boolean] true en caso afirmativo, false en caso contrario
    def hasAWinner
      if !@currentStation.nil?
        if @currentStation.nMedals >= @@WIN
          return true
        else
          return false
        end
      end
    end

  end
end