#encoding:utf-8

require_relative 'EnemyToUI'
require_relative 'Damage'
require_relative 'Loot'
require_relative 'ShotResult'

module Deepspace

  class EnemyStarShip

    # Constructor
    # @param _name [String] nombre de la estación
    # @param _ammoPower [Float] potencia de fuego
    # @param _shieldPower [Float] poder de escudo
    # @param _loot [Loot] loot
    # @param _damage [Damage] daño
    def initialize(_name, _ammoPower, _shieldPower, _loot, _damage)
      # @!attribute [String] nombre de la estación
      @name = _name

      # @!attribute [Float] potencia de fuego
      @ammoPower = _ammoPower

      # @!attribute [Float] poder de escudo
      @shieldPower = _shieldPower

      # @!attribute [Loot] loot
      @loot = _loot

      # @!attribute [Damage] damage
      @damage = _damage
    end

    # Constructor de copia
    # @param enemy [EnemyStarShip] instancia que va a ser copiada
    # @return [EnemyStarShip] la copia
    def self.newCopy(enemy)
      return new(enemy.name, enemy.ammoPower, enemy.shieldPower, enemy.loot, enemy.damage)
    end

    attr_reader :name, :ammoPower, :shieldPower, :loot, :damage

    # Devuelve la potencia de disparo
    # @return [Float] ammoPower
    def fire
      return @ammoPower
    end

    # Devuelve la potencia de escudo
    # @return [Float] shieldPower
    def protection
      return @shieldPower
    end

    # Resultado de recibir un disparo de la estación
    # @param shot [Float] poder del disparo
    # @return [ShotResult] si resiste o no
    def receiveShot(shot)
      if @shieldPower >= shot
        return ShotResult::RESIST
      else
        return ShotResult::DONOTRESIST
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
      return EnemyToUI.new(self)
    end
  end
end

