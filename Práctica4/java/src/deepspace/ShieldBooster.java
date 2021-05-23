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

// Representa a los potenciadores de escudo de las estaciones espaciales

public class ShieldBooster {
    private String name;
    private float boost;
    private int uses;

    public ShieldBooster(String nam, float bo, int us){
        this.name = nam;
        this.boost = bo;
        this.uses = us;
    }
    
    public ShieldBooster(ShieldBooster s){
        this.name = s.name;
        this.boost = s.boost;
        this.uses = s.uses;
    }
    
    float getBoost(){
        return boost;
    }
    
    int getUses(){
        return uses;
    }
    
    float useIt(){
        if(uses > 0){
            uses-=1;
            return boost;
        }else{
            return 1.0f;
        }
    }
    
    // -------------------------------------------------------------------------
    // String representation, UI version
    // -------------------------------------------------------------------------
    
    /**
     * String representation of the object.
     * @return string representation
     */
    public String toString() {
        String message = "[ShieldBooster] -> Boost: " + boost
                + ", Uses: " + uses;
        return message;
    }
    
    /**
     * To UI.
     */
    ShieldToUI getUIversion() {
        return new ShieldToUI(this);
    }
 }
