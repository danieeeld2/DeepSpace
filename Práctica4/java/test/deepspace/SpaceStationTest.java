/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package deepspace;

import java.util.ArrayList;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;



import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author daniel
 */
public class SpaceStationTest {
    
    private static Weapon mock = new Weapon("", WeaponType.LASER, 0);
    private static Weapon mockPlasma = new Weapon("", WeaponType.PLASMA, 0);
    private static ShieldBooster mocks = new ShieldBooster("", 1,1);
    
    public SpaceStationTest() {
    }
    
    @BeforeClass
    public static void setUpClass() {
    }
    
    @AfterClass
    public static void tearDownClass() {
    }
    
    @BeforeClass
    public void setUp() {
    }
    
    @AfterClass
    public void tearDown() {
    }

    /**
     * Test of receiveWeapon method, of class SpaceStation.
     */
    @Test
    public void testReceiveWeapon() {
        System.out.println("receiveWeapon");
        
        
        Weapon w = new Weapon(mock);
        SuppliesPackage sp = new SuppliesPackage(5f, 5f, 5f);
        SpaceStation instance = new SpaceStation("n", sp);
        
        boolean expResult = false;
        boolean result = instance.receiveWeapon(w);
        assertEquals(expResult, result);

        Hangar h = new Hangar(20);
        instance.receiveHangar(h);
        result = instance.receiveWeapon(w);
        expResult = true;
        
        assertEquals(expResult, result);
    }

    /**
     * Test of receiveHangar method, of class SpaceStation.
     */
    @Test
    public void testReceiveHangar() {
        System.out.println("receiveHangar");
        
        Hangar h = new Hangar(20);
        SuppliesPackage sp = new SuppliesPackage(5f, 5f, 5f);
        SpaceStation instance = new SpaceStation("n", sp);
        
        assertEquals(instance.getHangar(), null);
        
        instance.receiveHangar(h);
        
        assertEquals(instance.getHangar().equals(h), true);
    }

    /**
     * Test of mountWeapon method, of class SpaceStation.
     */
    @Test
    public void testMountWeapon() {
        System.out.println("mountWeapon");
        int i = 0;
        
        Hangar h = new Hangar(20);
        SuppliesPackage sp = new SuppliesPackage(5f, 5f, 5f);
        SpaceStation instance = new SpaceStation("n", sp);
        
        instance.receiveHangar(h);
        instance.receiveWeapon(mock);
        instance.mountWeapon(i);
        
        assertEquals(instance.getHangar().getWeapons().size(), 0);
        assertEquals(instance.getWeapons().size(), 1);
    }

    /**
     * Test of discardWeaponInHangar method, of class SpaceStation.
     */
    @Test
    public void testDiscardWeaponInHangar() {
        System.out.println("discardWeaponInHangar");
        
        int i = 0;
        
        Hangar h = new Hangar(20);
        SuppliesPackage sp = new SuppliesPackage(5f, 5f, 5f);
        SpaceStation instance = new SpaceStation("n", sp);
        
        instance.receiveHangar(h);
        instance.receiveWeapon(mock);
        
        instance.discardWeaponInHangar(i);
        // TODO review the generated test code and remove the default call to fail.
        assertEquals(instance.getHangar().getWeapons().size(), 0);
    }

    /**
     * Test of validState method, of class SpaceStation.
     */
    @Test
    public void testValidState() {
        System.out.println("validState");
        
        SuppliesPackage sp = new SuppliesPackage(5f, 5f, 5f);
        SpaceStation instance = new SpaceStation("n", sp);
        
        Hangar h = new Hangar(20);
        instance.receiveHangar(h);
        instance.receiveWeapon(mock);
        instance.mountWeapon(0);
        
        // Curiosidad: damage solo ajusta a la lista de armas y escudos MONTADOS
        Damage d = new Damage(1, 1);
        instance.setPendingDamage(d);
        
        boolean expResult = false;
        boolean result = instance.validState();
        
        assertEquals(expResult, result);
        
        instance = new SpaceStation("n", sp);
        instance.setPendingDamage(new Damage(0, 0));
        
        assertEquals(instance.validState(), true);
    }

    /**
     * Test of cleanUpMountedItems method, of class SpaceStation.
     */
    @Test
    public void testCleanUpMountedItems() {
        System.out.println("cleanUpMountedItems");
        
        SuppliesPackage sp = new SuppliesPackage(5f, 5f, 5f);
        SpaceStation instance = new SpaceStation("n", sp);
        
        Hangar h = new Hangar(20);
        instance.receiveHangar(h);
        instance.receiveWeapon(mock);
        instance.mountWeapon(0);
        
        instance.cleanUpMountedItems();
        
        assertEquals(instance.getWeapons().size(), 0);
    }
    
    /**
     * Test of discardWeapon method, of class SpaceStation.
     */
    @Test
    public void testDiscardWeapon() {
        System.out.println("discardWeapon");
        int i = 0;
        
        SuppliesPackage sp = new SuppliesPackage(5f, 5f, 5f);
        SpaceStation instance = new SpaceStation("n", sp);
        
        Hangar h = new Hangar(20);
        instance.receiveHangar(h);
        instance.receiveWeapon(mock);
        instance.mountWeapon(0);
        
        instance.discardWeaponInHangar(i);
        
       assertEquals(instance.getWeapons().size(), 0);
    }

    
}