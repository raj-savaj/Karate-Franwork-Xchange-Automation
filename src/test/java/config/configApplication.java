package config;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;

public class configApplication {

    public static String getGlobalValue(String key) {
		Properties prop = new Properties();
		FileInputStream fis;
		try {
			fis = new FileInputStream("src/test/java/config/global.properties");
			prop.load(fis);
			return prop.getProperty(key);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return key;
		
	}
    
}
