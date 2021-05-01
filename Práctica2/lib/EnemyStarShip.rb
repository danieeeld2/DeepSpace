#encoding: utf-8

require_relative 'EnemyToUI'
require_relative 'Damage'
require_relative 'Loot'
require_relative 'ShotResult'

module Deepspace
  class EnemyStarShip
    # Constructor
    # @param n [String] name
    # @param a [Float] ammoPower
    # @param s [Float] shieldPower
    # @param l [Loot] loot
    # @param d [Damage] damage
    def initialize(n, a, s, l, d)
      # @!attribute [String] nombre de la nave
      @name = n

      # @!attribute [Float] poder de armamento de la nave
      @ammoPower = a

      # @!attribute [Float] poder del escudo de la nave
      @shieldPower = s

      # @!attribute [Loot] loot asociado a la nave
      @loot = l

      # @!attribute [Damage] daño asociado a la nave
      @damage = d
    end

    # Constructor de copia
    # @param e [EnemyStarShip] instancia a copiar
    def self.newCopy(e)
      return new(e.name, e.ammoPower, e.shieldPower, e.loot, e.damage)
    end

    # Getters
    attr_reader :name, :ammoPower, :shieldPower, :loot, :damage

    # Consulta el nivel de energía del escudo de la nave
    # @return [Float] la energía del escudo (@shielPower)
    def protection
      return @shieldPower
    end

    # Consulta el nivel de energía de disparo de la nave
    # @return [Float] la energía del disparo (@ammoPower)
    def fire
      return @ammoPower
    end

    # Consulta el resultado de recibir un disparo de una determinada potencia
    # @param shoat [Float] disparo
    # @return [ShotResult] devuelve DONOTRESIST si el disparo es mas fuerte que el escudo, RESIST en caso contrario
    def receiveShot(shot)
      if @shieldPower >= shot
        return ShotResult::RESIST
      else
        return ShotResult::DONOTRESIST
      end
    end

    # Representación string
    # @return [String] string representación
    def to_s
      getUIversion().to_s
    end

    # To UI
    def getUIversion
      return EnemyToUI.new(self)
    end
  end
end

# Código de prueba
# loot = Deepspace::Loot.new(1,2,3,4,5)
# damage = Deepspace::Damage.newNumericWeapons(2,2)
# prueba = Deepspace::EnemyStarShip.new("Prueba", 2.0, 3.0, loot, damage)
# puts prueba.name
# puts prueba.ammoPower
# puts prueba.shieldPower
# puts prueba.loot
# puts prueba.damage
# puts prueba.to_s
# puts prueba.protection
# puts prueba.fire
# puts prueba.receiveShot(4.0)