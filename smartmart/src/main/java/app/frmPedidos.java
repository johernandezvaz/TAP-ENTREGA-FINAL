/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/GUIForms/JFrame.java to edit this template
 */
package app;
import com.google.api.core.ApiFuture;
import com.google.api.core.ApiFutureCallback;
import com.google.cloud.firestore.CollectionReference;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.QueryDocumentSnapshot;
import com.google.cloud.firestore.QuerySnapshot;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.firestore.WriteResult;
import com.google.common.util.concurrent.MoreExecutors;
import com.google.firebase.cloud.FirestoreClient;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Josep
 */
public class frmPedidos extends javax.swing.JFrame {

    /**
     * Creates new form frmPedidos
     */
    public frmPedidos() {
        initComponents();
        FirebaseInitializer.initialize();
        cargarPedidos();
    }
    
  
    public class FirebaseInitializer {
    public static void initialize() {
        try {
            FileInputStream serviceAccount = new FileInputStream("C:\\Users\\Josep\\Documents\\NetBeansProjects\\ProyectoFinal_SmartMart-main\\Proyecto_Final_tiendita\\smartmart.json");

            FirebaseOptions options = new FirebaseOptions.Builder()
                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                    .setDatabaseUrl("https://smartmart-48d46-default-rtdb.firebaseio.com/") // Reemplaza con tu URL de Firebase
                    .build();

            FirebaseApp.initializeApp(options);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}
    
    
    private void cargarPedidos() {
    Firestore db = FirestoreClient.getFirestore();
    CollectionReference ordersRef = db.collection("orders");

    ApiFuture<QuerySnapshot> future = ordersRef.get();

    try {
        QuerySnapshot querySnapshot = future.get();
         // Limpiar el ComboBox antes de agregar los números de pedido
         cmbPedido.removeAllItems();
         cmbPedido.addItem("Seleccione un pedido");
        for (QueryDocumentSnapshot document : querySnapshot) {
            String numeroPedido = document.getId();
            cmbPedido.addItem(numeroPedido); // Agregar el número de pedido al ComboBox
        }

        // Seleccionar el primer pedido al cargar, si existe
        if (cmbPedido.getItemCount() > 0) {
            String primerPedido = cmbPedido.getItemAt(0).toString();
            cargarDatosPedido(primerPedido); // Cargar los datos del primer pedido
        }
        
        
    } catch (Exception e) {
        e.printStackTrace();
    }
   }

private void cargarDatosPedido(String numeroPedido) {
    Firestore db = FirestoreClient.getFirestore();
    CollectionReference ordersRef = db.collection("orders");

    ApiFuture<QuerySnapshot> query = ordersRef.whereEqualTo("order_id", numeroPedido).get();
    
    
    try {
        QuerySnapshot querySnapshot = query.get();
        for (QueryDocumentSnapshot document : querySnapshot) {
            // Obtener los datos del documento del pedido
            String userEmail = document.getString("user_email");
            double totalCost = document.getDouble("total_cost");
            String estado = document.getString("status"); // Obtener el estado del pedido
            List<Map<String, Object>> products = (List<Map<String, Object>>) document.get("products");
            // Asignar datos a los campos correspondientes
            txtUsuario.setText(userEmail);
            txtMonto.setText(Double.toString(totalCost));
            txaArticulos.setText(""); // Limpiar el área de texto antes de agregar los productos
            cmbEstadoActual.addItem(estado);

            // Agregar los productos al área de texto
            for (Map<String, Object> product : products) {
                String productName = (String) product.get("descripcion");
                double quantity = (double) product.get("quantity");
                int roundedQuantity = (int) Math.round(quantity);

                String productInfo = productName + " - Cantidad: " + roundedQuantity + "\n";
                txaArticulos.append(productInfo);
            }

            // Establecer el estado del pedido en el ComboBox cmbEstadoActual
            cmbEstadoActual.setSelectedItem(estado);
        }
    } catch (Exception e) {
        // Manejar cualquier excepción que pueda ocurrir al obtener los datos
        System.out.println("Error al cargar datos del pedido:");
        e.printStackTrace();
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

        cmbPedido = new javax.swing.JComboBox<>();
        btnCompletarPedido = new javax.swing.JButton();
        btnEstatus = new javax.swing.JButton();
        txtUsuario = new javax.swing.JTextField();
        jLabel1 = new javax.swing.JLabel();
        jLabel2 = new javax.swing.JLabel();
        txtMonto = new javax.swing.JTextField();
        cmbEstadoActual = new javax.swing.JComboBox<>();
        jScrollPane1 = new javax.swing.JScrollPane();
        txaArticulos = new javax.swing.JTextArea();
        jLabel3 = new javax.swing.JLabel();
        mnuPedidos = new javax.swing.JMenuBar();
        mnuSalir = new javax.swing.JMenu();

        setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
        addWindowListener(new java.awt.event.WindowAdapter() {
            public void windowOpened(java.awt.event.WindowEvent evt) {
                formWindowOpened(evt);
            }
        });

        cmbPedido.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "- Seleccione un pedido -", " " }));
        cmbPedido.addItemListener(new java.awt.event.ItemListener() {
            public void itemStateChanged(java.awt.event.ItemEvent evt) {
                cmbPedidoItemStateChanged(evt);
            }
        });

        btnCompletarPedido.setText("Completar Pedido");

