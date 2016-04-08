int r0, r1, r2, r3, r4, r5, r6, r7;
int *iptr1;
char *cptr1;
char *fp, *sp;

char globalData[1024];
char moreGlobalData[1024];

main()
{
    initstack();

    r4 = 10;
    r3 = 0;
    r1 = 1; 
StartDoLoop1:
    r2 = 1;
StartDoLoop2:
    r3 = r3 + 1;
    r2 = r2 + 1;
    if( r2 < r1 ) goto StartDoLoop2;
EndDoLoop2:
    r1 = r1 + 1;
    if( r1 < r4 ) goto StartDoLoop1;
EndDoLoop1:
}
