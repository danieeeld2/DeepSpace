/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package deepspace;

/**
 * Clase que representa una estación espacial eficiente.
 * Una estación espacial eficiente consigue mayor potencia de disparo y de escudp
 */
public class PowerEfficientSpaceStation extends SpaceStation{
    /**
     * Factor de eficiencia que gana la nave
     */
    private static final float EFFICIENCYFACTOR = 1.1f;
    
    /**
     * Constructor
     * @param station estación a convertir en eficiente
     */
    public PowerEfficientSpaceStation(SpaceStation station) {
        super(station);
    }
    
    /**
     * Realiza un disparo
     * @return potencia de disparo
     */
    @Override
    public float fire(){
        return super.fire()*EFFICIENCYFACTOR;
    }
    
    /**
     * Utiliza el escudo
     * @return potencia del escudp
     */
    @Override
    public float protection(){
        return super.protection()*EFFICIENCYFACTOR;
    }
    
    /**
     * Recibe y procesa un loot
     * @param loot loot a procesar
     * @return transformación que sufre la nave
     */
    @Override
    public Transformation setLoot(Loot loot){
        Transformation trans = super.setLoot(loot);
        if (trans == Transformation.SPACECITY)
            return Transformation.NOTRANSFORM;
        else
            return trans;
    }
    
    /**
     * To UI.
     * @return 
     */
    @Override
    public PowerEfficientSpaceStationToUI getUIversion() {
        return new PowerEfficientSpaceStationToUI(this);
    }
}
