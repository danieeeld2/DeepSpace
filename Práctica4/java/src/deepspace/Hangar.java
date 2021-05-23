/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package deepspace;

import java.util.ArrayList;

/**
 *
 * @author daniel
 */

public class Hangar {
    /**
     * Máximo número de escudos y armas (combinados) que puede tenerla estación
     */
    private int maxElements;
    
    /**
     * Array con los shieldboosters que tiene el hangar
     */
    private ArrayList<ShieldBooster> shieldBoosters;
    
    /**
     * Array con las weapons que tiene el hangar
     */
    private ArrayList<Weapon> weapons;
    
    // Constructores
    
    /**
     * Class initializer
     * @param capacity máximo número de escudos y armas combinados
     */
    Hangar(int capacity){
        maxElements=capacity;
        shieldBoosters=new ArrayList<>();
        weapons=new ArrayList<>();
    }
    
    /**
     * Constructor de copia
     * @param h hangar a copiar
     */
    Hangar(Hangar h){
        maxElements=h.maxElements;
        shieldBoosters=new ArrayList<>();
        weapons=new ArrayList<>();
        
        for (ShieldBooster s : h.shieldBoosters)
            addShieldBooster(s);
        for (Weapon w : h.weapons)
            addWeapon(w);
    }
    
    // Getters
    
    /**
     * Getter for maxElements
     * @return maxElements
     */
    public int getMaxElements() {
        return maxElements;
    }
    
    /**
     * Getter for shieldBoosters
     * @return shieldBoosters
     */
    public ArrayList<ShieldBooster> getShieldBoosters() {
        return shieldBoosters;
    }
    
    /**
     * Getter for weapons
     * @return weapons
     */
    public ArrayList<Weapon> getWeapons() {
        return weapons;
    }
    
    /**
     * Comprueba si aún hay espacio para añadir elementos
     * @return true si queda hueco, false en caso contrario
     */
    private boolean spaceAvailable(){
        return maxElements > shieldBoosters.size() + weapons.size();
    }
    
    /**
     * Añade un arma al hangar
     * @param w el arma a añadir
     * @return true si es posible, false en caso contrario
     */
    public boolean addWeapon(Weapon w){
        if (spaceAvailable()){
            return weapons.add(w);
        }else
            return false;
    }
    
    /**
     * Añade un potenciador de escudo
     * @param s escudo a añadir
     * @return true si es posible, false en caso contrario
     */
    public boolean addShieldBooster(ShieldBooster s){
        if (spaceAvailable()){
            return shieldBoosters.add(s);
        }else
            return false;
    }
    
    /**
     * Elimina un arma
     * @param w posición en el array del arma a eliminar
     * @return devuelve el arma extraida si es posible, sino null
     */
    public Weapon removeWeapon(int w){
        if (w >= 0 && w < weapons.size()){
            return weapons.remove(w);
        }else
            return null;
    }
    
    /**
     * Elimina un potenciador de escudo
     * @param s posición en el array del potenciador
     * @return devuelve el potenciador extraido si es posible, sino null
     */
    public ShieldBooster removeShieldBooster(int s){
        if (s >= 0 && s < shieldBoosters.size()){
            return shieldBoosters.remove(s);
        }else
            return null;
    }
    
    // UI version
    
    /**
     * String representation of the object
     * @return string representation
     */
    @Override
    public String toString() {
        String message = "[Hangar] -> Max. elements: " + maxElements
                + ", Shields: " + shieldBoosters.toString()
                + ", Weapons: " + weapons.toString();
        return message;
    }
    
    /**
     * To UI
     */
    HangarToUI getUIversion() {
        return new HangarToUI(this);
    }
}
