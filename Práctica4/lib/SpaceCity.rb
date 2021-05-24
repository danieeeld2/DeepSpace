#encoding:utf-8

require_relative 'SpaceStation'
require_relative 'SpaceCityToUI'

module Deepspace
  # CLase que representa una asociación de estaciones espaciales
  class SpaceCity < SpaceStation
    # Constrcutor
    # @param _base [SpaceStation] base de la ciudad espacial
    # @param _rest [Array<SpaceStation>] resto de estaciones aliadas
    def initialize(_base, _rest)
      copy(_base)

      # @!attribute [SpaceStation] base de la ciudad espacial
      @base = _base

      # @!attribute [Array<SpaceStation>] resto de estaciones aliadas
      @collaborators = _rest
    end

    # Getters
    attr_reader :collaborators

    # Hace que todas las estaciones aliadas disparen a la vez
    # @return [Float] potencia de disparo acumulada
    # --Overriden
    def fire
      power = @base.fire
      @collaborators.each do |station|
        power += station.fire
      end
      power
    end

    # Usa el escudo de todas las estaciones aliadas a la vez
    # @return [Float] potencia de escudo acumulada
    # --Overriden
    def protection
      energy = @base.protection
      @collaborators.each do |station|
        energy += station.protection
      end
      energy
    end

    # Recibe un loot
    # @param [Loot] loot a recibir
    # --Overriden
    def setLoot(loot)
      super
      return Transformation::NOTRANSFORM
    end

    # String representation of the object
    # @return [String] string representation
    # --Overriden
    def to_s
      getUIversion().to_s
    end

    # To UI
    def getUIversion
      return SpaceCityToUI.new(self)
    end

  end
end
