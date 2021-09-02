package helpers;


import config.configApplication;
import redis.clients.jedis.Jedis;

public class RedisHandler {
    private static String ipAddress = configApplication.getGlobalValue("ipAddress");
    private static String password = configApplication.getGlobalValue("redisPassword");

    public static byte[] getRedisData(String key){

        Jedis jedis  = new Jedis(ipAddress, 16379);
        try{
		    jedis.auth(password);
            byte[] bs=jedis.get(key.getBytes());
            return bs;
        }
        catch(NullPointerException e) {
			e.printStackTrace();
		} 
        finally {
			jedis.close();
		}
        return null;
    }
    
}
