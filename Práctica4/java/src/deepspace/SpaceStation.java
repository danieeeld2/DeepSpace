/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package deepspace;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.stream.Collectors;

/**
 *
 * @author daniel
 */
public class SpaceStation {
    /**
     * Máxima cantidad deunidades de combustible que puede tener una estación
     */
    private static final int MAXFUEL = 100;
    
    /**
     * Unidades de escudo que se pierden por cada unidad de potencia de disparo recibida
     */
    private static final float SHIELDLOSSPERUNITSHOT = 0.1f;
    
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
     * Medallas
     */
    private int nMedals;
    
    /**
     * Unidades de combustible
     */
    private float fuelUnits;
    
    /**
     * Daño pendiente
     */
    private Damage pendingDamage;
    
    /**
     * Array de armas
     */
    private ArrayList<Weapon> weapons;
    
    /**
     * Array de escudos
     */
    private ArrayList<ShieldBooster> shieldBoosters;
    
    /**
     * Hangar
     */
    private Hangar hangar;
    
    /**
     * Constructor
     * @param n name
     * @param s suppliespackages
     */
    public SpaceStation(String n, SuppliesPackage s) {
        name = n;
        ammoPower = 0.0f;
        fuelUnits = 0.0f;
        nMedals = 0;
        shieldPower = 0.0f;
        pendingDamage = null;
        weapons = new ArrayList<>();
        shieldBoosters = new ArrayList<>();
        hangar = null;
        receiveSupplies(s);
    }
    
