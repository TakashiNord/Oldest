//---------------------------------------------------------------------------
#define NO_WIN32_LEAN_AND_MEAN
#include <sys\stat.h>
#include <sys\timeb.h>
#include <stdio.h>
#include <string.h>
#include <conio.h>
#include <time.h>
#include <ctype.h>
#include <math.h>
#include <io.h>
#include <dir.h>

#define mStr 128

//---------------------------------------------------------------------------

/* This function read the numeric string after key letter
	in success it return 1, otherwice 0
*/
int read_word(char *s,char w,char *sw)
{
         char *word,sym;
	 int  n;
	 if(s==NULL) return(0);
	 if ((word=strchr(s,w))==NULL) return(0);
	 n=0;
	 do
	 {  sym=*(word+(n+1));
		 if (isdigit(sym)||sym==' '||sym=='+'||sym=='-'||sym=='.') n++;
		 else break;
	 } while (1);
	 if (n>0){ strncpy(sw,word+1,n); sw[n]='\0'; return(n); }
	 else                                        return(0);
}

/* This function replace the numeric string after key letter
	if there isn't a key letter in a string funktion adds it
	at the end of a string
*/
void replace_word(char *s,char w,char *sw)
{
  int n;
  char old_sw[20],save[100],*p;

  if(s==NULL) return;

  if ((n=read_word(s,w,old_sw))!=0)
  {
	 /* replace word */
	 p=strchr(s,w);
	 *(p+1)='\0'; strcpy(save,p+n+1);
	 strcat(strcat(s,sw),save);
  }
  else
  {
	 /* add word at the end of string */
       n=read_word(s,'L',old_sw);
       if(n==0)
        {
			p=strchr(s,'<') ; /* string have <CR> or <LF> as text */
	 if (p==NULL)   p=strchr(s,'\r'); /* string have \r\n */
	 if (p==NULL)   p=strchr(s,'\n'); /* string have \n   */
	 if (p!=NULL)
	 { strcpy(save,p); *p=w; *(p+1)='\0'; strcat(strcat(s,sw),save); }
	 else
	 {
		save[0]=' ';save[1]=w; save[2]='\n'; save[3]='\0'; strcat(strcat(s,save),sw); }
        }
       else
        {
        p=strchr(s,'L'); *p=w;
	*(p+1)='\0'; strcpy(save,p+n+1);
	strcat(strcat(s,sw),save);
        strcat(strcat(s,"L"),strcat(old_sw,"\n"));
        }

  }
}

/*Удаление кодов*/
int delete_word(char *s,char w)
{
 int n;
 char old_sw[mStr],save[mStr],*p;

 if(s==NULL) return (0);

 n=0;
 if ((n=read_word(s,w,old_sw))!=0)
  {
	 /* replace word */
	 p=strchr(s,w);
	 *(p+0)='\0'; strcpy(save,p+n+1);
	 strcat(s,save);
  }

 return n;
}

//---------------------------------------------------------------------------

