#encoding:utf-8

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
require_relative 'Transformation'
require_relative 'PowerEfficientSpaceStation'
require_relative 'BetaPowerEfficientSpaceStation'
require_relative 'SpaceCity'
module Deepspace
  class GameUniverse

    # @!attribute [Integer] cantidad de medallas necesarias para ganar
    @@WIN = 10

    # Constructor
    def initialize
      # @!attribute [GameStateController] estado de la partida
      @gameState = GameStateController.new

      # @!attribute [Integer] numero de turnos transcurridos
      @turns = 0

      # @!attribute [Dice] game dice
      @dice = Dice.new

      # @!attribute [Integer] indice de la estación espacial en juego
      @currentStationIndex = -1

      # @!attribute [SpaceStation] estación espacial actual
      @currentStation = nil

      # @!attribute [Array<SpaceStation>] array de todas las estaciones espaciales de la partida
      @spaceStations = []

      # @!attribute [EnemyStarShip] enemigo actual
      @currentEnemy = nil

      # @!attribute [Boolean] si existe ciudad espacial o no
      @haveSpaceCity = false
    end

    # Getter for gameState
    # @return [GameState] gameState
    def state
      return @gameState.state
    end

    # Elimina el hangar de la actual estación espacial
    # Solo es posible hacerlo durante la fase de INIT o AFTERCOMBAT
    def discardHangar
      if state == GameState::INIT or GameState::AFTERCOMBAT
        @currentStation.discardHangar
      end
    end

    # Elimina un escudo montado de la estación espacial actual
    # Solo es posible hacerlo durante la fase de INIT o AFTERCOMBAT
    # @param i [Integer] posicion del escudo a eliminar
    def discardShieldBooster(i)
      if state == GameState::INIT or GameState::AFTERCOMBAT
        @currentStation.discardShieldBooster(i)
      end
    end

    # Elimina un escudo almacenado en el hangar de la estación espacial actual
    # Solo es posible hacerlo durante la fase de INIT o AFTERCOMBAT
    # @param i [Integer] posicion del escudo a eliminar
    def discardShieldBoosterInHangar(i)
      if state == GameState::INIT or GameState::AFTERCOMBAT
        @currentStation.discardShieldBoosterInHangar(i)
      end
    end

    # Elimina un arma montada de la estación espacial actual
    # Solo es posible hacerlo durante la fase de INIT o AFTERCOMBAT
    # @param i [Integer] posicion del arma a eliinar
    def discardWeapon(i)
      if state == GameState::INIT or GameState::AFTERCOMBAT
        @currentStation.discardWeapon(i)
      end
    end

    # Elimina un arma almacenada en el hangar de la actual estación espacial
    # Solo es posible hacerlo durante la fase de INIT o AFTERCOMBAT
    # @param i [Integer] posicion del arma a descartar
    def discardWeaponInHangar(i)
      if state == GameState::INIT or GameState::AFTERCOMBAT
        @currentStation.discardWeaponInHangar(i)
      end
    end

    # Monta un escudo del hangar en la estación
    # # Solo es posible hacerlo durante la fase de INIT o AFTERCOMBAT
    # @param i [Integer] posicion en el hangar del escudo a montar
    def mountShieldBooster(i)
      if state == GameState::INIT or GameState::AFTERCOMBAT
        @currentStation.mountShieldBooster(i)
      end
    end

    # Monta un arma del hangar en la estación espacial
    # Solo es posible hacerlo durante la fase de INIT o AFTERCOMBAT
    # @param i [Integer] posicion en el hangar del arma a montar
    def mountWeapon(i)
      if state == GameState::INIT or GameState::AFTERCOMBAT
        @currentStation.mountWeapon(i)
      end
    end

    # Comprueba si la estación espacial actual ha ganado o no
    # @return [Boolean] true en caso afirmativo, false en caso contrario
    def haveAWinner
      if @currentStation.nil?
        raise "Warning! @currentStation nil on GameUniverse.haveAWinner()"
      else
        if @currentStation.nMedals >= @@WIN
          return true
        else
          return false
        end
      end
    end

    # Inicializa un partida
    # @param names [Array<String>] array con los nombres de los jugadores
    def init(names)
      # state = @gameState.state

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

        nPlayers = names.length
        @currentStationIndex = @dice.whoStarts(nPlayers)
        @currentStation = @spaceStations[@currentStationIndex]
        @currentEnemy = dealer.nextEnemy

        @gameState.next(@turns, @spaceStations.length)
      end
    end

    # Si no existe daño pendiente, pasa al siguiente jugador
    # @return [Boolean] true en caso de poder pasar de turno, false en caso contrario
    def nextTurn
      # state = @gameState.state

      if state == GameState::AFTERCOMBAT
        stationState = @currentStation.validState

        if stationState
          @currentStationIndex = (@currentStationIndex + 1) \
						             % @spaceStations.length
          @turns += 1

          @currentStation = @spaceStations[@currentStationIndex]
          @currentStation.cleanUpMountedItems

          dealer = CardDealer.instance # behaviour introduced by Singleton
          @currentEnemy = dealer.nextEnemy

          @gameState.next(@turns, @spaceStations.length)

          return true
        end

        return false
      end

      return false
    end

    # Combate entre una estación y una nave enemiga
    # @return [CombatResult] resultado de la batalla
    def combat
      # state = @gameState.state

      if state == GameState::BEFORECOMBAT or GameState::INIT
        return combatGo(@currentStation, @currentEnemy)
      else
        return CombatResult::NOCOMBAT
      end
    end

    # Ejecución del combate
    # @param station [SpaceStation] estación en combate
    # @param enemy [EnemyStarShip] enemigo en combate
    # @return [CombatResult] resultado del combate
    def combatGo(station, enemy)
      ch = @dice.firstShot

      if ch == GameCharacter::ENEMYSTARSHIP
        fire = enemy.fire
        result = station.receiveShot(fire)

        if result == ShotResult::RESIST
          fire = station.fire
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
        moves = @dice.spaceStationMoves(s)

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
        transformation = station.setLoot(aLoot)

        if transformation == Transformation::GETEFFICIENT
          makeStationEfficient
          combatResult = CombatResult::STATIONWINSANDCONVERTS
        elsif transformation == Transformation::SPACECITY
          createSpaceCity
          combatResult = CombatResult::STATIONWINSANDCONVERTS
        else
          combatResult = CombatResult::STATIONWINS
        end
      end

      @gameState.next(@turns, @spaceStations.length)

      return combatResult
    end

    # Crea una ciudad espacial
    def createSpaceCity
      if !@haveSpaceCity
        others = []

        for station in @spaceStations
          if station != @currentStation
            others << station
          end
        end

        @currentStation = SpaceCity.new(@currentStation, others)
        @spaceStations[@currentStationIndex] = @currentStation
        @haveSpaceCity = true
      end
    end

    # Crea una estación espacial eficiente
    def makeStationEfficient
      if @dice.extraEfficiency
        @currentStation = BetaPowerEfficientSpaceStation.new(@currentStation)
      else
        @currentStation = PowerEfficientSpaceStation.new(@currentStation)
      end

      @spaceStations[@currentStationIndex] = @currentStation
    end

    # String representation, UI version
    # ==========================================================================

    # String representation of the object
    # @return [String] string representation
    def to_s
      message = "[GameUniverse] -> Game state: #{@gameState.to_s}," \
				 + "Turns: #{@turns}, Dice: #{@dice.to_s}\n" \
				 + "\tCurrent station: #{@currentStation.to_s}\n" \
				 + "\tCurrent enemy: #{@currentEnemy.to_s}"
      message
    end

    # To UI
    def getUIversion
      return EnemyToUI.new(self)
    end

    # Description:
    # 	Gets the UI representation of the object
    # Returns:
    # 	GameUniverseToUI: the UI representation
    def getUIversion
      return GameUniverseToUI.new(@currentStation, @currentEnemy)
    end
  end

end 
