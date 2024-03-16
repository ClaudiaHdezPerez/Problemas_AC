public static int[] MatrixRest(int[] A, int[] B, int n, int m)
{
    int[] R = new int[n * m];

    for (int i = 0; i < n * m; i++)
        R[i] = A[i] - B[i];

    return R;
}

public static void PrintMatrix(int[] a, int n, int m)
{
    for (int i = 0; i < n * m; i++)
    {
        if (i % m == 0)
            Console.Write("\n");
        
        Console.Write(a[i] + " ");
    }
} 