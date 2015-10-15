package utils;

/**
 * Created with IntelliJ IDEA.
 * User: royk
 * Date: 5/18/15
 * Time: 9:52 PM
 * To change this template use File | Settings | File Templates.
 */
public class Conf {
    public static String MONGODB_DB = System.getenv("MONGODB_DB");
    public static String MONGODB_USER = System.getenv("MONGODB_USER");
    public static char[] MONGODB_PASS = System.getenv("MONGODB_PASS").toCharArray();
    public static String MONGODB_URL = System.getenv("MONGODB_URL");
    public static Integer MONGODB_PORT = 1;//Integer.parseInt(System.getenv("MONGODB_PORT"));
}
