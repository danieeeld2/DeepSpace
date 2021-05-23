#encoding:utf-8

require_relative 'ShieldToUI'

module Deepspace
  class ShieldBooster

    # Constructor
    # @param _name [String] nombre del escudo
    # @param _boost [Float] cantidad de daño que absorbe
    # @param _uses [Integer] usos restantes
    def initialize(_name, _boost, _uses)
      # @!attribute [String] nombre del escudo
      @name = _name

      # @!attribute [Float] cantidad de daño que absorb
      @boost = _boost

      # @!attribute [Integer] how many uses the shield booster has
      @uses = _uses
    end

    # Constructor de copia
    # @param origin [ShieldBooster] instancia a copiar
    # @return [ShieldBooster] la copia
    def self.newCopy(origin)
      return new(origin.name, origin.boost, origin.uses)
    end

    attr_reader :boost, :uses, :name

    # Usa el escudo
    # @return [Float] potencia escudo
    def useIt
      if @uses > 0
        @uses -= 1
        return @boost
      else
        return 1.0
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
      return ShieldToUI.new(self)
    end
  end
end  

