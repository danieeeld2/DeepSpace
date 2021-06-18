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
    
    /**
     * Si una estación espacial se convierte a eficiente o no
     */
    private boolean efficient;
    
    /**
     * Si una estación espacial se convierte en ciudad
     */
    private boolean spaceCity;
    
    Loot(int nSup, int nWeap, int nSh, int nHan, int nMed){
        this.nSupplies = nSup;
        this.nWeapons = nWeap;
        this.nShields = nSh;
        this.nHangars = nHan;
        this.nMedals = nMed;    
        efficient = false;
        spaceCity = false;
    }
    
    Loot(int nSup, int nWeap, int nSh, int nHan, int nMed, boolean _efficient, boolean _spaceCity){
        this.nSupplies = nSup;
        this.nWeapons = nWeap;
        this.nShields = nSh;
        this.nHangars = nHan;
        this.nMedals = nMed;    
        efficient = _efficient;
        spaceCity = _spaceCity;
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
    
    public boolean getEfficient(){
        return efficient;
    }
    
    public boolean spaceCity(){
        return spaceCity;
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
                ", getEfficient = " + efficient + 
                ", spaceCity = " + spaceCity + 
                ")"; 
    }
    
    /**
     * To UI.
     */
    LootToUI getUIversion() {
        return new LootToUI(this);
    }
}
