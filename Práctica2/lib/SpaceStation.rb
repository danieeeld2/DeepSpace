#encoding: utf-8

require_relative 'SuppliesPackage'
require_relative 'Hangar'
require_relative 'Damage'
require_relative 'Weapon'
require_relative 'WeaponType'
require_relative 'Loot'
require_relative 'ShieldBooster'
require_relative 'CardDealer'
require_relative 'SpaceStationToUI'

module Deepspace
  class SpaceStation
    # Atributos de clase
    # @!attribute [Integer] Máxima cantidad de unidades de combustible que puede tener una estación
    @@MAXFUEL = 100

    # @!attribute[Float] Unidades de escudo que se pierden por cada unidad de potencia de disparo recibida
    @@SHIELDLOSSPERUNITSHOT = 0.1

    # Constructor
    # @param n [String] nombre de la estación
    # @param s [SuppliesPackage]
    def initialize(n, s)
      # @!attribute [String] nombre de la estación
      @name = n

      # @!attribute [Float] ammoPower
      @ammoPower = 0.0

      # @!attribute [Float] fuelUnits
      @fuelUnits = 0.0

      # @!attribute [Integer] nMedals
      @nMedals = 0

      # @!attribute [FLoat] shieldPower
      @shieldPower = 0.0

      # @!attribute [Damage] Daño pendiente
      @pendingDamage = nil

      # @!attribute [Array<Weapon>] Array de armas
      @weapons = []

      # @!attribute [Array<ShieldBooster>] Array de escudos
      @shieldBoosters = []

      # @!attribute [Hangar]
      @hangar = nil

      # Añadimos los supplies
      reciveSupplies(s)
    end

    # Getters
    attr_reader :name, :ammoPower, :fuelUnits, :nMedals, :shieldPower, :pendingDamage, :weapons, :shieldBoosters, :hangar

    # Fija la cantidad de combustible
    # @param f [Float] Cantidad de combustible
    # @note no debe exceder el límite
    def assignFuelValue(f)
      if f <= @@MAXFUEL
        @fuelUnits = f
      else
        @fuelUnits = @@MAXFUEL
      end
    end

    # Si el daño pendiente no tiene efecto fija la referencia a nulo
    def cleanPendingDamage
      if @pendingDamage != nil
        if @pendingDamage.hasNoEffect
          @pendingDamage = nil
        end
      end
    end

    # Si se dispone de hangar, devuelve el resultado de intentar añadir un arma al mismo
    # @param w [Weapon] arma a añadir
    # @return [Boolean]  el resultado. Si no se dispone de hangar retorna false
    def receiveWeapon(w)
      if @hangar == nil
        return false
      else
        return @hangar.addWeapon(w)
      end
    end

    # Si se dispone de hangar, devuelve el resultado de intentar añadir el potenciador de escudo al mismo
    # @param s [ShieldBooster] potenciador de escudo
    # @return [Boolean] el resultado. Si no se dispone de hangar devuelve false
    def receiveShieldBooster(s)
      if @hangar == nil
        return false
      else
        return @hangar.addShieldBooster(s)
      end
    end

    # Recibe un hangar
    # Si no se dispone de hangar, se coloca el nuevo. Si ya se tiene hangar, no hace nada
    # @param h [Hangar] hangar a recibir
    def receiveHangar(h)
      if @hangar == nil
        @hangar = h
      end
    end

    # Fija la referencia de hangar a null
    def discardHangar
      @hangar = nil
    end

    # Incrementan los valores de los atributos según el contenido del paquete
    # @param s [SuppliesPackage] paquete
    def receiveSupplies(s)
      @ammoPower += s.ammoPower
      assignFuelValue(@fuelUnits + s.fuelUnits)
      @shieldPower += s.shieldPower
    end

    # Se calcula el parámetro ajustado y se almacena en elsitio correspondiente
    # @param d [Damage] daño
    def setPendingDamage(d)
      if d != nil
        @pendingDamage = d.adjust(@weapons, @shieldBoosters)
      end
    end

    # Intenta montar un arma del hangar en la estación
    # @param i [Integer] índice del arma del hangar
    def mountWeapon(i)
      if i >= 0 && i < @hangar.weapons.length
        if !@hangar.nil?
          new_weapon = @hangar.removeWeapon(i)
          if !new_weapon.nil?
            @weapons << new_weapon
          end
        end
      end
    end

    # Intenta montar un escudo del hangar en la estación
    # @param i [Integer] índice del escudo
    def mountShieldBooster(i)
      if i >= 0 && i < @hangar.shieldBoosters.length
        if !@hangar.nil?
          new_shield = @hangar.removeShieldBooster(i)
          if !new_shield.nil?
            @shieldBoosters << new_shield
          end
        end
      end
    end

    # Solicita descartar un arma del hangar
    # @param i [Integer] índice del arma a descartar
    def discardWeaponInHangar(i)
      if !@hangar.nil?
        @hangar.removeWeapon(i)
      end
    end

    # Solicita descartar un escudo del hangar
    # @param i [Integer] índice del arma a descartar
    def discardShieldBoosterInHangar(i)
      if !@hangar.nil?
        @hangar.removeShieldBooster(i)
      end
    end

    # Consulta la velocidad de la estación espacial
    def getSpeed
      if @@MAXFUEL == 0
        raise "Zero division at SpaceStation.speed(): MAXFUEL cannot be zero"
        return 0
      else
        return @fuelUnits.to_f / @@MAXFUEL
      end
    end

    # Decremente las unidades de combustible como consecuencia del desplazamiento
    def move
      @fuelUnits -= @fuelUnits * speed
      if @fuelUnits < 0
        @fuelUnits = 0
      end
    end

    # Comprueba si la estación espacial está en un estado válido
    def validState
      if @pendingDamage.nil?
        return true
      else
        return @pendingDamage.hasNoEffect
      end
    end

    # Elimina armas y escudos sin usos restantes
    def cleanUpMountedItems
      @weapons = @weapons.select { |weapon| weapon.uses > 0 }
      @shieldBoosters = @shieldBoosters.select { |shield| shield.uses > 0 }
    end

    # String representation of the object
    # @return [String] string representation
    def to_s
      getUIversion().to_s
    end

    # To UI
    def getUIversion
      return SpaceStationToUI.new(self)
    end

    private :assignFuelValue, :cleanPendingDamage
  end
end