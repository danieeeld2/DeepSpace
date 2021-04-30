#encoding: utf-8

require_relative 'DamageToUI'
require_relative 'WeaponType'
require_relative 'Weapon'

module Deepspace
  # Clase que representa el daño producido a una estación espacial por
  # una nave enemiga cuando se pierde un combate
  class Damage
    # Constructor (Solo va a ser usado por el resto de constructores)
    # @param w [Integer] cantidad de escudos perdidos
    # @param s [Integer] cantidad de armas perdidas
    # @param wp [Array<WeaponType>] array de armas perdidas
    def initialize(w, s, wp)
      # @!attribute [Integer] número de escudos perdidos
      @nShields = w

      # @!attribute [Integer] número de armas perdidas
      @nWeapons = s

      # @!attribute [Array<WeaponsType>] array de armas perdidas
      @weapons = wp
    end

    # Constructor numérico
    # Inicializa la clase con el número de armas y escudos perdidos
    # @param w [Integer] cantidad de escudos perdidos
    # @param s [Integer] cantidad de armas perdidas
    def self.newNumericWeapons(w, s)
      return new(w, s, nil)
    end

    # Constructor array
    # Inicializa la clase con un array de armas perdidas y el número de escudos perdidos
    # @param w [Integer] cantidad de escudos perdidos
    # @param wp [Array<WeaponType>] array de armas perdidas
    def self.newSpecificWeapons(w, wp)
      return new(w, -1, wp)
      # -1 es un valor de distinción
    end

    # Constructor de copia
    # @param d [Damage] instancia a copiar
    def self.newCopy(d)
      if d.nWeapons == -1
        return newSpecificWeapons(d.nShields, d.weapons)
      else
        return newNumericWeapons(d.nShields, d.nWeapons)
      end
    end

    # Getters
    attr_reader :nShields, :nWeapons, :weapons

    # Consulta si el daño ha afectado o no
    # @return [Boolean] devuelve true si el daño no tiene efecto, false en caso contrario
    def hasNoEffect
      if nWeapons == -1
        return @weapons.length + @nShields == 0
      else
        return @nShields + @nWeapons == 0
      end
    end

    # Busca el primer elemento de un tipo de arma en un array dado
    # @param w [Array<Weapon>] array de armas
    # @param t [WeaponType] tipo de arma buscado
    # @return [Integer] posición de la primera correspondencia. -1 en caso de que no exista
    def arrayContainsType(w, t)
      i = 0
      w.each do |weapon_aux|
        if weapon_aux.type == t
          return i
        else
          i += 1
        end
      end
      # No se encontró elemento
      return -1
    end

    # Setters

    # Crea una versión ajustada del objeto a los parámetros
    # @param w [Weapon] w colección de armas
    # @param s [ShieldBooster] colección de escudos
    # @return [Damage] version reducida
    def adjust(w, s)
      if @nWeapons != -1
        self.class.newNumericWeapons([@nWeapons, w.length].min, [@nShields, s.length].min)
      else
        weapons_copy = @weapons.clone

        new_weapons = w.map do |weapon|
          weapons_copy.delete_at(weapons_copy.index(weapon.type) || weapons_copy.length)
        end

        new_weapons.compact!

        self.class.newSpecificWeapons(new_weapons, [@nShields, s.length].min)
      end
    end

    # Elimina un arma de la lista (si disponemos de lista), sino decrementa el contador de armas en 1
    # @param w [Weapon] arma a eliminar
    def discardWeapon(w)
      if @nWeapons == -1
        if @weapons.length != 0
          position = @weapons.index(w.type)
          if position != nil
            @weapons.delete_at(position)
          end
        end
      else
        if @nWeapons > 0
          @nWeapons -= 1
        end
      end
    end

    # Decrementa en una unidad el número de potenciadores de escudo que deben eliminarse
    def discardShieldBooster
      if @nShields > 0
        @nShields -= 1
      end
    end

    # Representación string4
    # @return [String] string representacion
    def to_s
      getUIversion().to_s
    end

    # To UI
    def getUIversion
      return DamageToUI.new(self)
    end

    # Especificaciones visibilidad
    # ==========================================================================
    private :arrayContainsType
    private_class_method :new

  end
end

# # Código de prueba
# prueba1 = Deepspace::Damage.newNumericWeapons(2,2)
# puts prueba1.nShields
# puts prueba1.nWeapons
# puts prueba1.weapons
# puts prueba1.to_s 
# arma1 = Deepspace::Weapon.new('laser', Deepspace::WeaponType::PLASMA, 8)
# arma2 = Deepspace::Weapon.new('misil', Deepspace::WeaponType::MISSILE, 10)
# armas = []
# armas << arma1
# armas << arma2
# prueba2 = Deepspace::Damage.newSpecificWeapons(3,armas)
# puts prueba2.nShields
# puts prueba2.nWeapons
# puts prueba2.weapons
# puts prueba2.to_s 
# prueba3 = Deepspace::Damage.newCopy(prueba1)
# puts prueba3.to_s
# prueba4 = Deepspace::Damage.newCopy(prueba2)
# puts prueba4.to_s
# puts prueba1.hasNoEffect
# # puts prueba2.arrayContainsType(armas,Deepspace::WeaponType::LASER) #-> Este método necesita comprobaciones
# # prueba3 = prueba2.adjust([Deepspace::WeaponType::LASER, Deepspace::WeaponType::MISSILE],["test"]) #-> Este método necesita comprobaciones
# prueba1.discardWeapon(arma1)
# puts prueba1.nWeapons
# prueba2.discardWeapon(arma1) #-> Necesita revisión
# puts prueba2.weapons
# prueba1.discardShieldBooster
# puts prueba1.nShields