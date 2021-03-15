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

// Representa las armas de las que puede disponer una
// estación espacial para potenciar su energía de disparo

public class Weapon {
    private String name;
    private WeaponType type;
    private int uses;
    
    public Weapon(String n, WeaponType t, int u){
        this.name = n;
        this.type = t;
        this.uses = u;
    }
    
    public Weapon(Weapon w){
        this.name = w.name;
        this.type = w.type;
        this.uses = w.uses;
    }
    
    WeaponType getType(){
        return type;
    }
    
    int getUses(){
        return uses;
    }
    
    float power(){
        return type.getPower();
    }
    
    float useIt(){
        if(uses > 0){
            uses-=1;
            return power();
        }else{
            return 1.0f;
        }
    }
}
