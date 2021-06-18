/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package deepspace;

/**
 * Representa una estación espacial eficiente con mejor tecnológia 
 * de eficiencia, llamada beta.
 * La estación eficiencia beta recibe mayor potencia de disparo
 */
public class BetaPowerEfficientSpaceStation extends PowerEfficientSpaceStation {
    /**
     * Eficiencia extra de la estación
     */
    private final float EXTRAEFFICIENCY = 1.2f;
    
    /**
     * Random
     */
    private Dice dice;

    /**
     * Constructor
     * @param station estación espacial a convertir en eficiente con tecnología beta
     */
    public BetaPowerEfficientSpaceStation(SpaceStation station) {
        super(station);
        dice = new Dice();
    }
    
    /**
     * Disparo con probabilidad de usar tecnología beta
     * @return potencia de disparo
     */
    @Override
    public float fire(){
        if (dice.extraEfficiency())
            return super.fire()*EXTRAEFFICIENCY;
        else
            return super.fire();
    }
    
    // -------------------------------------------------------------------------
    // String representation, UI version
    // -------------------------------------------------------------------------
    
    /**
     * String representation of the object.
     * @return string representation
     */
    @Override
    public String toString() {
        String message = "(Beta)" + super.toString();
        return message;
    }
    
    /**
     * To UI.
     * @return 
     */
    @Override
    public BetaPowerEfficientSpaceStationToUI getUIversion() {
        return new BetaPowerEfficientSpaceStationToUI(this);
    }
    
}
    
    