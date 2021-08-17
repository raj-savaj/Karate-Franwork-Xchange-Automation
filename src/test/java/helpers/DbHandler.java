package helpers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import config.configApplication;
import net.minidev.json.JSONObject;

public class DbHandler {
    
    private static String connectionUrl = configApplication.getGlobalValue("dbUrl");
    private static String userName = configApplication.getGlobalValue("dbUsername");
    private static String passWord = configApplication.getGlobalValue("dbPassword");

    public static JSONObject getRowCount(String tableName){
        JSONObject json = new JSONObject();

        try(Connection connect = DriverManager.getConnection(connectionUrl,userName,passWord)){
            ResultSet rs = connect.createStatement().executeQuery("SELECT COUNT(*) as count FROM "+tableName);
            rs.next();
            json.put("count",Integer.parseInt( rs.getString("count")));
        } catch (SQLException e){
            e.printStackTrace();
        }
        return json;
    }
}
