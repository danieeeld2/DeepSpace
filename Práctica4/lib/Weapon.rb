#encoding:utf-8

require_relative 'WeaponType'
require_relative 'WeaponToUI'

module Deepspace
  class Weapon

    # Constructor
    # @param _name [String] nombre del arma
    # @param _type [WeaponType] tipo de arma
    # @param _uses [Integer] número de usos restantes
    def initialize(_name, _type, _uses)
      # @!attribute [String] nombre del arma
      @name = _name

      # @!attribute [WeaponType] tipo de arma
      @type = _type

      # @!attribute [Intenger] número de usos restante
      @uses = _uses
    end

    # Constructor de copia
    # @param origin [Weapon] instancia a copiar
    def self.newCopy(origin)
      return new(origin.name, origin.type, origin.uses)
    end

    attr_reader :type, :uses, :name

    # Consulta la potencia del arma
    # @return [Float] poder del arma
    def power
      return @type.power
    end

    # Usa el arma y decrementa sus usos
    # @return [Float] devuelve la potencia del disparo
    def useIt
      if @uses > 0
        @uses = @uses - 1
        return power
      else
        return 1.0
      end
    end

    # String representation, UI version
    # ==========================================================================

    # String representation of the object
    # @return [String] string representation
    def to_s
      message = "[Weapon]-> Name: #{@name}, Type: #{@type}, Power: #{power}, " \
				 + "Uses: #{@uses}"
      return message
    end

    # To UI
    def getUIversion
      return WeaponToUI.new(self)
    end
  end

end  
