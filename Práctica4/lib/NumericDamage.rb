#encoding:utf-8

require_relative 'Damage'
require_relative 'NumericDamageToUI'

module Deepspace
  # Clase que representa un daño numérico
  class NumericDamage < Damage
    public_class_method :new

    # Constructor
    # @param _nWeapons [Integer] numero de armas que se pierden
    # @param _nShields [Integer] numero de escudos que se pierden
    def initialize(_nWeapons, _nShields)
      super(_nShields)

      # @!attribute [Integer] numero de armas que se pierden
      @nWeapons = _nWeapons
    end

    # Getters
    attr_reader :nWeapons

    # Comprube si el daño hace efecto
    # @return [Boolean] true en caso afirmativo, false en caso contrario
    # --Overriden
    def hasNoEffect
      (super && @nWeapons == 0)
    end

    # Crea un parametro ajustado a las instancias pasadas como argumentos
    # @param w [Array<Weapon>] el array de armas a ajustar
    # @param s [Array<ShieldBooster>] el array de escudos a ajustar
    # @return [NumericDamage] la copia ajustada
    def adjust(w, s)
      self.class.new([@nWeapons, w.length].min, super(s))
    end

    # Devuelve una copia de la instancia actual
    # @return [NumericDamage] copia
    def copy
      self.class.new(nWeapons, nShields)
    end

    # Elimina un arma
    # Decrementa el contador de armas en uno
    # @param w [Weapon] arma
    def discardWeapon(w)
      if @nWeapons > 0
        @nWeapons -= 1
      end
    end

    # String representation of the object
    # @return [String] string representation
    def to_s
      message = "[Numeric Damage] -> Weapons: #{@nWeapons}, Shields: #{@nShields}"
      message
    end

    # To UI
    def getUIversion
      NumericDamageToUI.new(self)
    end
  end
end
