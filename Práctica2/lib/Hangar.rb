#enconding: utf-8

require_relative 'HangarToUI'
require_relative 'Weapon'
require_relative 'ShieldBooster'
require_relative 'WeaponType'

module Deepspace
  # Clase que representa un determinado hangar
  class Hangar
    # Constructor
    # @param capacity [Integer] máximo número de escudos y armas (combinados)
    def initialize(capacity)
      # @!attribute máximo número de escudos y armas (combinados) que puede tener la estación
      @maxElements = capacity

      # @!attribute array con los shieldbossters que tiene el hangar
      @shieldBoosters = []

      # @!attribute array con las weapons que tiene el hangar
      @weapons = []
    end

    # Constructor de copia
    # @param h [Hangar] hangar a copiar
    def self.newCopy(h)
      copy = new(h.maxElements)

      h.shieldBoosters.each do |shieldBooster|
        copy.addShieldBooster(shieldBooster)
      end

      h.weapons.each do |weapon|
        copy.addWeapon(weapon)
      end
    end

    # Getters
    # Podemos crearlo automáticamente con attr_reader
    # attr_reader -> gets attr_writer-> modificador attr_accerssor -> ambos
    attr_reader :shieldBoosters, :weapons, :maxElements

    # Comprueba si aún hay espacio para añadir elementos
    # @return [Boolean]
    def spaceAvailable
      return @maxElements > @weapons.length + @shieldBoosters.length
    end

    #Setters

    # Añade un arma al estación
    # @param w [Weapon] el arma a añadir
    # @return [Boolean] true si es posible, false en caso contrario
    def addWeapon(w)
      if spaceAvailable
        @weapons << w
        return true
      else
        return false
      end
    end

    # Elimina un arma al hangar
    # @param w [Integer] número del arma a eliminar (su posición en el array)
    # @return [Weapon] devuelve el arma, si es posible. En caso contrario, devuelve nil
    def removeWeapon(w)
      if w < @weapons.length && w >= 0
        return @weapons.delete_at(w)
      else
        return nil
      end
    end

    # Añade un pontenciador de escudo al hangar
    # @param s [ShieldBooster] escudo a añadir
    # @return [Boolean] true si es posible, false en caso contrario
    def addShieldBooster(s)
      if spaceAvailable
        @shieldBoosters << s
        return true
      else
        return false
      end
    end

    # Elimina un potenciador de escudo del hangar
    # @param s [Integer] posición del escudo a eliminar
    # @return [ShieldBooster] el escudo en cuestión, si es posible. EN caso contario, nill
    def removeShieldBooster(s)
      if s >= 0 && s < @shieldBoosters.length
        return @shieldBoosters.delete_at(s)
      else
        return nil
      end
    end

    # String representation
    # @return [String] representacion
    def to_s
      getUIversion().to_s
    end

    # To UI
    def getUIversion
      return HangarToUI.new(self)
    end
  end

end
