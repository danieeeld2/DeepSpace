/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package deepspace;

import java.util.ArrayList;

/**
 * NumericDamage está compuesto de:
 * - número de escudos a perder
 * - número de armas a perder
 */
public class NumericDamage extends Damage {
    /**
     * Número de armas a perder
     */
    private int nWeapons;
    
    /**
     * Constructor
     * @param _nWeapons número de armas a perder
     * @param _nShields número de escudos a perder
     */
    public NumericDamage(int _nWeapons, int _nShields) {
        super(_nShields);
        nWeapons = _nWeapons;
    }
    
    // Getters
    
    /**
     * Copy getter
     * @return copia de la instancia
     */
    @Override
    public NumericDamage copy(){
        return new NumericDamage(nWeapons, getNShields());
    }
    
    /**
     * Getter de nWeapons
     * @return nWeapons
     */
    public int getNWeapons(){
        return nWeapons;
    }
    
    /**
     * Comprueba si el daño afecta o no
     * @return true en caso de no afectar, false en caso contrario
     */
    @Override
    public boolean hasNoEffect(){
        return getNShields() + nWeapons == 0;
    }
    
    // Setters
    
    /**
     * Crea un objeto ajustado 
     * @param w armas a ajustar
     * @param s escudos a ajustar
     * @return copia del objecto ajustado
     */
    @Override
    public NumericDamage adjust(ArrayList<Weapon> w, ArrayList<ShieldBooster> s){
        int shields = Integer.min(s.size(), getNShields());
        return new NumericDamage(Integer.min(nWeapons, w.size()), shields);
    }
    
    /**
     * Elimina un arma, decrementando el contador en uno
     * @param w el arma a eliminar
     */
    @Override
    public void discardWeapon(Weapon w){
        if (nWeapons > 0)
            nWeapons--;
    }
    
    // -------------------------------------------------------------------------
    // String representation, UI version
    // -------------------------------------------------------------------------
    
    /**
     * String representation of the object.
     * @return string representation
     */
    @Override
    public String toString() {
        String message = "[NumericDamage] -> "
                + "Number of shields: " + getNShields()
                + ", Number of weapons: " + nWeapons;
        return message;
    }
    
    /**
     * To UI.
     */
    @Override
    public NumericDamageToUI getUIversion() {
        return new NumericDamageToUI(this);
    }
    
    
}
