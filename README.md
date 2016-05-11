*****************************************************

WL-Compilers-Program-4 Read Me

Author: Xinyue Wang, Li Zhang

*****************************************************
Description:

	This is a simple implementation of a cTran language compiler.

Files:
gram.prog						: bison file
gram.tok 						: bison head file 
lex.l 							: yacc file
main.c 							: test functions
makefile						: compile the program
README.md 						: readme file
symtab_class_header.h 			: symbol table header file
symtab.cpp 						: symbol talbe implementation


Running instruction:

Environment						: Linux
Command  						: 1) make
								  2) ./compiler < Inputfile > outputfile.c
								  3) access CMachine:
								  	./assembler < outputfile.c
								  	gcc outputfile.c AssemblyCode/accessories.c



Notes (complished & not complished & problems encountered)

1. the program is functional for bitwise operation.

2. Function Part:
	Currently output of the ctran compiler could output similar format just as newHanoi program. However, this wouldnt give an expected and runnable result as an output.

	The problems we have addressed are as followings and a example code is attached at the end to give some explantion:

	1) When ever sp goes back to original position, only the predicted part (sp = sp -200) is included, while the "pushi" part was ignored.
		Thus a pop function should be included to get "sp" back to its original position.

	3) statement "fp = *(fp+0)" is put at the beginning of the function call part, which leading to the problem that the function is not reading proper
		location of "pushed" data. Instead, the statement should be put before the part of restoring all local variable.

	3) The way how "fp" is stored and retrieved would cause segmentation fault, the reason is that "sp" is defined as an "char" pointer while 
		the address of "fp" needs 4 byte size. Thus a temperory stack for store and retrieve "fp" postion could solve the problem.

	4) Local variable are stored at the beginning of the function in the format of "*(fp+y)=rx;", I think there is a problem that in the buildframe
		part, all local variable are not carrying any useful information related to the program, and when we restored the value back to local variable
		"rx=*(fp+y);", wrong information is passed back. Thus, the possible solution should be whenever we try to pass a value to a local variable, we
		store the value to the corresponding "fp" location right after the passing expression(or we could map values to a table?).

3. Potential optimization: 
	1) more efficient registrator usage by tracking IDs that are not variables.
	2) eliminate extra variable value passing part.
	3) eliminate duplicate variables that carry same information


Time just won't allow us to finish all the work here. We think the example contains too much confusion and it took a lot time to figure all of them out. Still we tried our best to figure out the whole process




//This is a cTran compiler converted code for "factorial.ct" with some mannual modification for explanation

int r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15, r16, r17, r18, r19, r20, r21, r22, r23, r24, r25, r26, r27, r28;
int d0, d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15, d16, d17, d18, d19, d20, d21, d22, d23, d24, d25, d26, d27, d28;
int *iptr1;
char *tmp; // "fp" position stack
char *cptr1;
char *fp, *sp;
char int_array[66666666];
char char_array[66666666];

void fp_push(int value)   // store "fp" address
{
    *tmp = value;
    tmp = tmp + 4;
}

void fp_pop()	// pop stack
{
    tmp = tmp - 4;
}

main()

