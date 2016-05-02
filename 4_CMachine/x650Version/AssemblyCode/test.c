int r0, r1, r2, r3, r4, r5, r6, r7, r16, r17, r18, r19;
int *iptr1;
char *cptr1;
char *fp, *sp;

main()
{
	initstack();
	r1 = 7;
	r2 = 13;
	r3 = 100;
	printline ();

	pushi(r3);
	pushi(r5);
	pushc(fp);
	fp = sp - 1;
	f(r3, r5);
	fp = *(sp - 1);
	sp = fp;
	r6 = r0;
	printString ("Main:\n");
	printInt(r6);
	
}

f(r1,r2)
{
	*(fp - 1) = *(fp - 5);
	printString ("Func:\n");
	printInt(*(fp-1));
	r0 = *(fp -1);
}
