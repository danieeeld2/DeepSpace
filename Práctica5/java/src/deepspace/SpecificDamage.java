/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package deepspace;

import java.util.ArrayList;
import java.util.Iterator;

/**
 * SpecificDamage está compuesto de:
 * - número de escudos a perder
 * - lista de armas a perder
 */
public class SpecificDamage extends Damage {
    /**
     * Array con las armas a perder
     */
    ArrayList<WeaponType> weapons;
    
    /**
     * Constructor
     * @param _weapons array con los tipos de armas a perder
     * @param _nShields número de escudos a perder
     */
    public SpecificDamage(ArrayList<WeaponType> _weapons, int _nShields){
        super(_nShields);
        if (_weapons != null)
            weapons = new ArrayList<>(_weapons);
        else
            weapons = new ArrayList<>();
    }
    
    /**
     * Constructor de copia
     * @param other instancia a copiar
     */
    public SpecificDamage(SpecificDamage other){
        this(other.weapons, other.getNShields());
    }
    
    // Getters
    
    /**
     * Copy getter
     * @return copia de la instancia
     */
    @Override
    public SpecificDamage copy(){
        return new SpecificDamage(this);
    }
    
    /**
     * Getter de weapons
     * @return copy de weapons
     */
    public ArrayList<WeaponType> getWeapons(){
        if (weapons != null)
            return new ArrayList<>(weapons);
        else
            return new ArrayList<>();
    }
    
    /**
     * Comprueba si el daño tiene efecto o no
     * @return true en caso de no tener efecto, false en caso contrario
     */
    @Override
    public boolean hasNoEffect(){
        if (weapons != null)
            return weapons.isEmpty() && getNShields() == 0;
        else
            return getNShields() == 0;
    }
    
    
    // Setters
    
    /**
     * Busca el primer elemento de un tipo de arma en un array dado
     * @param w lista de armas
     * @param t tipo de arma
     * @return devuelve la posición. Si no se encuentra, devuelve -1
     */
    private int arrayContainsType(ArrayList<Weapon> w, WeaponType t){
        Iterator<Weapon> it = w.iterator();
        int i=0;
        while(it.hasNext()){
            if (t == it.next().getType()){
                return i;
            }
            i++;
        }
        return -1;
    }
    
    /**
     * Crea un objeto ajustado 
     * @param w armas a ajustar
     * @param s escudos a ajustar
     * @return copia del objecto ajustado
     */
    @Override
    public SpecificDamage adjust(ArrayList<Weapon> w, ArrayList<ShieldBooster> s){
        int shields = Integer.min(s.size(), getNShields());
        ArrayList<Weapon> wAux = new ArrayList<>(w);
       ArrayList<WeaponType> toSet = new ArrayList<>();
       
       for(WeaponType element: weapons) {
           int index = arrayContainsType(wAux, element);
          
          if(index != -1){  //If the element is found
              toSet.add(element); //It can be removed
              wAux.remove(index);
          }
       }
        
        return new SpecificDamage(toSet, shields);
    }
    
    /**
     * Elimina un arma dada
     * @param w arma a descartar
     * */
    @Override
    public void discardWeapon(Weapon w){
        if (!weapons.isEmpty()){
                weapons.remove(w.getType());
        }
    }
    
    /**
     * Get the string representation of the object
     * @return the string representation
     **/
    @Override
    public String toString(){
        return  "Damage(" +
                "weapons = " + weapons +
                ", nShields = " + getNShields() +
                ")";
    }

    /**
     * Gets the UI version of the object
     *
     * @return the UI version of the object
     * */
    @Override
    public SpecificDamageToUI getUIversion(){
        return new SpecificDamageToUI(this);
    }
}
