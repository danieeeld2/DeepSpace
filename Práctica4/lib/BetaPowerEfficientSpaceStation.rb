#encoding:utf-8

require_relative 'Dice'
require_relative 'PowerEfficientSpaceStation'
require_relative 'BetaPowerEfficientSpaceStationToUI'

module Deepspace
  # CLase de estaciones eficientes con tecnología beta
  # Da una mayor potencia de disparo
  class BetaPowerEfficientSpaceStation < PowerEfficientSpaceStation
    # @!attribute [Float] eficiencia extra de la tecnología beta
    @@EXTRAEFFICIENCY = 1.20

    #Constructor
    # @param  station [SpaceStation] estación espacial a convertir en estación eficiente beta
    # --Overriden
    def initialize(station)
      super(station)

      # @!attribute [Dice] dado
      @dice = Dice.new
    end

    # Realiza un disparo
    # @return [Float] potencia de disparo
    def fire
      if @dice.extraEfficiency
        @@EXTRAEFFICIENCY*super
      else
        super
      end
    end

    # String representation
    # @return [String] string representation
    def to_s
      message = "(Beta) " + super
      return message
    end

    # To UI
    def getUIversion
      return BetaPowerEfficientSpaceStationToUI.new(self)
    end
  end
end