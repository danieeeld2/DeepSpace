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

// Representa el botín que se obtiene al vencer una nave
// enemiga

public class Loot {
    private int nSupplies;
    private int nWeapons;
    private int nShields;
    private int nHangars;
    private int nMedals;
    
    Loot(int nSup, int nWeap, int nSh, int nHan, int nMed){
        this.nSupplies = nSup;
        this.nWeapons = nWeap;
        this.nShields = nSh;
        this.nHangars = nHan;
        this.nMedals = nMed;        
    }
    
    int getNSupplies(){
        return nSupplies;
    }
    
    int getNWeapons(){
        return nWeapons;
    }
    
    int getNShields(){
        return nShields;
    }
    
    int getNHangars(){
        return nHangars;
    }
    
    int getNMedals(){
        return nMedals;
    }
    
     /**
     * String representation of the object.
     * @return string representation
     */
    @Override
    public String toString(){
        return  "Loot(nSupplies = " + nSupplies + 
                ", nWeapons = " + nWeapons + 
                ", nShields = " + nShields + 
                ", nHangars = " + nHangars + 
                ", nMedals = " + nMedals +  
                ")"; 
    }
    
    /**
     * To UI.
     */
    LootToUI getUIversion() {
        return new LootToUI(this);
    }
}
