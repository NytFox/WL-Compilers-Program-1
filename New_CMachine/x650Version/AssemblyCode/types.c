int r0, r1, r2, r3, r4, r5, r6, r7;
int *iptr1;
char *cptr1;
char *fp, *sp;

char globalData[1024];
char moreGlobalData[1024];

main()
{
	initstack();
        r2 = 21;
        *(globalData + 28) = r2;

        r2 = 45;
        *(globalData + r4) = r2;

        r2 = 1;
        *(globalData + 100) = r2;

        r2 = 2;
        *(globalData + 106) = r2;

        r2 = 19;
        *(globalData + 101) = r2;

        r3 = *(globalData + 84);
        printInt(r3);
	printLine();
       
        r3 = *(globalData + 106);
        printInt(r3);
	printLine();
       
        r3 = *(globalData + 101);
        printInt(r3);
	printLine();
       
        r3 = *(globalData + 105);
        printInt(r3);
	printLine();
}
