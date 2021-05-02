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
    def haveAWinner
      if !@currentStation.nil?
        if @currentStation.nMedals >= @@WIN
          return true
        else
          return false
        end
      end
    end

    ######## Métodos Prñactica 3 ############

    # Descarta un arma de la estación espacial
    # Solo lo hace si el estado del juego es INIT o AFTERCOMBAT
    # @param i [Integer] índice del arma a descartar
    def discardWeapon(i)
      if state == GameState::INIT or GameState::AFTERCOMBAT
        @currentStation.discardWeapon(i)
      end
    end

    # Descarta un escudo de la estación espacial
    # Solo lo hace si el estado del juego es INIT o AFTERCOMBAT
    # @param i [Integer] índice del escudo a descartar
    def discardShieldBooster(i)
      if state == GameState::INIT or GameState::AFTERCOMBAT
        @currentStation.discardShieldBooster(i)
      end
    end

    # Inicia una partida
    # @param names [Array<String>] nombres de los jugadores
    # A cada jugador se le crea una estación espacial con los objetos necesarios
    # Tambíen establece el primer enemigo y quien empieza la partida
    def init(names)
      if state == GameState::CANNOTPLAY
        dealer = CardDealer.instance
        names.each do |name|
          supplies = dealer.nextSuppliesPackage
          station = SpaceStation.new(name, supplies)
          @spaceStations << station

          nh = @dice.initWithNHangars
          nw = @dice.initWithNWeapons
          ns = @dice.initWithNShields

          lo = Loot.new(0, nw, ns, nh, 0)
          station.setLoot(lo)
        end

        @currentStationIndex = @dice.whoStarts(names.length)
        @currentStation = @spaceStations[@currentStationIndex]
        @currentEnemy = dealer.nextEnemy

        @gameState.next(@turns, @spaceStations.length)
      end
    end

    # Realiza el cambio de turno
    # Debe comprobar que el jugador actual no tiene daño pendiente
    # @return [Boolean] true si se cambia el turno, false en caso contrario
    def nextTurn
      if state == GameState::AFTERCOMBAT
        if @currentStation.validState
          @currentStationIndex = (@currentStationIndex + 1) % @spaceStations.length
          @turns += 1

          @currentStation = @spaceStations[@currentStationIndex]
          @currentStation.cleanUpMountedItems

          dealer = CardDealer.instance
          @currentEnemy = dealer.nextEnemy

          @gameState.next(@turns, @spaceStations.length)
          return true
        end
        return false
      end
      return false
    end

    # Se realiza un combate entre la estación espacial y el enemigo
    # @param station [SpaceSttion] estación espacial
    # @param enemy [EnemyStarShip] enemgo
    # @return [CombatResult] resultado del combate
    def combatGo(station, enemy)
      ch = @dice.firstShot

      if ch == GameCharacter::ENEMYSTARSHIP
        fire = enemy.fire
        result station.receiveShot(fire)
        if result == ShotResult::RESIST
          fire = @currentStation.fire
          result = enemy.receiveShot(fire)
          enemyWins = (result == ShotResult::RESIST)
        else
          enemyWins = true
        end
      else
        fire = station.fire
        result = enemy.receiveShot(fire)
        enemyWins = (result == ShotResult::RESIST)
      end

      if enemyWins
        s = station.speed
        moves = @dice.spaceStationMoves(speed)
        if !moves
          damage = enemy.damage
          station.setPendingDamage(damage)
          combatResult = CombatResult::ENEMYWINS
        else
          station.move
          combatResult = CombatResult::STATIONESCAPES
        end
      else
        aLoot = enemy.loot
        station.setLoot(aLoot)
        combatResult = CombatResult::STATIONWINS
      end

      @gameState.next(@turns, @spaceStations.length)
      return combatResult
    end

    # Realiza un combate, si el juego se encuentra en un estado permitidp
    def combat
      if state == GameState::BEFORECOMBAT or GameState::INIT
        return combatGo(@currentStation, @currentEnemy)
      else
        return CombatResult::NOCOMBAT
      end
    end

  end
end

# Código de prueba
# No se puede comprobar hasta más adelante
