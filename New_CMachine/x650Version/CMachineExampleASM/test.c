int r0, r1, r2, r3, r4, r5, r6, r7;
int *iptr1;
char *cptr1;
char *fp, *sp;

char int_variable[1024];
char char_variable[1024];

main()
{
	initstack();
	r1 = 42;
	printChar(r1);

}