{
initstack();
tmp = (char *)malloc(1024*1024);   // initial stack
goto BuildFramemain1;
Startmain1:
r3=1;
r5=10;
L1: d28 = 0;
printInt(r3);
printString(" Factorial = ");
r8=r3;
pushi(r8);
pushi(fp);
fp_push(fp);

fp=sp-4;
factorial();
fp = *(fp+4);   // original
fp = tmp;		// new stack retrieve fp
fp_pop();		// pop stack

// fp retrive happen before restoring data
r1=*(fp+48);
r2=*(fp+52);
r3=*(fp+56);
r4=*(fp+60);
r5=*(fp+64);
r6=*(fp+68);
r7=*(fp+72);
r8=*(fp+76);
r9=*(fp+80);
r10=*(fp+84);
r11=*(fp+88);
r12=*(fp+92);
r13=*(fp+96);
r14=*(fp+100);
r15=*(fp+104);
r16=*(fp+108);
r17=*(fp+112);
r18=*(fp+116);
r19=*(fp+120);
r20=*(fp+124);
r21=*(fp+128);
r22=*(fp+132);
r23=*(fp+136);
r24=*(fp+140);
r25=*(fp+144);
r26=*(fp+148);
r27=*(fp+152);
r28=*(fp+156);

sp=sp-8;		// pop the pushed position (2 int size in this case which is 8)
sp=sp-200;
r9=r0;

printInt(r9);
printLine();

printInt(r3);   // new value r3 turn to be 0
printLine();

printInt(r5); // new value r5 turn to be 0
printLine();

r3=r3+1;
if(r3<r5) goto L1; // the loop is messed up because the restoring wrong value to r3 & r5
return;
BuildFramemain1:
sp=sp+200;
r1 = 0;
*(fp+48)=r1;
*(fp+52)=r2;
*(fp+56)=r3;
*(fp+60)=r4;
*(fp+64)=r5;
*(fp+68)=r6;
*(fp+72)=r7;
*(fp+76)=r8;
*(fp+80)=r9;
*(fp+84)=r10;
*(fp+88)=r11;
*(fp+92)=r12;
*(fp+96)=r13;
*(fp+100)=r14;
*(fp+104)=r15;
*(fp+108)=r16;
*(fp+112)=r17;
*(fp+116)=r18;
*(fp+120)=r19;
*(fp+124)=r20;
*(fp+128)=r21;
*(fp+132)=r22;
*(fp+136)=r23;
*(fp+140)=r24;
*(fp+144)=r25;
*(fp+148)=r26;
*(fp+152)=r27;
*(fp+156)=r28;
goto Startmain1;

}
factorial()

{
goto BuildFramefactorial1;
Startfactorial1:
d28=200;
sp=sp+d28;
r3=*(fp-4);

printInt(r3);
printLine();

if(r3==1) goto L3;
L4: d28 = 0;
d2 = r3-1;
r4=d2;

pushi(r4);
pushi(fp);
fp_push(fp);		//fp store
fp=sp-4;

factorial();
fp = *fp;
fp = tmp;			// fp retrieve
fp_pop();			// pop stack
r1=*(fp+48);
r2=*(fp+52);
r3=*(fp+56);
r4=*(fp+60);
r5=*(fp+64);
r6=*(fp+68);
r7=*(fp+72);
r8=*(fp+76);
r9=*(fp+80);
r10=*(fp+84);
r11=*(fp+88);
r12=*(fp+92);
r13=*(fp+96);
r14=*(fp+100);
r15=*(fp+104);
r16=*(fp+108);
r17=*(fp+112);
r18=*(fp+116);
r19=*(fp+120);
r20=*(fp+124);
r21=*(fp+128);
r22=*(fp+132);
r23=*(fp+136);
r24=*(fp+140);
r25=*(fp+144);
r26=*(fp+148);
r27=*(fp+152);
r28=*(fp+156);
sp=sp-8;			// pop the pushed position (2 int size in this case which is 8)
sp=sp-200;
r5=r0;
d3 = r3*r5;
r0=d3;
return;

goto L2;
L3: d28 = 0;
r0=1;
return;

L2: d28 = 0;
BuildFramefactorial1:
sp=sp+200;
*(fp+48)=r1;
*(fp+52)=r2;
*(fp+56)=r3;
*(fp+60)=r4;
*(fp+64)=r5;
*(fp+68)=r6;
*(fp+72)=r7;
*(fp+76)=r8;
*(fp+80)=r9;
*(fp+84)=r10;
*(fp+88)=r11;
*(fp+92)=r12;
*(fp+96)=r13;
*(fp+100)=r14;
*(fp+104)=r15;
*(fp+108)=r16;
*(fp+112)=r17;
*(fp+116)=r18;
*(fp+120)=r19;
*(fp+124)=r20;
*(fp+128)=r21;
*(fp+132)=r22;
*(fp+136)=r23;
*(fp+140)=r24;
*(fp+144)=r25;
*(fp+148)=r26;
*(fp+152)=r27;
*(fp+156)=r28;
goto Startfactorial1;

}


















