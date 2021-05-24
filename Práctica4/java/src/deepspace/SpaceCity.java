/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package deepspace;

import java.util.ArrayList;
import java.util.Iterator;

/**
 * Clase que representa una asociación de estaciones espaciales
 */
public class SpaceCity extends SpaceStation{
    /**
     * Base de la ciudad espacial
     */
    private SpaceStation base;
    
    /**
     * Array con el resto de estaciones que conforman la ciudad
     */
    private ArrayList<SpaceStation> collaborators;
    
    /**
     * Constructor
     * @param _base estación que será la base de la ciudad
     * @param _rest array de estaciones que conforman la ciudad
     */
    public SpaceCity(SpaceStation _base, ArrayList<SpaceStation> _rest) {
        super(_base);
        base = _base;
        collaborators = new ArrayList<>(_rest);        
    }
    
    /**
     * Get de collaborators
     * @return collaborators
     */
    public ArrayList<SpaceStation> getCollaborators(){
        return collaborators;
    }
    
    /**
     * Todas las estaciones disparan juntas
     * @return potencia de disparo
     */
    @Override
    public float fire(){
        Iterator<SpaceStation> it = collaborators.iterator();
        float factor = base.fire(); // super.fire()
        
        while(it.hasNext()){
            factor+=it.next().fire();
        }
        
        return factor;
    }
    
    /**
     * Todas las estaciones usan sus escudos en conjunto
     * @return potencia del escudo
     */
    @Override
    public float protection(){
        Iterator<SpaceStation> it = collaborators.iterator();
        float factor = base.protection();   // super.protection()
        
        while(it.hasNext()){
            factor+=it.next().protection();
        }
        
        return factor;
    }
    
    /**
     * Recibe y procesa un loot
     * @param loot loot a procesar
     * @return transformacion
     */
    @Override
    public Transformation setLoot(Loot loot){
        super.setLoot(loot);
        return Transformation.NOTRANSFORM;
    }
    
    @Override
    public SpaceCityToUI getUIversion() {
        return new SpaceCityToUI(this);
    }
    
}
