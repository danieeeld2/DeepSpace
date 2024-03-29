
package View.GUI;

import javax.swing.JPanel;
import deepspace.LootToUI;

/**
 * @brief Esta clase implementa la interfaz gráfica de un objeto de tipo LootToUI
 */
public class LootView extends JPanel {

    /**
     * Constructor por defecto de la clase
     */
    public LootView() {
        initComponents();
    }
    
    /**
     * @brief Asocia al panel un objeto ToUI de LootView
     * @param loot : Objeto LootToUI que se le pasará a la vista
     */
    void setLoot(LootToUI loot){
        weapons.setText(Integer.toString(loot.getnWeapons()));
        shields.setText(Integer.toString(loot.getnShields()));
        hangar.setText(Integer.toString(loot.getnHangars()));
        supplies.setText(Integer.toString(loot.getnSupplies()));
        medals.setText(Integer.toString(loot.getnMedals()));
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

        titleWeapons = new javax.swing.JLabel();
        titleShields = new javax.swing.JLabel();
        titleHangar = new javax.swing.JLabel();
        titleSupplies = new javax.swing.JLabel();
        titleMedals = new javax.swing.JLabel();
        weapons = new javax.swing.JLabel();
        shields = new javax.swing.JLabel();
        hangar = new javax.swing.JLabel();
        medals = new javax.swing.JLabel();
        supplies = new javax.swing.JLabel();

        setBorder(javax.swing.BorderFactory.createTitledBorder(javax.swing.BorderFactory.createLineBorder(new java.awt.Color(0, 0, 0)), "Botín", javax.swing.border.TitledBorder.DEFAULT_JUSTIFICATION, javax.swing.border.TitledBorder.DEFAULT_POSITION, new java.awt.Font("Dialog", 1, 12))); // NOI18N

        titleWeapons.setFont(new java.awt.Font("Ubuntu", 1, 13)); // NOI18N
        titleWeapons.setText("Armas :");

        titleShields.setFont(new java.awt.Font("Ubuntu", 1, 13)); // NOI18N
        titleShields.setText("Escudos :");

        titleHangar.setFont(new java.awt.Font("Ubuntu", 1, 13)); // NOI18N
        titleHangar.setText("Hangar :");

        titleSupplies.setFont(new java.awt.Font("Ubuntu", 1, 13)); // NOI18N
        titleSupplies.setText("Suministros :");

        titleMedals.setFont(new java.awt.Font("Ubuntu", 1, 13)); // NOI18N
        titleMedals.setText("Medallas :");

        weapons.setFont(new java.awt.Font("Ubuntu", 1, 13)); // NOI18N
        weapons.setText("jLabel4");

        shields.setFont(new java.awt.Font("Ubuntu", 1, 13)); // NOI18N
        shields.setText("jLabel4");

        hangar.setFont(new java.awt.Font("Ubuntu", 1, 13)); // NOI18N
        hangar.setText("jLabel4");

        medals.setFont(new java.awt.Font("Ubuntu", 1, 13)); // NOI18N
        medals.setText("jLabel4");

        supplies.setFont(new java.awt.Font("Ubuntu", 1, 13)); // NOI18N
        supplies.setText("jLabel4");

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(titleHangar)
                        .addGap(44, 44, 44)
                        .addComponent(hangar))
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(titleShields)
                            .addComponent(titleWeapons))
                        .addGap(37, 37, 37)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(weapons)
                            .addComponent(shields))))
                .addGap(52, 52, 52)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(titleMedals)
                    .addComponent(titleSupplies))
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(medals)
                    .addComponent(supplies))
                .addContainerGap(33, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(weapons)
                    .addComponent(titleWeapons)
                    .addComponent(titleSupplies)
                    .addComponent(supplies))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                        .addComponent(titleMedals)
                        .addComponent(medals))
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(titleShields)
                            .addComponent(shields))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(titleHangar)
                            .addComponent(hangar))))
                .addGap(0, 14, Short.MAX_VALUE))
        );
    }// </editor-fold>//GEN-END:initComponents


    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JLabel hangar;
    private javax.swing.JLabel medals;
    private javax.swing.JLabel shields;
    private javax.swing.JLabel supplies;
    private javax.swing.JLabel titleHangar;
    private javax.swing.JLabel titleMedals;
    private javax.swing.JLabel titleShields;
    private javax.swing.JLabel titleSupplies;
    private javax.swing.JLabel titleWeapons;
    private javax.swing.JLabel weapons;
    // End of variables declaration//GEN-END:variables
}
