#encoding:utf-8

require_relative 'SpaceStation'
require_relative 'Transformation'
require_relative 'PowerEfficientSpaceStationToUI'
#require_relative 'SuppliesPackage'

module Deepspace
  # Clase que representa una estación espacial eficiente
  # Una estación espacial eficiente recibe una bonificación de potencia de disparo y escudo
  class PowerEfficientSpaceStation < SpaceStation
    # @!attribute [Float] factor de eficiencia
    @@EFFICIENCYFACTOR = 1.10

    # Constructor
    # @param station [SpaceStation] estación espacial a convertir en estación eficiente
    # --Overriden
    def initialize(station)
      copy(station)
    end

    # Realiza un disparo
    # @return [Float] potencia disparo
    # --Overriden
    def fire
      super * @@EFFICIENCYFACTOR
    end

    # Usa el escudo de protección
    # @return [Float] potencia del escudo
    # --Overriden
    def protection
      super * @@EFFICIENCYFACTOR
    end

    # Recibe un loot
    # @param [Loot] loot a recibir
    # @return [Transformation] si la transformacion ha sido a eficiente (GETEFFICIENT)
    # en caso contrario NOTRANSFORM
    def setLoot(loot)
      super
      if loot.efficient
        Transformation::GETEFFICIENT
      else
        Transformation::NOTRANSFORM
      end
    end
  end
end