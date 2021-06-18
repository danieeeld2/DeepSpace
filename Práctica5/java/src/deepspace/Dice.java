/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package deepspace;

import java.util.Random;

/**
 *
 * @author daniel
 */

// Se encarga de todo lo relacionado con el azar

public class Dice {
    private final float NHANGARSPROB;
    private final float NSHIELDSPROB;
    private final float NWEAPONSPROB;
    private final float FIRSTSHOTPROB;
    
    /**
     * Probabilidad de eficiencia extra
     */
    private final float EXTRAEFFICIENCYPROB;
    
    private Random generator;
    
    public Dice(){
        this.NHANGARSPROB = 0.25f;
        this.NSHIELDSPROB = 0.25f;
        this.NWEAPONSPROB = 0.33f;
        this.FIRSTSHOTPROB = 0.5f;
        EXTRAEFFICIENCYPROB = 0.8f;
        generator = new Random();
    }
    
    /* Determina el número de hangares que recibe una
       estación al ser creada
    */
    int initWithNHangars(){
        if(generator.nextDouble() < NHANGARSPROB)
            return 0;
        else 
            return 1;
    }
    
    /* Determina el número de armas que recibe una
       estación al ser creada
    */
    int initWithNWeapons(){
        double prob = generator.nextDouble();
        if(prob < NWEAPONSPROB)
            return 1;
        else
            if(prob < 2*NWEAPONSPROB)
                return 2;
            else
                return 3;
    }
    
    /* Determina el número de potenciadores de escudo que recibe una
       estación al ser creada
    */
    int initWithNShields(){
        if(generator.nextDouble() < NSHIELDSPROB)
            return 0;
        else 
            return 1;
    }
    
    // Determina el jugador que inicia la partida
    int whoStarts(int nPlayers){
        return generator.nextInt(nPlayers); 
    }
    
    // Determina que personaje dispara primero
    GameCharacter firstShot(){
        if(generator.nextDouble() < FIRSTSHOTPROB)
            return GameCharacter.SPACESTATION;
        else
            return GameCharacter.ENEMYSTARSHIP;
    }
    
    // Determina si la estación espacial se mueve para esquivar el disparo
    boolean spaceStationMoves(float speed){
        if(generator.nextFloat() < speed)
            return true;
        else 
            return false;
    }
    
    public boolean extraEfficiency(){
        if(generator.nextFloat() < EXTRAEFFICIENCYPROB)
            return true;
        else
            return false;
    }
    
}
