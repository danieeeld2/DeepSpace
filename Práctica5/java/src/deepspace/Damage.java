/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package deepspace;

import java.util.ArrayList;
import java.util.Iterator;

/**
 *
 * @author daniel
 */
abstract class Damage {
    /**
     * Número de escudos perdidos
     */
    private int nShields;
    
    /**
     * Constructor
     */
    Damage(int _nShields){
        nShields = _nShields;
    }
    
    // Getters
    
    /**
     * Copy getter
     * @return copia de la instancia
     */
    public abstract Damage copy();
    
    /**
     * Getter for nShields
     * @return nShields
     */
    public int getNShields(){
        return nShields;
    }
    
    /**
     * Comprueba si el daño afecta o no
     * @return true, si el daño tiene efecto. False, en caso contrario
     */
    public abstract boolean hasNoEffect();
    
    // Setters
    
    /**
     * Crea un objeto ajustado 
     * @param w armas a ajustar
     * @param s escudos a ajustar
     * @return copia del objecto ajustado
     */
    public abstract Damage adjust(ArrayList<Weapon> w, ArrayList<ShieldBooster> s);
    
    /**
     * Elimina un arma dada
     * @param w arma a eliminar
     */
    public abstract void discardWeapon(Weapon w);
    
    /**
     * Reduce en 1 el número de potenciadores de escudo
     */
    public void discardShieldBooster(){
        if (nShields > 0)
            nShields--;
    }
    
    // -------------------------------------------------------------------------
    // String representation, UI version
    // -------------------------------------------------------------------------
    
    /**
     * String representation of the object.
     * @return string representation
     */
    public abstract String toString();
    
    /**
     * To UI.
     */
    abstract public DamageToUI getUIversion();
    
    
    
}
