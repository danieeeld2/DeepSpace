/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package deepspace;

/**
 *
 * @author daniel
 */
public class TestP1 {
    public static void main(String[] args) {
        System.out.println("Probando todos los métodos y clases\n");
        
        System.out.println("Enum CombatResult:\n");
        System.out.println(CombatResult.ENEMYWINS);
        System.out.println(CombatResult.NOCOMBAT);
        System.out.println(CombatResult.STATIONESCAPES);
        System.out.println(CombatResult.STATIONWINS);
        System.out.println("\n");
        
        System.out.println("Enum GameCharacter:\n");
        System.out.println(GameCharacter.ENEMYSTARSHIP);
        System.out.println(GameCharacter.SPACESTATION);
        System.out.println("\n");
        
        System.out.println("Enum ShotResult:\n");
        System.out.println(ShotResult.DONOTRESIST);
        System.out.println(ShotResult.RESIST);
        System.out.println("\n");
        
        System.out.println("Weapon Type:\n");
        System.out.println(WeaponType.LASER.getPower());
        System.out.println(WeaponType.MISSILE.getPower());
        System.out.println(WeaponType.PLASMA.getPower());
        System.out.println("\n");
        
        System.out.println("Loot:\n");
        Loot loot = new Loot(1,2,3,4,5);
        System.out.println(loot.getNSupplies());
        System.out.println(loot.getnWeapons());
        System.out.println(loot.getnShields());
        System.out.println(loot.getnHangars());
        System.out.println(loot.getnMedals());
        System.out.println("\n");
        
        System.out.println("SuppliesPackage:\n");
        SuppliesPackage supplies = new SuppliesPackage(1,2,3);
        System.out.println(supplies.getAmmoPower());
        System.out.println(supplies.getFuelUnits());
        System.out.println(supplies.getShieldPower());
        System.out.println("\n");
        
        System.out.println("Weapon:\n");
        Weapon weapon = new Weapon("Plasma", WeaponType.PLASMA, 8);
        System.out.println(weapon.getType());
        System.out.println(weapon.power());
        System.out.println(weapon.useIt());
        System.out.println(weapon.getUses());
        System.out.println("\n");
        
        System.out.println("DIce:\n");
        Dice dice = new Dice();
        int n0 = 0;
        int n1 = 0;
        int var = 0;
        while(var < 100){
            if(dice.initWithNHangars() == 0)
                n0+=1;
            else
                n1+=1;
            var+=1;
        }
        System.out.println("25~" + n0);
        System.out.println("75~" + n1);
        
        n0 = 0;
        n1 = 0;
        int n2 = 0;
        var = 0;
        while(var < 100){
            int a = dice.initWithNWeapons();
            if(a == 1)
                n0+=1;
            if(a == 2)
                n1+=1;
            if(a == 3)
                n2+=1;
            var+=1;
                
        }
        System.out.println("33~" + n0);
        System.out.println("33~" + n1);
        System.out.println("33~" + n2);
        
        n0 = 0;
        n1 = 0;
        var = 0;
        while(var < 100){
            if(dice.initWithNShields()== 0)
                n0+=1;
            else
                n1+=1;
            var+=1;
        }
        System.out.println("25~" + n0);
        System.out.println("75~" + n1);
        
        n0 = 0;
        n1 = 0;
        var = 0;
        while(var < 100){
            if(dice.spaceStationMoves(0.5f)== true)
                n0+=1;
            else
                n1+=1;
            var+=1;
        }
        System.out.println("50~" + n0);
        System.out.println("50~" + n1);
    }
    
}