    /**
     * Constructor de copia
     * @param other instancia a copiar
     */
    SpaceStation(SpaceStation other){
        ammoPower = other.ammoPower;
        fuelUnits = other.fuelUnits;
        name = other.name;
        nMedals = other.nMedals;
        shieldPower = other.shieldPower;

        if ( other.pendingDamage != null )
            pendingDamage = other.pendingDamage.copy();
        if ( other.weapons != null )
            weapons = new ArrayList<>(other.weapons);
        if ( other.shieldBoosters != null )
            shieldBoosters = new ArrayList<>(other.shieldBoosters);
        if ( other.hangar != null )
            hangar = new Hangar(other.hangar);  
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
     * Getter fuelUnits
     * @return fuelUnits
     */
    public float getFuelUnits(){
        return fuelUnits;
    }
    
    /**
     * Getter de nMedals
     * @return nMedals
     */
    public int getNMedals(){
        return nMedals;
    }
    
    /**
     * Getter shieldPower
     * @return shieldPower
     */
    public float getShieldPower(){
        return shieldPower;
    }
    
    /**
     * Getter pendingDamage
     * @return pendingDamage
     */
    public Damage getPendingDamage(){
        return pendingDamage;
    }
    
    /**
     * Getter de weapons
     * @return weapons
     */
    public ArrayList<Weapon> getWeapons(){
        return weapons;
    }
    
    /**
     * Getter de shieldBoosters
     * @return shieldBoosters
     */
    public ArrayList<ShieldBooster> getShieldBoosters(){
        return shieldBoosters;
    }
    
    /**
     * Getter de hangar
     * @return hangar
     */
    public Hangar getHangar(){
        return hangar;
    }
    
    /**
     * Fija la cantidad de combustible
     * @param f cantidad de combustible
     * @warning No puede superar el máximo estipulado
     */
    private void assignFuelValue(float f){
        if (f<=MAXFUEL)
            fuelUnits = f;
        else
            fuelUnits = MAXFUEL;
    }
    
    /**
     * Si el daño pendiente no tiene efecto fija la referencia a nulo
     */
    private void cleanPendingDamage(){
        if (pendingDamage != null){
            if (pendingDamage.hasNoEffect()){
                pendingDamage = null;
            }
        }
    }
    
    /**
     * Si se dispone de hagar, devuelve el resultado de intentar añadir un arma al mismo
     * @param w arma a añadir
     * @return el resultado. Si no se dispone de hangar devuelve false
     */
    public boolean receiveWeapon(Weapon w){
        if (hangar == null)
            return false;
        else
            return hangar.addWeapon(w);
    }
    
    /**
     * Si se dispone de hangar, devuelve el resultado de intentar añadir un escudo al mismo
     * @param s potenciador de escudo
     * @return el resultado. Si no se dispone de hangar devuelve false
     */
    public boolean receiveShieldBooster(ShieldBooster s){
        if (hangar == null)
            return false;
        else
            return hangar.addShieldBooster(s);
    }
    
    /**
     * Recibe un hangar y si no se disponía de uno se coloca el nuevo
     * @param h hangar a recibir
     */
    public void receiveHangar(Hangar h){
        if (hangar == null){
            hangar = h;
        }
    }
    
    /**
     * Fija la referencia del hangar a nulo
     */
    public void discardHangar(){
        hangar = null;
    }
    
    /**
     * Incrementa los valores de los atributos según el contenido del paquete
     * @param s paquete
     */
    public void receiveSupplies(SuppliesPackage s){
        ammoPower+=s.getAmmoPower();
        assignFuelValue(fuelUnits+s.getFuelUnits());
        shieldPower+=s.getShieldPower();
    }
    
    /**
     * Se calcula el parámetro ajustado y se almacena en el sitio correspondiente
     * @param d daño
     */
    public void setPendingDamage(Damage d){
        if (d != null){
            pendingDamage = d.adjust(weapons, shieldBoosters);
        }
    }
    
    /**
     * Intenta monta un arma del hangar en la estación
     * @param i indicede la posición del arma en el hangar
     */
    public void mountWeapon(int i){
        if (i>=0 && i<hangar.getWeapons().size()){
            if(hangar!=null){
                Weapon new_weapon = hangar.removeWeapon(i);
                if(new_weapon != null)
                    weapons.add(new_weapon);
            }
        }
    }
    
    /**
     * Intenta monta un escudo del hangar en la estación
     * @param i indicede la posición del escudo en el hangar
     */
    public void mountShieldBooster(int i){
        if (i>=0 && i<hangar.getShieldBoosters().size()){
            if(hangar!=null){
                ShieldBooster new_shield = hangar.removeShieldBooster(i);
                if(new_shield != null)
                    shieldBoosters.add(new_shield);
            }
        }
    }
    
    /**
     * Solicita descartar un arma del hangar
     * @param i posición del arma en el hangar
     */
    public void discardWeaponInHangar(int i){
        if (hangar != null)
            hangar.removeWeapon(i);
    }
    
    /**
     * Solicita descartar un escudo del hangar
     * @param i posición del escudo en el hangar
     */
    public void discardShieldBoosterInHangar(int i){
        if (hangar != null)
            hangar.removeShieldBooster(i);
    }
    
    /**
     * Consulta la velocidad de la estación espacial
     * @return velocidad
     */
    public float getSpeed(){
        if (MAXFUEL == 0){
            return 0;   // No se puede dividir por 0
        }else{
            return fuelUnits/MAXFUEL;
        }
    }
    
    /**
     * Decrementa el combustible como consecuencia del desplazamiento
     */
    public void move(){
        fuelUnits-=fuelUnits*getSpeed();
        if(fuelUnits<0)
            fuelUnits=0;
    }
    
    /**
     * Comprueba si la estación espacial está en un estado válido
     * @return el estado
     */
    public boolean validState(){
        if (pendingDamage == null)
            return true;
        else
            return pendingDamage.hasNoEffect();
    }
    
    public void cleanUpMountedItems(){
        weapons = new ArrayList<>(weapons.stream().filter(weapon -> weapon.getUses() > 0).collect(Collectors.toList()));
        shieldBoosters = new ArrayList<>(shieldBoosters.stream().filter(shield -> shield.getUses() > 0).collect(Collectors.toList()));
    }
    
    /**
     * @brief Gets the UI version
     * @return the UI Version
     * */
    public SpaceStationToUI getUIversion(){
        return new SpaceStationToUI(this);
    }

    /**
     * @brief gets the string representation of the object
     * @return the string representation
     * */
    @Override
    public String toString(){
        return  "SpaceStation(\n" + 
                "\tammoPower = " + ammoPower + "\n" +
                "\tfuelUnits = " + fuelUnits + "\n" +
                "\tname = " + name + "\n" +
                "\tnMedals = " + nMedals + "\n" +
                "\tshieldPower = " + shieldPower + "\n" +
                "\tpendingDamage = " + pendingDamage + "\n" +
                "\tweapons = " + weapons + "\n" +
                "\tshieldBoosters = " + shieldBoosters + "\n" +
                "\tHangar = " + hangar + "\n" +
                ")";
    }
    
    
    // Métodos Práctica 3
    
    /**
     * Realiza un disparo
     * @return la potencia del disparo
     */
    public float fire(){
        float factor = 1;
        Iterator<Weapon> it = weapons.iterator();
        while(it.hasNext()){
            factor*=it.next().useIt();
        }
        return ammoPower*factor;        
    }
    
    /**
     * Aplica la protección del escudo
     * @return potencia del escudo
     */
    public float protection(){
        float factor = 1;
        Iterator<ShieldBooster> it = shieldBoosters.iterator();
        while(it.hasNext()){
            factor*=it.next().useIt();
        }
        return shieldPower*factor;
    }
    
    /**
     * Interpetra el resultado de recibir un disparo
     * @param shot disparo enemigo
     * @return el resultado
     */
    public ShotResult receiveShot(float shot){
        if (protection()>=shot){
            shieldPower-=SHIELDLOSSPERUNITSHOT*shot;
            if (shieldPower<0){
                shieldPower = 0f;
            }
            return ShotResult.RESIST;
        }else{
            shieldPower = 0f;
            return ShotResult.DONOTRESIST;
        }
    }
    
    /**
     * Recibe y procesa un loot
     * @param loot loot
     * @return Como se transforma la estación espacial
     */
    public Transformation setLoot(Loot loot){
        CardDealer dealer = CardDealer.getInstance();
        int h = loot.getNHangars();
        
        if(h>0){
            Hangar han = new Hangar(dealer.nextHangar());
            receiveHangar(han);
        }
        
        int elements = loot.getNSupplies();
        while(elements != 0){
            SuppliesPackage sup = new SuppliesPackage(dealer.nextSuppliesPackage());
            receiveSupplies(sup);
            elements--;
        }
        
        elements = loot.getNWeapons();
        while(elements != 0){
            Weapon weap = new Weapon(dealer.nextWeapon());
            receiveWeapon(weap);
            elements--;
        }
        
        elements = loot.getNShields();
        while(elements != 0){
            ShieldBooster sh = new ShieldBooster(dealer.nextShieldBooster());
            receiveShieldBooster(sh);
            elements--;
        }
        
        nMedals += loot.getNMedals();   
        
        if(loot.getEfficient()){
            return Transformation.GETEFFICIENT;
        }else if(loot.spaceCity()){
            return Transformation.SPACECITY;
        }else{
            return Transformation.NOTRANSFORM;
        }
    }
    
    /**
     * Descarta un arma montada de la estación espacial
     * @param i indice del arma a descartar
     */
    public void discardWeapon(int i){
        int size = weapons.size();
        if (i>=0 && i<size){
            Weapon w = new Weapon(weapons.remove(i));
            if (pendingDamage != null){
                pendingDamage.discardWeapon(w);
                cleanPendingDamage();
            }
        }
    }
    
    /**
     * Descarta un escudo montado de la estación espacial
     * @param i indice del escudo a descartar
     */
    public void discardShieldBooster(int i){
        int size = shieldBoosters.size();
        if (i>=0 && i<size){
            ShieldBooster s = new ShieldBooster(shieldBoosters.remove(i));
            if (pendingDamage != null){
                pendingDamage.discardShieldBooster();
                cleanPendingDamage();
            }
        }
    }
}
