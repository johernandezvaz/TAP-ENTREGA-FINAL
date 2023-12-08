/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package app;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.TreeSet;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JOptionPane;

/**
 *
 * @author Josep
 */
public class frmAgregarArticulo extends javax.swing.JFrame {

    PreparedStatement pr = null;
    ResultSet rs = null;
    conexionBD BD = new conexionBD();
    /**
     * Creates new form frmAgregarArticulo
     */
    public frmAgregarArticulo() {
        initComponents();
        cmbDepartamento.addItem("Seleccione un departamento");
        updateCmb();
    }
    
     private void updateCmb() {
        String sql = "SELECT departamento FROM inventario_smartmart";
        TreeSet<String> departamentosUnicos = new TreeSet<>();
        
        try {
            pr = BD.conectar.prepareStatement(sql);
            rs = pr.executeQuery();

            // Almacenar los elementos únicos en un TreeSet
            while (rs.next()) {
                String departamento = rs.getString("departamento");
                departamentosUnicos.add(departamento);
    }
            // Limpiar el JComboBox
            cmbDepartamento.removeAllItems();
            // Agregar los elementos ordenados al JComboBox
            for (String departamento : departamentosUnicos) {
                cmbDepartamento.addItem(departamento);
            }
        } catch (Exception e) {
            System.out.println("Error al cargar elementos en el JComboBox: " + e.getMessage());
        }
     }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        Cantidad = new javax.swing.JLabel();
        cmbDepartamento = new javax.swing.JComboBox<>();
        txtCodigo = new javax.swing.JTextField();
        txtCantidadActual = new javax.swing.JTextField();
        btnAgregar = new javax.swing.JButton();
        btnSalir = new javax.swing.JButton();
        jLabel3 = new javax.swing.JLabel();
        txtArticulo = new javax.swing.JTextField();
        Cantidad1 = new javax.swing.JLabel();
        txtPrecioCompra = new javax.swing.JTextField();
        txtPrecioVenta = new javax.swing.JTextField();
        Cantidad2 = new javax.swing.JLabel();
        Cantidad3 = new javax.swing.JLabel();
        txtPrecioMayoreo = new javax.swing.JTextField();
        Cantidad4 = new javax.swing.JLabel();
        txtInventarioMinimo = new javax.swing.JTextField();
        jMenuBar1 = new javax.swing.JMenuBar();
        mnuTitulo = new javax.swing.JMenu();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);

        jLabel1.setText("Departamento");

        jLabel2.setText("Codigo");

        Cantidad.setText("Cantidad Actual");

        cmbDepartamento.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                cmbDepartamentoActionPerformed(evt);
            }
        });

        btnAgregar.setText("Agregar");
        btnAgregar.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                btnAgregarMouseClicked(evt);
            }
        });

        btnSalir.setText("Salir");
        btnSalir.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                btnSalirMouseClicked(evt);
            }
        });

        jLabel3.setText("Nombre del Articulo");

        Cantidad1.setText("Precio (Compra)");

        Cantidad2.setText("Precio (Venta)");

        Cantidad3.setText("Precio (Mayoreo)");

        Cantidad4.setText("Inventario Minimo");

        mnuTitulo.setText("Agregar Articulo");
        jMenuBar1.add(mnuTitulo);

        setJMenuBar(jMenuBar1);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING, false)
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jLabel1)
                        .addGap(65, 65, 65)
                        .addComponent(cmbDepartamento, 0, 200, Short.MAX_VALUE))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(btnAgregar)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(btnSalir))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addComponent(jLabel3, javax.swing.GroupLayout.PREFERRED_SIZE, 117, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(txtArticulo, javax.swing.GroupLayout.PREFERRED_SIZE, 200, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(jLabel2, javax.swing.GroupLayout.PREFERRED_SIZE, 104, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(txtCodigo, javax.swing.GroupLayout.PREFERRED_SIZE, 200, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(Cantidad, javax.swing.GroupLayout.PREFERRED_SIZE, 98, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(txtCantidadActual, javax.swing.GroupLayout.PREFERRED_SIZE, 200, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(Cantidad1, javax.swing.GroupLayout.PREFERRED_SIZE, 98, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(txtPrecioCompra, javax.swing.GroupLayout.PREFERRED_SIZE, 200, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(Cantidad2, javax.swing.GroupLayout.PREFERRED_SIZE, 98, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(txtPrecioVenta, javax.swing.GroupLayout.PREFERRED_SIZE, 200, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(Cantidad3, javax.swing.GroupLayout.PREFERRED_SIZE, 98, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(txtPrecioMayoreo, javax.swing.GroupLayout.PREFERRED_SIZE, 200, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(Cantidad4, javax.swing.GroupLayout.PREFERRED_SIZE, 98, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(txtInventarioMinimo, javax.swing.GroupLayout.PREFERRED_SIZE, 200, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addContainerGap(51, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(21, 21, 21)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel1)
                    .addComponent(cmbDepartamento, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel3)
                    .addComponent(txtArticulo, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(jLabel2)
                    .addComponent(txtCodigo, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(Cantidad)
                    .addComponent(txtCantidadActual, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(Cantidad4)
                    .addComponent(txtInventarioMinimo, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(20, 20, 20)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(Cantidad1)
                    .addComponent(txtPrecioCompra, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(23, 23, 23)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(Cantidad2)
                    .addComponent(txtPrecioVenta, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(Cantidad3)
                    .addComponent(txtPrecioMayoreo, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 59, Short.MAX_VALUE)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(btnAgregar)
                    .addComponent(btnSalir))
                .addGap(14, 14, 14))
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void cmbDepartamentoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmbDepartamentoActionPerformed
       

    }//GEN-LAST:event_cmbDepartamentoActionPerformed

    private void btnAgregarMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnAgregarMouseClicked
        String nomArticulo = txtArticulo.getText();
int cantActual = 0;
int codigo = 0;
int prc_compra = 0;
int prc_venta = 0;
int prc_mayoreo = 0;
int inv_min = 0;
String departamento = cmbDepartamento.getSelectedItem().toString();

if (("".equals(txtArticulo.getText())) || ("".equals(txtCantidadActual.getText())) || ("".equals(txtCodigo.getText())) || ("".equals(txtPrecioCompra.getText())) || ("".equals(txtPrecioVenta.getText()))) {
    JOptionPane.showMessageDialog(null, "Hay un campo vacío, verificar por favor");
} else {
    try {
        cantActual = Integer.parseInt(txtCantidadActual.getText());
        codigo = Integer.parseInt(txtCodigo.getText());
        prc_compra = Integer.parseInt(txtPrecioCompra.getText());
        prc_venta = Integer.parseInt(txtPrecioVenta.getText());
        prc_mayoreo = Integer.parseInt(txtPrecioMayoreo.getText());
        inv_min = Integer.parseInt(txtInventarioMinimo.getText());

        // Verificar si el código ya existe en la tabla antes de realizar la inserción
        String sqlVerificarCodigo = "SELECT COUNT(*) AS count FROM inventario_smartmart WHERE codigo = ?";
        pr = BD.conectar.prepareStatement(sqlVerificarCodigo);
        pr.setInt(1, codigo);
        ResultSet rs = pr.executeQuery();
        rs.next();
        int count = rs.getInt("count");

        if (count > 0) {
            JOptionPane.showMessageDialog(null, "El código ya existe en la base de datos");
        } else {
            // Insertar el nuevo artículo solo si el código no existe en la base de datos
            String sqlInsert = "INSERT INTO inventario_smartmart (codigo, descripcion, prc_costo, prc_venta, prc_mayoreo, inv_minimo, inventario, departamento) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            pr = BD.conectar.prepareStatement(sqlInsert);
            pr.setInt(1, codigo);
            pr.setString(2, nomArticulo);
            pr.setInt(3, prc_compra);
            pr.setInt(4, prc_venta);
            pr.setInt(5, prc_mayoreo);
            pr.setInt(6, inv_min);
            pr.setInt(7, cantActual);
            pr.setString(8, departamento);

            int filasInsertadas = pr.executeUpdate();

            if (filasInsertadas > 0) {
                JOptionPane.showMessageDialog(null,"Nueva entrada agregada correctamente a la tabla");
                txtArticulo.setText("");
                txtCantidadActual.setText("");
                txtCodigo.setText("");
                txtInventarioMinimo.setText("");
                txtPrecioCompra.setText("");
                txtPrecioMayoreo.setText("");
                txtPrecioVenta.setText("");
                cmbDepartamento.setSelectedIndex(0);
            } else {
                JOptionPane.showMessageDialog(null,"Error al agregar la nueva entrada a la tabla");
            }
        }
    } catch (NumberFormatException nfe) {
        JOptionPane.showMessageDialog(null, "Verificar que la cantidad, el código o los precios sean numéricos");
    } catch (SQLException e) {
        System.out.println("Error al ejecutar la inserción o verificación de código: " + e.getMessage());
    }
}

        
    }//GEN-LAST:event_btnAgregarMouseClicked

    private void btnSalirMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnSalirMouseClicked
        // TODO add your handling code here:
        dispose();
    }//GEN-LAST:event_btnSalirMouseClicked

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(frmAgregarArticulo.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(frmAgregarArticulo.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(frmAgregarArticulo.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(frmAgregarArticulo.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new frmAgregarArticulo().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JLabel Cantidad;
    private javax.swing.JLabel Cantidad1;
    private javax.swing.JLabel Cantidad2;
    private javax.swing.JLabel Cantidad3;
    private javax.swing.JLabel Cantidad4;
    private javax.swing.JButton btnAgregar;
    private javax.swing.JButton btnSalir;
    private javax.swing.JComboBox<String> cmbDepartamento;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JMenuBar jMenuBar1;
    private javax.swing.JMenu mnuTitulo;
    private javax.swing.JTextField txtArticulo;
    private javax.swing.JTextField txtCantidadActual;
    private javax.swing.JTextField txtCodigo;
    private javax.swing.JTextField txtInventarioMinimo;
    private javax.swing.JTextField txtPrecioCompra;
    private javax.swing.JTextField txtPrecioMayoreo;
    private javax.swing.JTextField txtPrecioVenta;
    // End of variables declaration//GEN-END:variables
}
