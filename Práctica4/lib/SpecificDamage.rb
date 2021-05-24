#encoding:utf-8

require_relative 'Damage'
require_relative 'SpecificDamageToUI'

module Deepspace
  # Clase que representa un daño específico
  class SpecificDamage < Damage
    public_class_method :new

    # Constructor
    # @param _nShields [Integer] numero de escudos que se pierden
    # @param _weapons [Array<WeaponType>] array de armas que se pierden
    def initialize(_weapons, _nShields)
      super(_nShields)

      # @!attribute [Array<WeaponType>] array de armas que se pierden
      @weapons = []
    end

    # Getters
    attr_reader :weapons

    # Comprube si el daño hace efecto
    # @return [Boolean] true en caso afirmativo, false en caso contrario
    # --Overriden
    def hasNoEffect
      (super && @weapons.length == 0)
    end

    # Busca en un vector de armas dados la primera coincidencia con el tipo de arma dado
    # @param w [Array<Weapon>] el array de armas
    # @param t [WeaponType] el tipo de arma
    # @return [Integer] la posicion del arma. Si no se encuentra devuelve -1
    def arrayContainsType(w, t)
      i = 0
      w.each do |weapon_aux|
        if weapon_aux.type == t
          return i
        else
          i += 1
        end
      end

      # No element found
      return -1
    end

    # Crea un parametro ajustado a las instancias pasadas como argumentos
    # @param w [Array<Weapon>] el array de armas a ajustar
    # @param s [Array<ShieldBooster>] el array de escudos a ajustar
    # @return [SpecificDamage] la copia ajustada
    # --Overriden
    def adjust(w, s)
      weapons_copy = @weapons.clone

      new_weapons = w.map do |weapon|
        weapons_copy.delete_at(weapons_copy.index(weapon.type) || weapons_copy.length)
      end

      new_weapons.compact!

      self.class.new(new_weapons, super(s))
    end

    # Devuelve una copia de la instancia actual
    # @return [SpecificDamage] copia
    def copy
      self.class.new(weapons, nShields)
    end

    # Elimina un arma
    # Busca la primera ocurrencia de tipo de arma y elimina dicha pisicion
    # @param w [Weapon] el arma a eliminar
    def discardWeapon(w)
      if @weapons.length != 0
        position = @weapons.index(w.type)
        if position != nil
          @weapons.delete_at(position)
        else
          raise "WARNING! No weapon type match at Damage.discardWeapon()"
        end
      end
    end

    # String representation of the object
    # @return [String] string representation
    def to_s
      message = "[Specific Damage] -> Shields: #{@nShields}, Weapon types: " + getWeaponInfo
      return message
    end

    # To UI
    def getUIversion
      return SpecificDamageToUI.new(self)
    end
  end
end
