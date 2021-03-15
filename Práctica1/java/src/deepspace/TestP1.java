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
        System.out.println("\n");
        System.out.println(CombatResult.NOCOMBAT);
        System.out.println("\n");
        System.out.println(CombatResult.STATIONESCAPES);
        System.out.println("\n");
        System.out.println(CombatResult.STATIONWINS);
        System.out.println("\n");
        
        System.out.println("Enum GameCharacter:\n");
        System.out.println(GameCharacter.ENEMYSTARSHIP);
        System.out.println("\n");
        System.out.println(GameCharacter.SPACESTATION);
        System.out.println("\n");
        
        System.out.println("Enum ShotResult:\n");
        System.out.println(ShotResult.DONOTRESIST);
        System.out.println("\n");
        System.out.println(ShotResult.RESIST);
        System.out.println("\n");
        
        System.out.println("Weapon Type:\n");
        System.out.println(WeaponType.LASER.getPower());
        System.out.println("\n");
        System.out.println(WeaponType.MISSILE.getPower());
        System.out.println("\n");
        System.out.println(WeaponType.PLASMA.getPower());
        System.out.println("\n");
        
        System.out.println("Loot:\n");
        
        
    }
    
}
