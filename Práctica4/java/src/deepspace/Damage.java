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
public class Damage {
    /**
     * Número de escudos perdidos
     */
    private int nShields;
    
    /**
     * Número de armas perdidas
     */
    private int nWeapons;
    
    /**
     * Array de armas perdidas
     */
    private ArrayList<WeaponType> weapons;
    
    /**
     * Constructor numérico
     * Inicializa la clase con el número de armas y escudos perdidos
     * @param s escudos perdidos
     * @param w armas perdidas
     */
    Damage(int s, int w){
        nShields = s;
        nWeapons = w;
        weapons = new ArrayList<>();
    }
    
    /**
     * Constructor Array
     * Inicializa la clase con el número de escudos perdidos y un array de armas perdidas
     * @param s escudos perdidos
     * @param wp array de armas perdidas
     */
    Damage(ArrayList<WeaponType> wp, int s){
        nShields = s;
        nWeapons = -1;
        weapons = wp;
    }
    
    /**
     * Constructor de copia
     * @param d instancia clase Damage
     */
    Damage(Damage d){
        nShields = d.nShields;
        nWeapons = d.nWeapons;
        weapons = d.weapons;
    }
    
    // Getters
    
    /**
     * Getter for nShields
     * @return nShields
     */
    public int getNShields(){
        return nShields;
    }
    
    /**
     * Getter for nWeapons
     * @return nWeapons
     */
    public int getNWeapons(){
        return nWeapons;
    }
    
    /**
     * Getter for Array of Weapons
     * @return weapons
     */
    public ArrayList<WeaponType> getWeapons(){
        return weapons;
    }
    
    /**
     * Consulta si el daño ha afectado o no
     * @return devuelve true en caso de que el daño no tenga efecto y false en caso contrario
     */
    public boolean hasNoEffect(){
        if (nWeapons == -1){
            return weapons.size() + nShields == 0;
        }else
            return nWeapons + nShields == 0;
    }
    
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
    
    public Damage adjust(ArrayList<Weapon> w, ArrayList<ShieldBooster> s){
        int shields = Integer.min(s.size(), nShields);
        if(weapons == null){
            //Caso tenemos contadores
            return new Damage(Integer.min(nWeapons, w.size()), shields);
        }
        
       ArrayList<Weapon> wAux = new ArrayList<>(w);
       ArrayList<WeaponType> toSet = new ArrayList<>();
       
       for(WeaponType element: weapons) {
           int index = arrayContainsType(wAux, element);
          
          if(index != -1){  //If the element is found
              toSet.add(element); //It can be removed
              wAux.remove(index);
          }
       }
        
        return new Damage(toSet, shields);
    }
    
    /**
     * Elimina un arma de la lista(si disponemos de ella). Sino decrementa el contador de 
     * armas en uno
     * @param w arma a eliminar
     */
    public void discardWeapon(Weapon w){
        if (nWeapons == -1){
            if (!weapons.isEmpty()){
                weapons.remove(w.getType());
            }
        }
        else
            if(nWeapons > 0){
                nWeapons--;
            }
    }
    
    /**
     * Descarta un potenciador de escudo
     */
    public void discardShieldBooster(){
        if (nShields > 0){
            nShields--;
        }
    }
    
    /**
     * String representation of the object
     * @return string representation
     */
    @Override
    public String toString() {
        if(nWeapons!=-1) {
            return "nShields: " + getNShields()+ "\nnWeapons: " + getNWeapons();
        }
        return "nShields: " + getNShields() + "\nWeapons: " + getWeapons().toString();
    }
    
    /**
     * To UI
     */
    DamageToUI getUIversion() {
        return new DamageToUI(this);
    }
}
