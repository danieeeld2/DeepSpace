#encoding:utf-8

module Deepspace

  class SuppliesPackage

    # Constructor
    # @param _ammoPower [Float] potencia de disparo
    # @param _fuelUnits [Float] unidades de combustible
    # @param _shieldPower [Float] potencia escudos
    def initialize(_ammoPower, _fuelUnits, _shieldPower)
      # @!attribute [Float] potencia de disparo
      @ammoPower = _ammoPower

      # @!attribute [Float] unidades de combustible
      @fuelUnits = _fuelUnits

      # @!attribute [Float] potencia escudos
      @shieldPower = _shieldPower
    end

    # Consructor de copia
    # @param origin [SuppliesPackage] instancia a copiar
    def self.newCopy(origin)
      return new(origin.ammoPower, origin.fuelUnits, origin.shieldPower)
    end

    attr_reader :ammoPower, :fuelUnits, :shieldPower

    # String representation
    # ==========================================================================

    # String representation of the object
    # @return [String] string representation
    def to_s
      message = "[SuppliesPackage]-> ammoPower: #{@ammoPower}, " \
				 + "fuelUnits: #{@fuelUnits}, shieldPower: #{@shieldPower}"
      return message
    end
  end
end  
