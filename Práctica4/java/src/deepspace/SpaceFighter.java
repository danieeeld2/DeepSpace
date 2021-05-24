/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package deepspace;

/**
 * Interfaz de acciones de elementos de combate
 */
public interface SpaceFighter {
    /**
     * Realiza un disparo
     * @return potencia de disparo
     */
    public float fire();
    
    /**
     * Usa el escudo
     * @return potencia del escudo
     */
    public float protection();
    
    /**
     * Cálculos relacionados a la recepción de un disparo
     * @param shot potencia de disparo
     * @return resultado de recibir el impacto
     */
    public ShotResult receiveShot(float shot);
}
