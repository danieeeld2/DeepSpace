#encoding:utf-8

require_relative 'WeaponType'
require_relative 'Weapon'
require_relative 'DamageToUI'

module Deepspace
  class Damage
    # Constructor
    # @param _nShields [Integer] numero de escudos que se pierden
    def initialize(_nShields)
      # @!attribute [Integer] numero de escudos que se pierden
      @nShields = _nShields
    end

    # Getters
    attr_reader :nShields

    # Comprube si el daño hace efecto
    # @return [Boolean] true en caso afirmativo, false en caso contraio
    def hasNoEffect
      @nShields == 0
    end

    # Crea un parametro ajustado a las instancias pasadas como argumento
    # @param s [Array<ShieldBooster>] el array de escudos a ajustar
    # @return [Damage] la copia ajustada
    def adjust(s)
      [s.length, @nShields].min
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
      message = "[Damage] Number of shields: " + @nShields
      return message
    end

    # To UI
    def getUIversion
      return DamageToUI.new(self)
    end

    # Visibility specifiers
    # ==========================================================================
    private_class_method :new

  end
end	 
