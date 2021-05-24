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
     * Si existe ciudad espacial o no
     */
    private boolean haveSpaceCity;
    
    /**
     * Constructor
     */
    public GameUniverse() {
        turns = 0;
        dice = new Dice();
        spaceStations = new ArrayList<>();
        gameState = new GameStateController();
        currentStationIndex = -1;
        currentStation = null;
        currentEnemy = null;
        spaceStations = new ArrayList<>();
        haveSpaceCity = false;
    }
    
    // Getters
    
    /**
     * Getter del estado de partida
     * @return state
     */
    public GameState getState(){
        return gameState.getState();
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
     * Elimina un arma montada de la estación espacial actual
     * Solo lo hace si el estado del juego es INIT o AFTERCOMBAT
     * @param i índice del arma a eliminar
     */
    public void discardWeapon(int i){
        if (getState() == GameState.INIT || getState() == GameState.AFTERCOMBAT){
            currentStation.discardWeapon(i);
        }
    }
    
    /**
     * Elimina un escudo montado de la estación espacial actual
     * Solo lo hace si el estado del juego es INIT o AFTERCOMBAT
     * @param i índice del escudo a eliminar
     */
    public void discardShieldBooster(int i){
        if (getState() == GameState.INIT || getState() == GameState.AFTERCOMBAT){
            currentStation.discardShieldBooster(i);
        }
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
    public boolean haveAWinner(){
        if (currentStation != null)
            return currentStation.getNMedals() >= WIN;
        else return false;
    }
    
    /**
     * Inicializa una partida
     * @param names array con los nombres de los jugadores
     */
    public void init(ArrayList<String> names){
        if (gameState.getState() == GameState.CANNOTPLAY){
            CardDealer dealer = CardDealer.getInstance();
            Iterator<String> it = names.iterator();
            while(it.hasNext()){
                SuppliesPackage supplies = new SuppliesPackage(dealer.nextSuppliesPackage());
                SpaceStation station = new SpaceStation(it.next(), supplies);
                spaceStations.add(station);
                
                int nh = dice.initWithNHangars();
                int nw = dice.initWithNWeapons();
                int ns = dice.initWithNShields();
                
                Loot lo = new Loot(0,nw,ns,nh,0);
                station.setLoot(lo);
            }
            
            currentStationIndex = dice.whoStarts(names.size());
            currentStation = spaceStations.get(currentStationIndex);
            currentEnemy = dealer.nextEnemy();
            
            gameState.next(turns, spaceStations.size());
        }
    }
    
    /**
     * Si no existe daño pendiente, pasa el turno al siguiente jugador
     * @return true en caso de pasar de turno, false en caso contrario
     */
    public boolean nextTurn(){
        if(gameState.getState() == GameState.AFTERCOMBAT){
            boolean stationState = currentStation.validState();
            if(stationState){
                currentStationIndex = (currentStationIndex+1)%spaceStations.size();
                turns+=1;
                
                currentStation = spaceStations.get(currentStationIndex);
                currentStation.cleanUpMountedItems();
                
                CardDealer dealer = CardDealer.getInstance();
                currentEnemy = dealer.nextEnemy();
                
                gameState.next(turns, spaceStations.size());
                return true;
            }else{
                return false;
            }
        }else{
            return false;
        }
    }
    
    /**
     * Ejecución del combate
     * @param station estación en combate
     * @param enemy enemigo en cmbate
     * @return resultado del combate
     */
    private CombatResult combat(SpaceStation station, EnemyStarShip enemy){
        GameCharacter ch = dice.firstShot();
        boolean enemyWins;
        CombatResult combatresult;
                
        if (ch == GameCharacter.ENEMYSTARSHIP){
            float fire = enemy.fire();
            ShotResult result = station.receiveShot(fire);
            
            if (result == ShotResult.RESIST){
                fire = station.fire();
                result = enemy.receiveShot(fire);
                
                enemyWins = (result == ShotResult.RESIST);
            }else{
                enemyWins = true;
            }
        }else{
            float fire = station.fire();
            ShotResult result = enemy.receiveShot(fire);
            
            enemyWins = (result == ShotResult.RESIST);
        }
        
        if (enemyWins){
            float s = station.getSpeed();
            boolean moves = dice.spaceStationMoves(s);
            
            if (!moves){
                Damage damage = enemy.getDamage();
                station.setPendingDamage(damage);
                
                combatresult = CombatResult.ENEMYWINS;
            }else{
                station.move();
                
                combatresult = CombatResult.STATIONESCAPES;
            }
        }else{
            Loot aLoot = enemy.getLoot();            
            Transformation transform = station.setLoot(aLoot);
            
            if (transform == Transformation.GETEFFICIENT){
                makeStationEfficient();
                combatresult = CombatResult.STATIONWINSANDCONVERTS;
            } else if (transform == Transformation.SPACECITY){
                createSpaceCity();
                combatresult = CombatResult.STATIONWINSANDCONVERTS;
            } else
                combatresult = CombatResult.STATIONWINS;
        }
        
        gameState.next(turns, spaceStations.size());
        return combatresult;
    }
    
    /**
     * Crea una ciudad espacial
     */
    private void createSpaceCity(){
        if (!haveSpaceCity){
            ArrayList<SpaceStation> rest = new ArrayList<>();
            
            for (SpaceStation station : spaceStations)
                if (station != currentStation)
                    rest.add(station);
            
            currentStation = new SpaceCity(currentStation, rest);
            spaceStations.set(currentStationIndex, currentStation);
            haveSpaceCity = true; 
        }
    }
    
    /**
     * Hace laestación espacial eficiente o eficiente beta
     */
    private void makeStationEfficient(){
        currentStation = new PowerEfficientSpaceStation(currentStation);
        if (dice.extraEfficiency())
            currentStation = new BetaPowerEfficientSpaceStation(currentStation);
        spaceStations.set(currentStationIndex, currentStation);
    }
    
    /**
     * Combate entre una estación espacial y una nave enemiga
     * @return resultado de la pelea
     */
    public CombatResult combat(){
        if (getState() == GameState.BEFORECOMBAT || getState() == GameState.INIT)
            return combat(currentStation, currentEnemy);
        else
            return CombatResult.NOCOMBAT;
    }
    
    /**
     * String representation of the object.
     * @return string representation
     */
    @Override
    public String toString() {
        return  "GameUniverse(\n" +
                "\tcurrentStationIndex = " + currentStationIndex + "\n" +
                "\tcurrentStation = " + currentStation + "\n" +
                "\tcurrentEnemy = " + currentEnemy + "\n" +
                "\tturns = " + turns + "\n" +
                "\tdice = " + dice + "\n" +
                "\tgameState = " + gameState + "\n" +
                "\tspaceStations = " + spaceStations + "\n" +
                "\tWIN = " + WIN + "\n" +
                ")";
    }
    
    /**
     * To UI.
     * @return UI version 
     */
    public GameUniverseToUI getUIversion() {
        return new GameUniverseToUI(currentStation, currentEnemy);
    }
}