        btnEstatus.setText("Cambiar Estatus");
        btnEstatus.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                btnEstatusMouseClicked(evt);
            }
        });

        jLabel1.setText("Usuario");

        jLabel2.setText("Monto Total");

        cmbEstadoActual.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "- Seleccione un estado -", "En Proceso", "Completado" }));

        txaArticulos.setColumns(20);
        txaArticulos.setRows(5);
        jScrollPane1.setViewportView(txaArticulos);

        jLabel3.setText("Articulos");

        mnuSalir.setText("Salir");
        mnuSalir.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                mnuSalirMouseClicked(evt);
            }
        });
        mnuPedidos.add(mnuSalir);

        setJMenuBar(mnuPedidos);

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addComponent(cmbPedido, 0, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(jLabel1, javax.swing.GroupLayout.PREFERRED_SIZE, 48, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(36, 36, 36)
                                .addComponent(txtUsuario, javax.swing.GroupLayout.PREFERRED_SIZE, 164, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(jLabel2)
                                .addGap(18, 18, 18)
                                .addComponent(txtMonto, javax.swing.GroupLayout.PREFERRED_SIZE, 164, javax.swing.GroupLayout.PREFERRED_SIZE)))
                        .addGap(0, 0, Short.MAX_VALUE))
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(jLabel3)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 236, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(javax.swing.GroupLayout.Alignment.LEADING, layout.createSequentialGroup()
                                .addComponent(cmbEstadoActual, 0, 1, Short.MAX_VALUE)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                                .addComponent(btnEstatus)))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(btnCompletarPedido)))
                .addContainerGap())
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(cmbPedido, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(txtUsuario, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(jLabel1))
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(jLabel2)
                    .addComponent(txtMonto, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGap(18, 18, 18)
                        .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                    .addGroup(layout.createSequentialGroup()
                        .addGap(47, 47, 47)
                        .addComponent(jLabel3)))
                .addGap(18, 18, 18)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                    .addComponent(cmbEstadoActual, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                    .addComponent(btnEstatus))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 33, Short.MAX_VALUE)
                .addComponent(btnCompletarPedido)
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void formWindowOpened(java.awt.event.WindowEvent evt) {//GEN-FIRST:event_formWindowOpened
        // TODO add your handling code here:
        txaArticulos.setEnabled(false);
        txtMonto.setEnabled(false);
        txtUsuario.setEnabled(false);
        cargarPedidos();
    }//GEN-LAST:event_formWindowOpened

    private void cmbPedidoItemStateChanged(java.awt.event.ItemEvent evt) {//GEN-FIRST:event_cmbPedidoItemStateChanged
        // TODO add your handcmbPedido.addItemListener(new ItemListener() {
                    String numeroPedido = "pedido_EsDijefjOYVUsNFIDr1inAsyKgR2_" + (String) cmbPedido.getSelectedItem();
                    cargarDatosPedido(numeroPedido);
    }//GEN-LAST:event_cmbPedidoItemStateChanged

    private void btnEstatusMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_btnEstatusMouseClicked
        String numeroPedido = cmbPedido.getSelectedItem().toString();
        String nuevoEstado = cmbEstadoActual.getSelectedItem().toString();

        Firestore db = FirestoreClient.getFirestore();
        CollectionReference ordersRef = db.collection("orders");

        // Actualizar el estado del pedido en la base de datos
        ApiFuture<WriteResult> future = ordersRef.document(numeroPedido)
                .update("status", nuevoEstado);

        // Manejo del resultado de la actualización utilizando CompletableFuture
        CompletableFuture<Void> updateCompletion = new CompletableFuture<>();
        future.addListener(() -> {
            try {
                WriteResult writeResult = future.get();
                System.out.println("Estado del pedido actualizado exitosamente.");
                // Aquí puedes agregar cualquier lógica adicional después de la actualización exitosa
                updateCompletion.complete(null);
            } catch (InterruptedException | ExecutionException e) {
                System.out.println("Error al actualizar el estado del pedido: " + e.getMessage());
                updateCompletion.completeExceptionally(e);
            }
        }, MoreExecutors.directExecutor());

        // Puedes realizar acciones adicionales después de que se complete la actualización
        updateCompletion.thenAccept(result -> {
            // Lógica adicional después de la actualización exitosa
            System.out.println("Actualización del estado del pedido completada.");
        }).exceptionally(throwable -> {
            // Manejar cualquier error que ocurra durante la actualización
            System.out.println("Error al completar la actualización: " + throwable.getMessage());
            return null;
        });
    }//GEN-LAST:event_btnEstatusMouseClicked

    private void mnuSalirMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_mnuSalirMouseClicked
        // TODO add your handling code here:
        dispose();
    }//GEN-LAST:event_mnuSalirMouseClicked

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
            java.util.logging.Logger.getLogger(frmPedidos.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(frmPedidos.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(frmPedidos.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(frmPedidos.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>

        /* Create and display the form */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                new frmPedidos().setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton btnCompletarPedido;
    private javax.swing.JButton btnEstatus;
    private javax.swing.JComboBox<String> cmbEstadoActual;
    private javax.swing.JComboBox<String> cmbPedido;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JLabel jLabel2;
    private javax.swing.JLabel jLabel3;
    private javax.swing.JScrollPane jScrollPane1;
    private javax.swing.JMenuBar mnuPedidos;
    private javax.swing.JMenu mnuSalir;
    private javax.swing.JTextArea txaArticulos;
    private javax.swing.JTextField txtMonto;
    private javax.swing.JTextField txtUsuario;
    // End of variables declaration//GEN-END:variables
}
