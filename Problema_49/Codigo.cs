public static void HeapyFy(int[] l, int i)
{
    int m = l[2 * i + 1];
    int index = 2 * i + 1;

    if (2 * i + 2 < l.Length)
    {
        m = Math.Min(m, l[2 * i + 2]);

        if (m == l[2 * i + 2])
            index = 2 * i + 2;
    }

    while(l[i] > m)
    {
        (l[index], l[i]) = (l[i], l[index]);

        if (index >= l.Length / 2)
            return;

        m = l[2 * index + 1];
        i = index;
        index = 2 * index + 1;
        
        if (2 * i + 2 < l.Length)
        {
            m = Math.Min(m, l[2 * i + 2]);

            if (m == l[2 * i + 2])
                index = 2 * i + 2;
        }
    }
}

public static int[] BuildHeap(int[] l)
{
    int[] result = new int[l.Length];
    
    for (int i = 0; i < l.Length; i++)
        result[i] = l[i];

    for (int i = l.Length / 2 - 1; i >= 0 ; i--)
        HeapyFy(result, i);

    return result;
}