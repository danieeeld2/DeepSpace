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
public class EnemyStarShip {
    /**
     * Nombre de la nave
     */
    private String name;
    
    /**
     * Poder del armamento de la nave
     */
    private float ammoPower;
    
    /**
     * Poder del escudo de la nave
     */
    private float shieldPower;
    
    /**
     * Loot asociado a la nave
     */
    private Loot loot;
    
    /**
     * Daño asociado a la nave
     */
    private Damage damage;
    
    /**
     * Constructor
     * @param n nombre
     * @param a poder de armamento
     * @param s escudo de la nave
     * @param l loot
     * @param d daño
     */
    
    public EnemyStarShip(String n, float a, float s, Loot l, Damage d) {
        name = n;
        ammoPower = a;
        shieldPower = s;
        loot = l;
        damage = d;
    }
    
    /**
     * Constructor de copia
     * @param e estación a copiar
     */
    public EnemyStarShip(EnemyStarShip e){
        name = e.name;
        ammoPower = e.ammoPower;
        shieldPower = e.shieldPower;
        loot = e.loot;
        damage = e.damage;
    }
    
    // Getters
    
    /**
     * Getter de name
     * @return name
     */
    public String getName(){
        return name;
    }
    
    /**
     * Getter de ammoPower
     * @return ammoPower
     */
    public float getAmmoPower(){
        return ammoPower;
    }
    
    /**
     * Getter de shieldPower
     * @return shieldPower
     */
    public float getShieldPower(){
        return shieldPower;
    }
    
    /**
     * Getter de loot
     * @return loot
     */
    public Loot getLoot(){
        return loot;
    }
    
    /**
     * Getter de damage
     * @return damage
     */
    public Damage getDamage(){
        return damage;
    }
    
    /**
     * Consulta escudos
     * @return shieldPower 
     */
    public float protection(){
        return shieldPower;
    }
    
    /**
     * Consulta potencia de fuego
     * @return ammoPower
     */
    public float fire(){
        return ammoPower;
    }
    
    public ShotResult receiveShot(float shot){
        if (shieldPower >= shot)
            return ShotResult.RESIST;
        else
            return ShotResult.DONOTRESIST;     
    }
    
     /**
     * String representation of the object.
     * @return string representation
     */
    @Override
    public String toString() {
        String message = "[EnemyStarShip] -> Name: " + name
                + ", ammoPower: " + ammoPower
                + ", shieldPower: " + shieldPower
                + ", Loot: " + loot.toString()
                + ", Damage: " + damage.toString();
        return message;
    }
    
    /**
     * To UI.
     */
    EnemyToUI getUIversion() {
        return new EnemyToUI(this);
    }
}
