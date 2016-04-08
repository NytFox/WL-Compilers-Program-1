int r0, r1, r2, r3, r4, r5, r6, r7;
int *iptr1;
char *cptr1;
char *fp, *sp;

char globalData[1024];
char moreGlobalData[1024];

main()
{
	initstack();
	r1 = 7;
	r2 = 13;
	r3 = 100;
	printString ("Now is the time for all good people ...\n");
Loop1:
	r2 = r1 + r2;
	*(fp + 4) = r2;
	printInt (r2);
	printString (" ");
	if( r3 > r2 ) goto Loop1;
	printline ();
	pushi(r2);
     
        r7 = 32; 
        r5 = 4;
        iptr1 = malloc(r7);
        r5 = 4;
        *iptr1 = r5;
        r6 = *iptr1;
        printInt(r6);
        r7 = *(globalData + 512);
        printInt(r6);
}
