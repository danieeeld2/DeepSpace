/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package deepspace;

/**
 * Interfaz para uso de escudos y armas
 */
public interface CombatElement {
    /**
     * Get de los usos restantes
     * @return usos restantes
     */
    public int getUses();
    
    /**
     * Usa el elemento
     * @return potencia del uso
     */
    public float useIt();
}
