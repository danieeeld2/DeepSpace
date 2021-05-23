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

// Representa los suministros de una estación espacial

public class SuppliesPackage {
    private float ammoPower;
    private float fuelUnits;
    private float shieldPower;
    
    public SuppliesPackage(float ammoP, float fuelU, float shieldP){
        this.ammoPower = ammoP;
        this.fuelUnits = fuelU;
        this.shieldPower = shieldP;        
    }

    public SuppliesPackage(SuppliesPackage s){
        this.ammoPower = s.ammoPower;
        this.fuelUnits = s.fuelUnits;
        this.shieldPower = s.shieldPower;
    }    
    
    float getAmmoPower(){
        return ammoPower;
    }
    
    float getFuelUnits(){
        return fuelUnits;
    }
    
    float getShieldPower(){
        return shieldPower;
    }
}