/*################################################################################*/
/* Author: 7 nov 2003 */
/*
Проверяет - является ли УП - программой для Н33 (Атака)
Параметры :
    namefile - имя файла ,
    codefeed - 0 адреса F - проверять,
               1 адреса F - не проверять
Возвращаемое значение :
    0  -  УП является программой для Н33 (Атака)
    -1 -  Невозможно открыть файл 'чтение'
    n  -  число ошибок -> УП не является программой для Н33 (Атака)
*/
long int program_format_H33(char *namefile, int codefeed = 0)
{
/*локальные переменные*/
 FILE *rf; /*Указатель на файл*/
 long int numbers_of_kadrs;/* Число кадров*/
 long int error;
 char info[mStr*3];
 char curr[mStr], word[mStr];

 /*Открываем файл*/
 rf=fopen(namefile,"r");
 if (rf==NULL) {
   info[0]='\0';
   sprintf(info,"Невозможно открыть файл:\n %s \n на 'чтение' \n",namefile );
   /*Application->MessageBox(info,"Проверка программы на формат H33 - > ошибка ...", MB_OK);*/
   fprintf(stderr, info);
   return(-1);
  }

 /*Начальные условия*/
 error=0;
 /*if (codefeed!=1) codefeed=0;*/
 numbers_of_kadrs=0;

 curr[0]='\0'; fgets(curr,mStr,rf);
 while(!feof(rf))
 {

   /*Первичные признаки*/
   if (read_word(curr,'X',word)) {
      if (7!=strlen(word)) error++;
   }
   if (read_word(curr,'Y',word)) {
      if (7!=strlen(word)) error++;
   }
   if (read_word(curr,'Z',word)) {
      if (7!=strlen(word)) error++;
   }
   if (read_word(curr,'I',word)) {
      if (7!=strlen(word)) error++;
   }
   if (read_word(curr,'J',word)) {
      if (7!=strlen(word)) error++;
   }
   if (read_word(curr,'K',word)) {
      if (7!=strlen(word)) error++;
   }

   /*Вспомогательные признаки*/
   if (codefeed==0) {
      if (read_word(curr,'F',word)) {
         if (4!=strlen(word)) error++;
      }
   }

   /* if (read_word(curr,'M',word)) {
      if (3<=strlen(word)) error++;
   }  */
   if (read_word(curr,'L',word)) {
      if (3!=strlen(word)) error++;
   }
   /*if (read_word(curr,'N',word)) {
      if ((3!=strlen(word))||(5!=strlen(word))) error++;
   } */
   if (read_word(curr,'G',word)) {
      if (3<=strlen(word)) error++;
   }

   if (read_word(curr,'D',word)) error++;
   if (read_word(curr,'H',word)) error++;

   /*Вторичные признаки*/
   if (NULL!=strchr(curr,'.')) error++;
   if (NULL!=strchr(curr,';')) error++;
   if (NULL!=strchr(curr,'(')) error++;
   if (NULL!=strchr(curr,')')) error++;
   if (NULL!=strchr(curr,'"')) error++;
   if (NULL!=strchr(curr,'\'')) error++;

   curr[0]='\0'; fgets(curr,mStr,rf);
   numbers_of_kadrs++;
 } // end while

 fclose(rf);

 return(error);
}

#include <vcl.h>
#pragma hdrstop

#include "Main.h"
#include "about.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TFormMain *FormMain;
//---------------------------------------------------------------------------
__fastcall TFormMain::TFormMain(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------

void TFormMain::MessageOutput(AnsiString S)
{
  MemoStr->Lines->Append(S);
}
//---------------------------------------------------------------------------

void __fastcall TFormMain::ToolButton1Click(TObject *Sender)
{
   MessageOutput("Запуск преобразования...");
for (int i = 0; i < FileListBox1->Items->Count; i++)
{
  Application->ProcessMessages();

  if (FileListBox1->Selected[i])
  {
    if (!FileExists(FileListBox1->Items->Strings[i]))
    {
      MessageBeep(0);
      ShowMessage(AnsiString("File ") + FileListBox1->Items->Strings[i] + AnsiString(" not found"));
/*        break;
      else
        continue;*/

    }
    FILE *F = fopen(FileListBox1->Items->Strings[i].c_str(),"r");
    struct stat statbuf;

    fstat(fileno(F), &statbuf);
    MessageOutput(IntToStr(statbuf.st_size));
    fclose(F);
  }
}
   MessageOutput("Завершение преобразования...");
}
//---------------------------------------------------------------------------

void __fastcall TFormMain::ToolButton2Click(TObject *Sender)
{
        AnsiString S;
        S = "";
        MessageOutput("Выбор Папки");
        if (SelectDirectory("Выберите Папку", "", S)) DirectoryListBox1->Directory=S;
}
//---------------------------------------------------------------------------

void __fastcall TFormMain::ToolButton3Click(TObject *Sender)
{
   MessageOutput("О программе..");
   AboutForm->ShowModal();
}
//---------------------------------------------------------------------------

void __fastcall TFormMain::ToolButton4Click(TObject *Sender)
{
  MessageOutput("Завершение работы программы..");
  MessageBeep(0);
  Application->ProcessMessages();
  Application->Terminate();
}
//---------------------------------------------------------------------------

void __fastcall TFormMain::FormCreate(TObject *Sender)
{
   ComboBoxFormat->ItemIndex=2;
   ComboBoxInterval->ItemIndex=0;
   MemoStr->Lines->Clear();
   MessageOutput( DateTimeToStr(Now())  + "  reNum version 1.20 build 3 запущен, Copyright (c) 2005, БГ" );

}
//---------------------------------------------------------------------------


