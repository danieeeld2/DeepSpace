#encondig:utf-8

require_relative 'LootToUI'

module Deepspace
  class Loot

    # Constructor
    # @param _nSupplies [Integer] número de paquetes recibidos
    # @param _nWeapons [Integer] número de armas recibidas
    # @param _nShields [Integer] número de escudos recibidos
    # @param _nHangars [Integer] número de hangares recibidos
    # @param _nMedals [Integer] número de medallas recibidas
    # @param _efficient [Boolean] si una estación espacial se convierte en eficiente o no
    # @param _spaceCity [Boolean] si una estación espacial se convierte en ciudad
    def initialize(_nSupplies, _nWeapons, _nShields, _nHangars, _nMedals, _efficient = false, _spaceCity = false)
      # @!attribute [Integer] número de paquetes recibidos
      @nSupplies = _nSupplies

      # @!attribute [Integer] número de armas recibida
      @nWeapons = _nWeapons

      # @!attribute [Integer] número de escudos recibidos
      @nShields = _nShields

      # @!attribute [Integer] número de hangares recibidos
      @nHangars = _nHangars

      # @!attribute [Integer] número de medallas recibidas
      @nMedals = _nMedals

      # @!attribute [Boolean] si una estación espacial se convierte en eficiente o no
      @efficient = _efficient

      # @!attribute [Boolean] si una estación espacial se convierte en ciudad o no
      @spaceCity = _spaceCity
    end

    # Getters
    # ==========================================================================

    attr_reader :nSupplies, :nWeapons, :nShields, :nHangars, :nMedals, :efficient, :spaceCity

    # String representation, UI version
    # ==========================================================================

    # String representation of the object
    # @return [String] string representation
    def to_s
      getUIversion().to_s
    end

    # To UI
    def getUIversion
      return LootToUI.new(self)
    end
  end
end  
