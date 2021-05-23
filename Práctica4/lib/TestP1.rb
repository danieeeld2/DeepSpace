#encoding: utf-8

require_relative 'CombatResult'
require_relative 'Dice'
require_relative 'GameCharacter'
require_relative 'Loot'
require_relative 'ShieldBooster'
require_relative 'ShotResult'
require_relative 'SuppliesPackage'
require_relative 'Weapon'
require_relative 'WeaponType'

# Test Práctica 1

Salto="\n/----------------------------------------------------------------------------/\n"

class TestP1
    def main()
        puts "Probando todos los métodos get"

        puts "Enum Combat Result:\n"
        puts Deepspace::CombatResult::ENEMYWINS
        puts Deepspace::CombatResult::NOCOMBAT
        puts Deepspace::CombatResult::STATIONESCAPES
        puts Deepspace::CombatResult::STATIONWINS

        puts Salto

        puts "Enum Game Character:\n"
        puts Deepspace::GameCharacter::ENEMYSTARSHIP
        puts Deepspace::GameCharacter::SPACESTATION

        puts Salto

        puts "Enum ShotResult:\n"
        puts Deepspace::ShotResult::DONOTRESIST
        puts Deepspace::ShotResult::RESIST

        puts Salto

        puts "Weapon Type:\n"
        puts Deepspace::WeaponType::LASE.power
        puts Deepspace::WeaponType::MISSILE.power
        puts Deepspace::WeaponType::PLASMA.power

        puts Salto

        puts "Loot:\n"
        loot = Deepspace::Loot.new(1,2,3,4,5)
        puts loot.nSupplies
        puts loot.nWeapons
        puts loot.nShields
        puts loot.nHangars
        puts loot.nMedals

        puts Salto 

        puts "SuppliesPackage:\n"
        supplies = Deepspace::SuppliesPackage.new(1,2,3)
        puts supplies.ammoPower
        puts supplies.fuelUnits
        puts supplies.shieldPower

        puts Salto

        puts "ShieldBooster:\n"
        shield = Deepspace::ShieldBooster.new('shield', 1.0, 2)
        puts shield.name
        puts shield.boost
        puts shield.uses

        puts Salto

        puts "Weapon:\n"
        weapon = Deepspace::Weapon.new('Plasma', Deepspace::WeaponType::PLASMA, 8)
        puts weapon.name
        puts weapon.type.power()
        puts weapon.uses
        
        puts "Dice:\n"
        dice = Deepspace::Dice.new
        n0 = 0
        n1 = 0
        var = 0
        while var < 100
            if dice.initWithNHangars == 0
                n0+=1
            else
                n1+=1
            end
            var+=1
        end
        puts "25~" + n0.to_s
        puts "75~" + n1.to_s

        n1 = 0
        n2 = 0
        n3 = 0
        var = 0
        while var < 100
            @prob = dice.initWithNWeapons
            if  @prob == 1
                n1+=1
            else
                if @prob == 2
                    n2+=1
                else
                    n3+=1
                end
            end
            var+=1
        end
        puts "33~" + n1.to_s
        puts "33~" + n2.to_s
        puts "33~" + n3.to_s

        n0 = 0
        n1 = 0
        var = 0
        while var < 100
            if dice.initWithNShields == 0
                n0+=1
            else
                n1+=1
            end
            var+=1
        end
        puts "25~" + n0.to_s
        puts "75~" + n1.to_s

        n0 = 0
        n1 = 0
        var = 0
        while var < 100
            if dice.spaceStationMoves(0.5) == true
                n0+=1
            else
                n1+=1
            end
            var+=1
        end
        puts "50~" + n0.to_s
        puts "50~" + n1.to_s


    end
end

prueba = TestP1.new 
puts prueba.main()