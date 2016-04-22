int r0, r1, r2, r3, r4, r5, r6, r7;
int *iptr1;
char *cptr1;
char *fp, *sp;

main()
{
	initstack();
	r1 = 7;
	r2 = 13;
	r3 = 100;
	printString ("Now is the time for all good people ...\n");
L1:
	r2 = r1 + r2;
	*(fp + 4) = r2;
	printInt (r2);
	printString (" ");
	if( r3 > r2 ) goto L1;
	printline ();
	pushi(r2);
}
