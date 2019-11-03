//---------------------------------------------------------------------------
#include <stdio.h>
#include <vcl.h>
#pragma hdrstop

#include "Unit1.h"
//---------------------------------------------------------------------------
#pragma package(smart_init)
#pragma resource "*.dfm"
TForm1 *Form1;
//---------------------------------------------------------------------------
__fastcall TForm1::TForm1(TComponent* Owner)
        : TForm(Owner)
{
}
//---------------------------------------------------------------------------

class Pw
{
 public :
  int rt ;
  Pw() { rt=6; } ;
  void incr(int p) {
   for(int i ;i<p;i++) rt+=p ;
  }
  virtual ~Pw() { rt=0; } ;
} ;

//---------------------------------------------------------------------------

void __fastcall TForm1::Button1Click(TObject *Sender)
{

char szBuf[80];
//HINSTANCE hLib;
HMODULE hLib;

//BOOL (FAR *lpfnTimerCount) (TIMERINFO FAR*);

/* Turn off the "File not found" error box. */
// SetErrorMode(SEM_NOOPENFILEERRORBOX);
 /* Load the *.DLL library module. */
// hLib = LoadLibrary("libufun.dll");
// hLib = LoadLibrary("libufun.dll");
// if (hLib > HINSTANCE_ERROR) {    /* loaded successfully */
     /* Retrieve the address of the TimerCount function. */
//     (FARPROC) lpfnTimerCount =
//        GetProcAddress(hinstTool, "TimerCount");
    /* Free the TOOLHELP.DLL library module. */
//     FreeLibrary(hLib);
//} else {
//    strcpy(szBuf, "LoadLibrary failed");
//}

  char  ptr[50] ;
 char  str[255] ;
 char  param[255] ;
 char  mes[300] ;
 char  *ptr1 ;
 int p1 ;

 p1=ParamCount() ;
 if (p1==0) {
   strcpy(mes,"Мало параметров  \n");
   strcat(mes,System::CmdLine); //LPTSTR GetCommandLine()
   Application->MessageBox(mes,"new_gpm", MB_OK);
   Application->Terminate();
   return ;
 }

  Edit1->Text=System::CmdLine  ;
  Label1->Caption=System::CmdLine  ;

  param[0]='\0';
  strcpy(param,"");
  for (int i=0;i<=ParamCount();i++)
  {
   if (NULL!=strstr(ParamStr(i).c_str(),"-MDF:"))
   {

   }
   if (NULL!=strstr(ParamStr(i).c_str(),"-CLF:"))
   {

   }
   if (NULL!=strstr(ParamStr(i).c_str(),"-R:"))
   {

   }
   if (NULL!=strstr(ParamStr(i).c_str(),"-O:"))
   {
       Application->MessageBox(ParamStr(i).c_str(),"new_gpm", MB_OK);
   }
   if (NULL!=strstr(ParamStr(i).c_str(),"-L:"))
   {
       
   }
   if (NULL!=strstr(ParamStr(i).c_str(),"-Defo:"))
   {
       Application->MessageBox(ParamStr(i).c_str(),"new_gpm", MB_OK);
   }
   if (NULL!=strstr(ParamStr(i).c_str(),"-PAUSE:"))
   {
       Application->MessageBox(ParamStr(i).c_str(),"new_gpm", MB_OK);
   }

    if (i==0) { /*StatusBar1->SimpleText=""*/ ; }
    else {
     strcat(param, " ") ;
     strcat(param, ParamStr(i).c_str()) ;
     //StatusBar1->SimpleText=StatusBar1->SimpleText + " " + ParamStr(i) ;
     }

    Label1->Caption=Label1->Caption + "\n" + ParamStr(i) ;
   }





 //    Application->Terminate();
}
//---------------------------------------------------------------------------
