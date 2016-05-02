int r0, r1, r2, r3, r4, r5, r6, r7;
int *iptr1;
char *cptr1;
char *fp, *sp;

char globalData[4096];
char moreGlobalData[4096];

main()
{
	initstack();
        printString("The solution for 4 disks is:");
        printLine();
        hanoi(1,2,3,4);
}

hanoi(int x, int y, int z, int n)
{
    if( n == 1)
    {
        printString("     Move disk from ");
        printInt(x);
        printString(" to ");
        printInt(z);
        printLine();
    }
    else
    {
        hanoi(x,z,y,n-1);
        printString("     Move disk from ");
        printInt(x);
        printString(" to ");
        printInt(z);
        printLine();
        hanoi(y,x,z,n-1);
    }
}
