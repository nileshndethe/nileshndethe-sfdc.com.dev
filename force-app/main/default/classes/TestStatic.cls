public class TestStatic {
	public static void test()
    {
        system.debug('Test1');
        system.debug(helloworld('Nilesh'));
        system.debug('Test1');
    }
    
    public static string helloworld(string str)
    {
        return 'Hellow World!! ' + str;
    }
}