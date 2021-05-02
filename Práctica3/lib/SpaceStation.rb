#encoding:utf-8

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

    # @!attribute [Integer] Maximo de combustible permitido
    @@MAXFUEL = 100

    # @!attribute [Float] Unidades de escudo perdidaspor disparo
    @@SHIELDLOSSPERUNITSHOT = 0.1

    # Constructor
    # @param _name [String] nombre de la estación
    # @param _supplies [SuppliesPackage] paquete de ayuda inicial
    def initialize(_name, _supplies)
      # @!attribute [String] nombre de la estación
      @name = _name

      # @!attribute [Float] potencia de disparo
      @ammoPower = 0.0

      # @!attribute [Float] unidades de combustible
      @fuelUnits = 0.0

      # @!attribute [Integer] numero de medallas
      @nMedals = 0

      # @!attribute [Float] potencia de escudo
      @shieldPower = 0.0

      # @!attribute [Damage] daño pendiente
      @pendingDamage = nil

      # @!attribute [Array<Weapon>] array de armas
      @weapons = []

      # @!attribute [Array<ShieldBooster] array de escudos
      @shieldBoosters = []

      # @!attribute [Hangar] hangar
      @hangar = nil

      receiveSupplies(_supplies)
    end

    attr_reader :ammoPower, :fuelUnits, :hangar, :name, :nMedals,
                :pendingDamage, :shieldBoosters, :shieldPower, :weapons

    # Velocidad de la estación
    # @return [Float] velocidad
    def speed
      if @@MAXFUEL == 0
        raise "Zero division at SpaceStation.speed(): MAXFUEL cannot be zero"
        return 0
      else
        return @fuelUnits.to_f / @@MAXFUEL
      end
    end

    # Comprueba el estado de la estación espacial
    # @return [Boolean] true si no queda daño pendiente, false en caso contrari
    def validState
      if @pendingDamage.nil?
        return true
      else
        return @pendingDamage.hasNoEffect
      end
    end

    # Asigna unidades de combustible a la estación
    # @param f [Float] combustible a ser asignado
    def assignFuelValue(f)
      if f < @@MAXFUEL
        @fuelUnits = f
      else
        @fuelUnits = @@MAXFUEL
      end
    end

    # Almacena el daño pendiente
    # @param d [Damage] daño
    def setPendingDamage(d)
      if !d.nil?
        @pendingDamage = d.adjust(@weapons, @shieldBoosters)
      end
    end

    # Elimina el daño pendiente, si este no tiene efecto
    def cleanPendingDamage
      if !@pendingDamage.nil?
        if @pendingDamage.hasNoEffect
          @pendingDamage = nil
        end
      end
    end

    # Añade un arma al hangar
    # @param [Weapon] arma a añadir
    # @return [Boolean] true si se completa la operación con éxito, false en caso contrario
    def receiveWeapon(w)
      if !hangar.nil?
        return @hangar.addWeapon(w)
      else
        return false
      end
    end

    # Añade un escudo al hangar
    # @param [ShieldBooster] escudo a añadir
    # @return [Boolean] true si se añade con éxito, false en caso contrario
    def receiveShieldBooster(s)
      if !hangar.nil?
        return @hangar.addShieldBooster(s)
      else
        return false
      end
    end

    # Añade un hangar
    # @param h [Hangar] hangar
    def receiveHangar(h)
      if @hangar.nil?
        @hangar = h
      end
    end

    # Elimina el hangar actual
    def discardHangar
      @hangar = nil
    end

    # Elimina un arma del hangar
    # @param i [Integer] posición del arma en el hangar
    def discardWeaponInHangar(i)
      if !@hangar.nil?
        @hangar.removeWeapon(i)
        #else
        #	raise "WARNING! Trying to discard a weapon where no hangar is available, at SpaceStation.discardWeaponInHangar()"
      end
    end

    # Elimina un escudo del hangar
    # @param i [Integer] posición del escudo a eliminar
    def discardShieldBoosterInHangar(i)
      if !@hangar.nil?
        @hangar.removeShieldBooster(i)
        #else
        #	raise "WARNING! Trying to discard a shield booster where no hangar is available, at SpaceStation.discardShieldBoosterInHangar()"
      end
    end

    # Recibe suministro y los procesa
    # @param s [SuppliesPackage] suministros recibidos
    def receiveSupplies(s)
      @ammoPower += s.ammoPower
      assignFuelValue(@fuelUnits + s.fuelUnits)
      @shieldPower += s.shieldPower
    end

    # Monta un arma del hangar en la estacón
    # @param i [Integer] posición del arma a montar en el hanga
    def mountWeapon(i)
      if i >= 0 && i < @hangar.weapons.length
        if !@hangar.nil?
          # New weapon is deleted from the hangar
          new_weapon = @hangar.removeWeapon(i)
          if !new_weapon.nil?
            @weapons << new_weapon
          else
            raise "WARNING! Trying to add a nil weapon on SpaceStation.mountWeapon()"
          end
        else
          raise "WARNING! No hangar available at SpaceStation.mountWeapon()"
        end
      end
    end

    # Monta un escudo del hangar en la estación
    # @param i [Integer] posición del escudo en el hangar
    def mountShieldBooster(i)
      if i >= 0 && i < @hangar.shieldBoosters.length
        if !@hangar.nil?
          # New shield booster is deleted from the hangar
          new_shield = @hangar.removeShieldBooster(i)
          if !new_shield.nil?
            @shieldBoosters << new_shield
          else
            raise "WARNING! Trying to add a nil shield on SpaceStation.mountShieldBooster()"
          end
        else
          raise "WARNING! No hangar available at SpaceStation.mountShieldBooster()"
        end
      end
    end

    # Mueve la estación espacial
    def move
      @fuelUnits -= @fuelUnits * speed
      if @fuelUnits <= 0
        @fuelUnits = 0
      end
    end

    # Elimina las armas montadas
    def cleanUpMountedItems
      # Filtering weapons
      @weapons = @weapons.select { |weapon| weapon.uses > 0 }

      # Filtering shields
      @shieldBoosters = @shieldBoosters.select { |shield| shield.uses > 0 }
    end

    # Realiza un disparo
    # @return [Float] potencia de disparo
    def fire
      factor = 1.0

      @weapons.each do |w|
        factor *= w.useIt
      end

      return @ammoPower * factor
    end

    # Aplica protección del escudo
    # @return [Float] potencia del escudo
    def protection
      factor = 1.0

      @shieldBoosters.each do |s|
        factor *= s.useIt
      end

      return @shieldPower * factor
    end

    # Interpreta el resultado de recibir un disparo
    # @param shot [Float] disparo enemigo
    # @return [Boolean] true si resiste el impacto, false en caso contrario
    def receiveShot(shot)
      myProtection = protection

      if myProtection >= shot
        @shieldPower -= @@SHIELDLOSSPERUNITSHOT
        if @shieldPower < 0
          shieldPower = 0.0
        end

        return ShotResult::RESIST
      else
        @shieldPower = 0.0

        return ShotResult::DONOTRESIST
      end
    end

    # Recibe un loot
    # @param [Loot] loot
    def setLoot(loot)
      dealer = CardDealer.instance
      h = loot.nHangars

      if h > 0
        hangar = dealer.nextHangar
        receiveHangar(hangar)
      end

      elements = loot.nSupplies
      elements.times do
        sup = dealer.nextSuppliesPackage
        receiveSupplies(sup)
      end

      elements = loot.nWeapons
      elements.times do
        weap = dealer.nextWeapon
        receiveWeapon(weap)
      end

      elements = loot.nShields
      elements.times do
        sh = dealer.nextShieldBooster
        receiveShieldBooster(sh)
      end

      medals = loot.nMedals
      @nMedals += medals
    end

    # Descarta un arma montada en la estación espacial
    # @param i [Integer] indice del arma a descartar
    def discardWeapon(i)
      size = @weapons.length
      if i >= 0 && i < size
        w = @weapons.delete_at(i)
        if !@pendingDamage.nil?
          @pendingDamage.discardWeapon(w)
          cleanPendingDamage
        end
      end
    end

    # Descarta un escudo montado en la estación espacial
    # @param i [Integer] indice del escudo a descartar
    def discardShieldBooster(i)
      size = @shieldBoosters.length
      if i >= 0 && i < size
        s = @shieldBoosters.delete_at(i)
        if !@pendingDamage.nil?
          @pendingDamage.discardShieldBooster
          cleanPendingDamage
        end
      end
    end

    # String representation, UI version
    # ==========================================================================

    # String representation of the object
    # @return [String] string representation
    def to_s
      getUIversion().to_s
    end

    # To UI
    def getUIversion
      return SpaceStationToUI.new(self)
    end

    # Visibility specifiers
    # ==========================================================================
    private :assignFuelValue, :cleanPendingDamage
  end
end	 
