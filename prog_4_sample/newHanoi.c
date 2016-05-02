int r0, r1, r2, r3, r4, r5, r6, r7;
int *iptr1;
char *cptr1;
char *fp, *sp;

char globalData[4096];
char moreGlobalData[4096];

main()
{
	initstack();
        goto BuildFrame1;    

start1:
        printString("The solution for 4 disks is:");
        printLine();
       
        r1 = 1;			
        r2 = 3;
        r3 = 2;
        r4 = 1; 
        
        pushi(r1);	
        pushi(r2);
        pushi(r3);
        pushi(r4);
	pushi(fp);
        fp = sp - 4;
        hanoi();

        r1 = *(fp+48);
        r2 = *(fp+52);
        r3 = *(fp+56);
        r4 = *(fp+60);
        r5 = *(fp+64);
        r6 = *(fp+68);
        r7 = *(fp+72);

        sp = sp - 100;

        return;
BuildFrame1:
        sp = sp + 100;
                     
        *(fp+48) = r1;
        *(fp+52) = r2;
        *(fp+56) = r3;
        *(fp+60) = r4;
        *(fp+64) = r5;
        *(fp+68) = r6;
        *(fp+72) = r7;


        goto start1;
}

hanoi()
{

    goto BuildFrameHanoi1;

StartHanoi1:

    fp = *(fp + 0);		
    
    r6 = 100;
    sp = sp + r6;

    r7 = *(fp - 4);
    r6 = r7 - 1;
    r5 = *(fp - 8);
    r4 = *(fp - 12);
    r3 = *(fp - 16);
    r1 = 1;
    if( r7 != r1) goto Else1 ;
    
        printString("     Move disk from ");
        printInt(r3);
        printString("YES, we CAN skip the curlies! ");
        printLine();
        printString(" to ");
        printInt(r5);
        printLine();
    
Else1:
    
        pushi(r6);
        pushi(r4);
        pushi(r5);
        printString("YUP, we CAN skip the curlies! ");
        printLine();
        pushi(r3);
	pushi(fp);
        r6 = 4;
        fp = sp - r6;

        hanoi();

        printString("     Move disk from ");
        printInt(r3);
        printString(" to ");
        printInt(r5);
        printLine();


        pushi(r6);
        pushi(r5);
        pushi(r4);
        pushi(r3);
        hanoi();
        return;

BuildFrameHanoi1:
    
        sp = sp + 100;
                     
        *(fp+48) = r1;
        *(fp+52) = r2;
        *(fp+56) = r3;
        *(fp+60) = r4;
        *(fp+64) = r5;
        *(fp+68) = r6;
        *(fp+72) = r7;

        goto StartHanoi1;
}
