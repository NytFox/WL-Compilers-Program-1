int r0, r1, r2, r3, r4, r5, r6, r7, r8,r9,r10,r11,r12;
int *iptr1;
char *cptr1;
char *fp, *sp;

main()
{
initstack();

r2 = 3;
*(fp+4) = r2;
r1 = *(fp+4);
r4 = r1 * r1;
r5 = 2;
r6 = r4 + r5;
*(fp+4) = r6;
r3 = *(fp+4);
r8 = r3 - r1;
*(fp+4) = r8;
r7 = *(fp+4);
printInt(r7);
}

