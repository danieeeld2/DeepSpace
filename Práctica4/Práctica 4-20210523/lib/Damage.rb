#encoding:utf-8

require_relative 'WeaponType'
require_relative 'Weapon'
require_relative 'DamageToUI'

module Deepspace
  class Damage
    # Constructor
    # @param _nWeapons [Integer] numero de armas que se pierden
    # @param _nShields [Integer] numero de escudos que se pierden
    # @param _weapons [Array<WeaponType>] array de armas que se pierden
    def initialize(_nWeapons, _nShields, _weapons)
      # @!attribute [Integer] numero de armas que se pierden
      @nWeapons = _nWeapons

      # @!attribute [Integer] numero de escudos que se pierden
      @nShields = _nShields

      # @!attribute [Array<WeaponType>] array de armas que se pierden
      @weapons = _weapons
    end

    # Constructor
    # @param _nWeapons [Integer] numero de armas que se pierden
    # @param _nShields [Integer] numero de escudos que se pierden
    def self.newNumericWeapons(_nWeapons, _nShields)
      return new(_nWeapons, _nShields, nil)
    end

    # Constructor
    # @param _weapons [Array<WeaponType>] array de armas que se pierden
    # @param _nShields [Integer] numero de armas que se pierden
    def self.newSpecificWeapons(_weapons, _nShields)
      return new(-1, _nShields, _weapons)
    end

    # Constructor de copia
    # @param d [Damage] instancia a copiar
    # @return [Damage] la copia
    def self.newCopy(d)
      if d.nWeapons == -1
        return newSpecificWeapons(d.weapons, d.nShields)
      else
        return newNumericWeapons(d.nWeapons, d.nShields)
      end
    end

    attr_reader :nWeapons, :nShields, :weapons

    # Comprube si el daño hace efecto
    # @return [Boolean] true en caso afirmativo, false en caso contraio
    def hasNoEffect
      if @nWeapons == -1
        return @weapons.empty? && @nShields == 0
      else
        return @nShields + @nWeapons == 0
      end
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
    # @return [Damage] la copia ajustada
    def adjust(w, s)
      if @nWeapons == -1

        weapons_copy = @weapons.clone

        new_weapons = w.map do |weapon|
          weapons_copy.delete_at(weapons_copy.index(weapon.type) || weapons_copy.length)
        end

        new_weapons.compact!

        self.class.newSpecificWeapons(new_weapons, [@nShields, s.length].min)
      else
        self.class.newNumericWeapons([@nWeapons, w.length].min, [@nShields, s.length].min)
      end
    end

    # Elimina un arma. Si no hay disponible una lista de armas, decrementa el número de armas en uno
    # Si hay una lista, busca la primera ocurrencia de tipo de arma y elimina dicha pisicion
    # @param w [Weapon] el arma a eliminar
    def discardWeapon(w)
      if @nWeapons == -1
        if @weapons.length != 0
          position = @weapons.index(w.type)
          if position != nil
            @weapons.delete_at(position)
          else
            raise "WARNING! No weapon type match at Damage.discardWeapon()"
          end
        end
      else
        if @nWeapons > 0
          @nWeapons -= 1
        else
          raise "WARNING! You tried to have negative weapons at Damage.discardWeapon()"
        end
      end
    end

    # Elimina un escudo
    def discardShieldBooster
      if @nShields > 0
        @nShields -= 1
      else
        raise "WARNING! You tried to have negative shieldBoosters at Damage.discardShieldBooster()"
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
      return DamageToUI.new(self)
    end

    # Visibility specifiers
    # ==========================================================================
    private :arrayContainsType
    private_class_method :new

  end
end	 
