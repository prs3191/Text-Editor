%{
#include<stdio.h>
#include<string.h>
#include<stdlib.h>
int words=0,lines=0,i;
char *c;
char ch[1];
int flag=0;
FILE *fp_r,*fp_w;
%}
%%


[/.][a-z] {

  i=0;
  
  printf("\ntext after dot:%s\n",yytext);
  yytext[i+1]=toupper(yytext[i+1]);
  printf("%s\n",yytext);
  fprintf(fp_w,yytext);
}


\"([^\"]|\\.)*\"  {
printf("\ndq:%s\n",yytext);
for ( c=yytext; *c=toupper(*c);c++);
printf("%s\n",yytext);
fprintf(fp_w,yytext);
}


[/,][a-zA-Z]+ {
printf("comma:%s\n",yytext);
fprintf(fp_w," , ");
for(i=1;i<=yyleng;i++)
{
	ch[0]=yytext[i];
	fprintf(fp_w,ch);
}

}

[a-zA-Z0-9]+ {
printf("ordinary:%s\n",yytext);
printf("%s\n",yytext);
if(input()==',')
{
   fprintf(fp_w,yytext);
   printf("\ncomma found in number");
   fprintf(fp_w,",");
   flag=1;
}
else
{
	if(flag==1)
	{
        fprintf(fp_w,yytext);
	   flag=0;
	}
	else
     {
	fprintf(fp_w," ");
	fprintf(fp_w,yytext);
	}
}
}

%% 

int main()
{
    fp_r=fopen("dravid.txt","r");
    fp_w=fopen("out.txt","w");
    yyin=fp_r;
    
    yylex();
    
}

