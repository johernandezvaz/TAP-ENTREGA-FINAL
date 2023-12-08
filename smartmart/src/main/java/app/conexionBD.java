package app;

import java.lang.System.Logger;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.DriverManager;
import javax.swing.JOptionPane;

/*--> Sergio Eduardo Lastiri Torres - 22550031 <--*/

public class conexionBD
{
    
    private boolean activo = true;
    
    public void detener(){
        activo = false;
    }
    
    Connection conectar = null;                    
    PreparedStatement sentencia = null;            
    ResultSet resultado = null;                    
    
    public conexionBD()
    {
        try {
            String url = "jdbc:mysql://localhost:3306/inventario_smartmart";
            conectar = DriverManager.getConnection(url, "root", "johervaz0799");
        } catch (Exception e) {
            JOptionPane.showMessageDialog(null, "Error al conectar con la base de datos, error: " + e);
            System.out.println(e);
            System.exit(0);
        }
    }
    
  
    
}

