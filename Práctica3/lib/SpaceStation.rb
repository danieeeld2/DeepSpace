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
      receiveSupplies(s)
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
      if !@pendingDamage.nil?
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
      if !d.nil?
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
      @fuelUnits -= @fuelUnits * getSpeed
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

    ########### Métodos Práctica 3 ###############

    # Realiza un disparo
    # @return [Float] la potencia de disparo
    def fire
      factor = 1.0
      @weapons.each do |w|
        factor *= w.useIt
      end
      return factor
    end

    # Usa el escudo de protección
    # @return [Float] Energía del escudo
    def protection
      factor = 1.0
      @shieldBoosters.each do |s|
        factor *= s.useIt
      end
      return factor
    end

    # Realiza las operaciones relacionadas con la recepción de un impacto enemigo
    # @param shot [Float] disparo enemigo
    # @return [ShotResult] resultado del disparo
    def receiveShot(shot)
      if protection >= shot
        @shieldPower -= @@SHIELDLOSSPERUNITSHOT*shot
        if @shieldPower<0
          @shieldPower = 0.0
        end
        return ShotResult::RESIST 
      end
      @shieldPower = 0.0
      return  ShotResult::DONOTRESIST
    end

    # Recepción de un botín
    # @param loot [Loot] botín recibido
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

      @nMedals += loot.nMedals
    end

    # Se intenta descartar el arma con índice i de la colección de armas en uso
    # Además debe actualizar el daño pendiente
    # @param i [Integer] índice del arma
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

    # Se intenta descartar el potenciador de escudo con índice i
    # Además se debe actualizar el daño pendiente
    # @param i [Integer] índice del arma
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

    private :assignFuelValue, :cleanPendingDamage
  end
end

# Código de prueba práctica 2
# supplies = Deepspace::SuppliesPackage.new(1,2,3)
# prueba = Deepspace::SpaceStation.new("Prueba",supplies)
# puts prueba.name
# puts prueba.ammoPower
# puts prueba.fuelUnits
# puts prueba.nMedals
# puts prueba.shieldPower
# puts prueba.pendingDamage
# puts prueba.weapons
# puts prueba.shieldBoosters
# puts prueba.hangar
# puts prueba.to_s
# hangar = Deepspace::Hangar.new(4)
# weapon = Deepspace::Weapon.new('arma', Deepspace::WeaponType::PLASMA, 8)
# shield = Deepspace::ShieldBooster.new('escudo', 1, 1)
# puts prueba.receiveWeapon(weapon)
# puts prueba.receiveShieldBooster(shield)
# prueba.receiveHangar(hangar)
# puts prueba.receiveWeapon(weapon)
# puts prueba.receiveShieldBooster(shield)
# puts prueba.hangar
# prueba.mountWeapon(0)
# prueba.mountShieldBooster(0)
# puts prueba.hangar
# puts prueba.weapons
# puts prueba.shieldBoosters
# prueba.discardHangar
# puts prueba.hangar
# prueba.receiveHangar(hangar)
# puts prueba.receiveWeapon(weapon)
# puts prueba.receiveShieldBooster(shield)
# puts prueba.hangar
# prueba.discardWeaponInHangar(0)
# prueba.discardShieldBoosterInHangar(0)
# puts prueba.hangar
# puts prueba.getSpeed
# puts prueba.fuelUnits
# prueba.move
# puts prueba.fuelUnits
# weapon2 = Deepspace::Weapon.new('arma', Deepspace::WeaponType::PLASMA, 0)
# puts prueba.receiveWeapon(weapon2)
# prueba.mountWeapon(0)
# puts prueba.weapons 
# puts "---"
# prueba.cleanUpMountedItems
# puts prueba.weapons
# puts prueba.validState
# damage = Deepspace::Damage.newNumericWeapons(2,2)
# prueba.setPendingDamage(damage)
# puts prueba.pendingDamage
# puts prueba.validState

# Código para práctica 3
# supplies = Deepspace::SuppliesPackage.new(1,2,3)
# prueba = Deepspace::SpaceStation.new("Prueba",supplies)
# hangar = Deepspace::Hangar.new(4)
# weapon = Deepspace::Weapon.new('arma', Deepspace::WeaponType::PLASMA, 8)
# shield = Deepspace::ShieldBooster.new('escudo', 2, 2)
# prueba.receiveHangar(hangar)
# prueba.receiveWeapon(weapon)
# prueba.receiveWeapon(weapon)
# prueba.receiveShieldBooster(shield)
# prueba.receiveShieldBooster(shield)
# prueba.mountWeapon(0)
# prueba.mountShieldBooster(0)
# prueba.mountWeapon(0)
# prueba.mountShieldBooster(0)
# puts prueba.weapons
# puts prueba.shieldBoosters
# # puts prueba.fire
# # puts prueba.protection
# puts prueba.receiveShot(2.0)
# puts prueba.shieldPower
# sp = Deepspace::SuppliesPackage.new(0,0,0)
# loot = Deepspace::Loot.new(1,2,3,4,5)
# prueba2 = Deepspace::SpaceStation.new("pruebaa",sp)
# prueba2.setLoot(loot)
# puts prueba2.to_s
# puts "____________________________________"
# puts prueba.weapons
# puts prueba.shieldBoosters
# prueba.discardWeapon(1)
# prueba.discardShieldBooster(1)
# puts prueba.to_s
