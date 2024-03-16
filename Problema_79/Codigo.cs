public static int MCD(int a, int b)
{
    int d;
    while (a % b != 0)
    {
        d = b;
        b = a % b;
        a = d;
    }

    return b;
}

public static int MCM(int a, int b)
{
    int mcd = MCD(a, b);
    return a * b / mcd;
}

public static (int, int) RestFractions(int a, int b, int c, int d)
{
    int z = MCM(b, d);
    int x = z / b * a;
    int y = z / d * c;

    return (x - y, z);
}