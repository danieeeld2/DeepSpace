/**
 * @file WeaponView.java
 * @author Daniel Pérez Ruiz
 * @brief Implementación GUI - DeepSpace::WeaponView
 * @version P-05
 * type : Java-JPanel
 */
package View.GUI;

import javax.swing.JPanel;
import deepspace.WeaponToUI;

/**
 * @brief Esta clase implementa la interfaz gráfica de un objeto de tipo WeaponToUI
 */
public class WeaponView extends JPanel implements CombatElementView{
    
    private boolean selected = false;

    /**
     * Constructor por defecto de la clase
     */
    public WeaponView() {
        initComponents();
        setOpaque(selected);
    }
    
    /**
     * @brief Determina si el objeto está seleccionado por el usuario
     * @return selected
     */
    @Override
    public boolean isSelected () {
        return selected;
    }
    
    /**
     * @brief Asocia al panel un objeto ToUI de WeaponView
     * @param weapon : Objeto WeaponToUI que se le pasará a la vista
     */
    void setWeapon(WeaponToUI weapon){
        type.setText(weapon.getType().toString());
        power.setText(Float.toString(weapon.getPower()));
        uses.setText(Integer.toString(weapon.getUses()));
        repaint();
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        titleType = new javax.swing.JLabel();
        titlePotencia = new javax.swing.JLabel();
        titleUsos = new javax.swing.JLabel();
        type = new javax.swing.JLabel();
        power = new javax.swing.JLabel();
        uses = new javax.swing.JLabel();

        setBackground(new java.awt.Color(255, 255, 102));
        setBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)));
        addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                formMouseClicked(evt);
            }
        });

        titleType.setFont(new java.awt.Font("Ubuntu", 1, 13)); // NOI18N
        titleType.setText("Tipo :");

        titlePotencia.setFont(new java.awt.Font("Ubuntu", 1, 13)); // NOI18N
        titlePotencia.setText("Potencia :");

        titleUsos.setFont(new java.awt.Font("Ubuntu", 1, 13)); // NOI18N
        titleUsos.setText("Usos :");

        type.setFont(new java.awt.Font("Ubuntu", 1, 13)); // NOI18N
        type.setText("jLabel1");

        power.setFont(new java.awt.Font("Ubuntu", 1, 13)); // NOI18N
        power.setText("jLabel1");

        uses.setFont(new java.awt.Font("Ubuntu", 1, 13)); // NOI18N
        uses.setText("jLabel1");

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addGap(0, 0, Short.MAX_VALUE)
                        .addComponent(titlePotencia))
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(titleType)
                            .addComponent(titleUsos))
                        .addGap(0, 0, Short.MAX_VALUE)))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(type)
                    .addComponent(uses)
                    .addComponent(power))
                .addGap(27, 27, 27))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(6, 6, 6)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(type)
                    .addComponent(titleType))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(power)
                    .addComponent(titlePotencia))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(uses)
                    .addComponent(titleUsos))
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
    }// </editor-fold>//GEN-END:initComponents

    private void formMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_formMouseClicked
        selected = !selected;
        setOpaque (selected);
        repaint();
    }//GEN-LAST:event_formMouseClicked


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JLabel power;
    private javax.swing.JLabel titlePotencia;
    private javax.swing.JLabel titleType;
    private javax.swing.JLabel titleUsos;
    private javax.swing.JLabel type;
    private javax.swing.JLabel uses;
    // End of variables declaration//GEN-END:variables
}
