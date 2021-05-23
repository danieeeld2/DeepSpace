#encoding:utf-8

require_relative 'Weapon'
require_relative 'ShieldBooster'
require_relative 'WeaponType'
require_relative 'HangarToUI'

module Deepspace
  class Hangar

    # Constructores
    # @param capacity [Integer] máximo número de escudos y armas que caben en el hangar
    def initialize(capacity)
      # @!attribute [Integer] espacio del hangar
      @maxElements = capacity

      # @!attribute [Array<ShieldBooster>] array de escudos almacenados en el hangar
      @shieldBoosters = []

      # @!attribute [Array<Weapon>] array de armas almacenada en el hangar
      @weapons = []
    end

    # Constructor de copia
    # @param d [Hangar] instancia a copiar
    def self.newCopy(h)
      copy = new(h.maxElements)

      for shieldBooster in h.shieldBoosters
        copy.addShieldBooster(shieldBooster)
      end

      for weapon in h.weapons
        copy.addWeapon(weapon)
      end

      return copy
    end

    attr_reader :shieldBoosters, :weapons, :maxElements

    # Comprueba si queda espacio en el hangar
    # @return [Boolean] true en caso afirmativo, false en caso contrario
    def spaceAvailable
      return @maxElements > @weapons.length + @shieldBoosters.length
    end

    # Añade un nuevo arma al hangar
    # @param w [Weapon] arma a añadir
    # @return [Boolean] true en caso de que se añada correctamente false en caso contario
    def addWeapon(w)
      if spaceAvailable
        @weapons << w
        return true
      else
        return false
      end
    end

    # Elimina un arma del hangar
    # @param w [Integer] posicion del arma a eliminar
    # @return [Weapon] arma eliminada. Si no se encuentra el arma devuelve nil
    def removeWeapon(w)
      if w < @weapons.length && w >= 0
        return @weapons.delete_at(w)
      else
        return nil
      end
    end

    # Añade un nuevo potenciador de escudo al hangar
    # @param w [ShieldBooster] potenciador a ser añadido
    # @return [Boolean] true en caso de que se añada con exito, false en caso contrario
    def addShieldBooster(s)
      if spaceAvailable
        @shieldBoosters << s
        return true
      else
        return false
      end
    end

    # Elimina un escudo del hangar
    # @param s [Integer] posicion en el hangar del escudo a eliminar
    # @return [ShieldBooster] escudo eliminado. Si no es encuentra devuelve nil
    def removeShieldBooster(s)
      if s < @shieldBoosters.length && s >= 0
        return @shieldBoosters.delete_at(s)
      else
        return nil
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
      return HangarToUI.new(self)
    end
  end
end  

