/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package deepspace;
import java.util.ArrayList;

/**
 *
 * @author daniel
 */
public class GameUniverse {
    /**
     * Cantidad de medallas necesarias para ganar el juego
     */
    private static final int WIN = 10;
    
    /**
     * Estado del juego
     */
    private GameStateController gameState;
    
    /**
     * Número de turnos
     */
    private int turns;
    
    /**
     * Dado
     */
    private Dice dice;
    
    /**
     * Ïndice de la estación en juego
     */
    private int currentStationIndex;
    
    /**
     * Estación espacial actual
     */
    private SpaceStation currentStation;
    
    /**
     * Array con las estaciones espaciales en juego
     */
    private ArrayList<SpaceStation> spaceStations;
    
    /**
     * Estación enemiga actual
     */
    private EnemyStarShip currentEnemy;
    
    /**
     * Constructor
     */
    public GameUniverse() {
        turns = 0;
        currentStationIndex = -1;
        currentStation = null;
        currentEnemy = null;
        spaceStations = new ArrayList<>();
    }
    
    // Getters
    
    /**
     * Getter del estado de partida
     * @return state
     */
    public GameStateController getState(){
        return gameState;
    }
    
    /**
     * Descarta un hangar de la estación espacial en juego
     * Solo es posible si el estado del juego es INIT o AFTERCOMBAT
     */
    public void discardHangar(){
        if (GameState.AFTERCOMBAT == gameState.getState() || gameState.getState() == GameState.INIT)
            currentStation.discardHangar();
    }
    
    /**
     * Descarta un arma del hangar de la estación espacial actualmente en juego
     * Solo lo hace si el estado del juego es INIT o AFTERCOMBAT
     * @param i indice del escudo a descartar
     */
    public void discardShieldBoosterInHangar(int i){
        if (GameState.AFTERCOMBAT == gameState.getState() || gameState.getState() == GameState.INIT)
            currentStation.discardShieldBoosterInHangar(i);
    }
    
    /**
     * Descarta un arma del hangar de la estación espacial actualmente en juego
     * Solo lo hace si el estado del juego es INIT o AFTERCOMBAT
     * @param i indice del arma a descartar
     */
    public void discardWeaponInHangar(int i){
        if (GameState.AFTERCOMBAT == gameState.getState() || gameState.getState() == GameState.INIT)
            currentStation.discardWeaponInHangar(i);
    }
    
    /**
     * Monta un escudo en la estación espacial actualmente en juego
     * Solo lo hace si el estado del juego es INIT o AFTERCOMBAT
     * @param i indice del escudo a montar
     */
    public void mountShieldBooster(int i){
        if (GameState.AFTERCOMBAT == gameState.getState() || gameState.getState() == GameState.INIT)
            currentStation.mountShieldBooster(i);
    }
    
    /**
     * Monta un arma en la estación espacial actualmente en juego
     * Solo lo hace si el estado del juego es INIT o AFTERCOMBAT
     * @param i indice del arma a montar
     */
    public void mountWeapon(int i){
        if (GameState.AFTERCOMBAT == gameState.getState() || gameState.getState() == GameState.INIT)
            currentStation.mountWeapon(i);
    }
    
    /**
     * Comprueba si la estación espacial jugando en ese turno cumple la condición de victoria
     * @return true en caso afirmativo, false en caso contrario
     */
    public boolean hasAWinner(){
        if (currentStation != null)
            return currentStation.getNMedals() >= WIN;
        else return false;
    }
}
