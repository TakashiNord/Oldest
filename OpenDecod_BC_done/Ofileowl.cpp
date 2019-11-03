
// ObjectWindows - (C) Copyright 2001 
#include <stdio.h>
#include <stdlib.h>
//#include <math.h>
#include <dir.h>
#include <string.h>
//#include <time.h>

#include <owl.h>
#include <window.h>
#include <edit.h>
#include <button.h>
#include <groupbox.h>
#include <static.h>

#include <commdlg.h>
#include <filewnd.h>
#include <FILEDIAL.H>

//#include "mfhelp.h"
#include "Ofileowl.h"

const WORD ID_EDIT1NET = 1001;
const WORD  ID_BUTTON1NET =1002;
const WORD  ID_BUTTON2NET= 1003;
const WORD ID_BUTTON3NET= 1004;           
const WORD ID_BUTTON4NET =1005;
const WORD ID_BUTTON5NET=1006;
const WORD ID_GROUPBOX0NET=1006;

char buffilepath[MAXPATH];


class TFileWin : public TWindow {
public:
 // HWND HWindow;
 WORD ChildNum;  HBRUSH BlueBrush;
  PTStatic Static1;  PTEdit Edit1;  TGroupBox *GroupBox0, *GroupBox1;
 char FileName[255];

 TFileWin(PTWindowsObject AParent, LPSTR ATitle);
virtual TFileWin::~TFileWin() { DeleteObject(BlueBrush); }
 virtual void GetWindowClass( WNDCLASS& WndClass );//Icon
 virtual LPSTR GetClassName() {  return ("TFileWin");  };
 virtual void WMControlColor(TMessage& Msg) = [WM_FIRST + WM_CTLCOLOR];
 virtual void Paint( HDC PaintDC, PAINTSTRUCT& PaintInfo);
 virtual void WMGetMinMaxInfo( TMessage& ) = [WM_FIRST + WM_GETMINMAXINFO];
 virtual void WMSize( TMessage& ) = [WM_FIRST + WM_SIZE];

 virtual void OpenFile(HWND HWindow) =  [CM_FIRST + CM_FILEOPEN];

 virtual void CMAbout(RTMessage Msg)= [CM_FIRST + CM_ABOUT] /*About dialog box*/
 { MessageBox(HWindow,"_____\nCopyright(c) 2001","О ПРОГРАММЕ...",MB_OK|MB_ICONASTERISK);  }

//  virtual void HandleButtonMsg1(RTMessage Msg,HWND HWindow)= [ID_FIRST + ID_BUTTON2NET];
//    virtual void CMRUN1(RTMessage Msg)= [CM_FIRST + CM_RUN1];

};

/****************************************************************/
TFileWin:: TFileWin(PTWindowsObject AParent, LPSTR ATitle) :
  TWindow(AParent, "PostProcessor [Преобразования]")
{ 
  getcwd(buffilepath, MAXPATH);
  DisableAutoCreate();
  AssignMenu("Commands");

  Attr.Style |= WS_POPUPWINDOW | WS_CAPTION| WS_DLGFRAME;
  Attr.X = 50;    Attr.Y = 50;     Attr.W = 690;      Attr.H = 255;
 
 GroupBox0 = new TGroupBox(this, ID_GROUPBOX0NET, "Выберите [Файл] для обработки и систему [Станок-ЧПУ]",
    160,5, 415, 200);
 new TStatic(this, -1, "Файл =", 165,25,55, 20, 0);
 Edit1 = new TEdit(this,ID_EDIT1NET, "", 220, 25, 300, 20,255,FALSE);
 new TButton(this, ID_BUTTON1NET, "...->",520, 25,50, 20, TRUE);

 GroupBox1 = new TGroupBox(this,-1, "",165,50, 405, 100);

 new TButton(this, ID_BUTTON2NET, "Справка...",580,15,100,25, FALSE);
 new TButton(this, ID_BUTTON3NET, "Вычисления...",580,45,100, 25, FALSE);
 new TButton(this, ID_BUTTON4NET, "Отмена",580, 75, 100, 25, TRUE);

 new TButton(this, ID_BUTTON5NET, " ",5,5,80,45, FALSE);

 EnableKBHandler();

}


void TFileWin::OpenFile(HWND)//RTMessage
{
 char ChildName[14];char nameMatrix[255];  int FlagCase=2; int i;
/*  Global Variables  */ nameMatrix[0]='\0';

switch(FlagCase) 
{ case 1:
 /*old construction */
 if ( GetApplication()->ExecDialog(new TFileDialog(this, SD_FILEOPEN,_fstrcpy(FileName, "*.*"))) == IDOK )
 {  /*Handle notification messages from button*/
     Edit1->DeleteLine(-1); Edit1->Insert((LPSTR)FileName);
 /****/
 /* Perform file operations. */
 /***/ 
 /*GetApplication()->MakeWindow(new TFileWindow(this, ChildName, FileName));*/
  } 
 else  { /* Edit1->DeleteLine(-1);  FileName[0]='\0';*/ ;}
break;
 case 2:
/*********************************************************************
Using the OPENFILENAME structure and the Windows 3.1 API call
GetOpenFileName() eases the selection of files for the programmer and for
the user.  The WINHELP.EXE help file WIN31WH.HLP The Flags field of the structure is particularly
useful when custimization is required.
**********************************************************************/
OPENFILENAME ofnTemp;
DWORD Errval;/* Error value*/         char buf[5];	/* Error buffer*/
char szTemp[] = "All Files (*.*)\0*.*\0Files (*.apt)\0*.apt\0Files (*.tap)\0*.tap\0Files (*.clf)\0*.clf\0";
/* Note the initialization method of the above string.  The GetOpenFileName()
function expects to find a string in the OPENFILENAME structure that has
a '\0' terminator between strings and an extra '\0' that terminates the
entire filter data set.  Using the technique shown below will fail because
"X" is really 'X' '\0' '\0' '\0' in memory.  */
/*Some Windows structures require the size of themselves in an effort to
provide backward compatibility with future versions of Windows.  If the
lStructSize member is not set the call to GetOpenFileName() will fail. */

	ofnTemp.lStructSize = sizeof( OPENFILENAME );
        ofnTemp.hwndOwner = HWindow; /* An invalid HWindow causes non-modality*/
	ofnTemp.hInstance = 0;
	ofnTemp.lpstrFilter = (LPSTR)szTemp;	/* See previous note concerning string */
	ofnTemp.lpstrCustomFilter = NULL;
	ofnTemp.nMaxCustFilter = 0;
	ofnTemp.nFilterIndex = 1;
	ofnTemp.lpstrFile = (LPSTR)FileName;/* Stores the result in this variable*/
	ofnTemp.nMaxFile = sizeof( FileName );
	ofnTemp.lpstrFileTitle = NULL;
	ofnTemp.nMaxFileTitle = 0;
	ofnTemp.lpstrInitialDir = NULL;
	ofnTemp.lpstrTitle = "Открыть Файл";	/* Title for dialog*/
	ofnTemp.Flags = OFN_FILEMUSTEXIST | OFN_HIDEREADONLY | OFN_PATHMUSTEXIST;
	ofnTemp.nFileOffset = 0;
	ofnTemp.nFileExtension = 0;
	ofnTemp.lpstrDefExt = "*";
	ofnTemp.lCustData = NULL;
	ofnTemp.lpfnHook = NULL;
	ofnTemp.lpTemplateName = NULL;
/* If the call to GetOpenFileName() fails you can call CommDlgExtendedError()
   to retrieve the type of error that occured.*/
	if(GetOpenFileName( &ofnTemp ) != TRUE)
                   { Errval=CommDlgExtendedError();
	  if(Errval!=0)	/* 0 value means user selected Cancel*/
	  { sprintf(buf,"%ld",Errval);
                        strcpy(nameMatrix,"GetOpenFileName returned Error #"); 
                        strcat(nameMatrix,buf);
                        MessageBox(GetFocus(),nameMatrix,"WARNING",MB_OK|MB_ICONSTOP); 
                      }
                    }
if (Errval!=0)
 {  Edit1->DeleteLine(-1); Edit1->Insert((LPSTR)FileName);
   wsprintf(ChildName,"LineNet %d", ChildNum++);
   //GetApplication()->MakeWindow(new TFileWindow(this, ChildName, FileName));
  }
break;
  default : break;
}

FileName[0]='\0';nameMatrix[0]='\0';

}

/*Icon window*/
void TFileWin::GetWindowClass( WNDCLASS& WndClass )
{
  TWindow::GetWindowClass(WndClass);
  WndClass.hbrBackground = (HBRUSH)COLOR_GRAYTEXT ;
  WndClass.hCursor = LoadCursor(NULL, IDC_ARROW); 
  WndClass.hIcon = LoadIcon(GetApplication()->hInstance, "PaintIcon");
};

void  TFileWin::WMGetMinMaxInfo( TMessage& Msg )
{// Limit the minimum size of the window to [width x heigth], so the Win don't   get too small 
//  ((POINT far *)Msg.LParam)[3].x = 655;  ((POINT far *)Msg.LParam)[3].y = 160;
//  ((POINT far *)Msg.LParam)[4].x = 655;  ((POINT far *)Msg.LParam)[4].y = 160;
};

void TFileWin::WMSize( TMessage& Msg )
{
 TWindow::WMSize(Msg);
 if ((Msg.WParam == SIZENORMAL) || (Msg.WParam == SIZEFULLSCREEN))    { ; };
};

void TFileWin::WMControlColor(TMessage& Msg)
{
  switch (Msg.LP.Hi) {
    case CTLCOLOR_BTN:
      Msg.Result = (LRESULT)GetStockObject(NULL_BRUSH);
      break;
    case CTLCOLOR_STATIC:
	SetTextColor((HDC)Msg.WParam,RGB(252, 245, 56) );
	SetBkMode((HDC)Msg.WParam, TRANSPARENT);
	Msg.Result = (LRESULT)GetStockObject(BLACK_BRUSH);//BLACK_BRUSH
      break;
    case CTLCOLOR_DLG:
	SetBkMode((HDC)Msg.WParam, TRANSPARENT);
	Msg.Result = (LRESULT)BlueBrush;
      break;
    default: DefWndProc(Msg);
  }
}
 
void TFileWin::Paint( HDC PaintDC, PAINTSTRUCT& PaintInfo)
{      //COLORREF RGB(cRed, cGreen, cBlue)

TWindow::Paint(PaintDC, PaintInfo);
BeginPaint(HWindow, &PaintInfo);
PaintDC=GetDC(HWindow);

HDC hdcMemory;    HBITMAP hbmpMyBitmap, hbmpOld;    BITMAP bm;
hbmpMyBitmap = LoadBitmap(GetApplication()->hInstance, "Mview");
GetObject(hbmpMyBitmap, sizeof(BITMAP), &bm);
hdcMemory = CreateCompatibleDC(PaintDC);
hbmpOld =(HBITMAP) SelectObject(hdcMemory, hbmpMyBitmap);
BitBlt(PaintDC, 5, 50, bm.bmWidth, bm.bmHeight, hdcMemory, 0, 0, SRCCOPY);
SelectObject(hdcMemory, hbmpOld);
DeleteDC(hdcMemory);

 ReleaseDC(HWindow,PaintDC);// RestoreDC(PaintDC, -1);
 EndPaint(HWindow, &PaintInfo);

}

//*********************************************************************
class TFileApp : public TApplication {
public:
    TFileApp(LPSTR name, HINSTANCE hInstance,HINSTANCE hPrevInstance, LPSTR lpCmd,int nCmdShow)
	        : TApplication(name, hInstance,hPrevInstance, lpCmd, nCmdShow) {};
    virtual void InitMainWindow();
};

/* Construct the TFileApp's MainWindow of type TWindow, loading its menu */
void TFileApp::InitMainWindow() 
{
  MainWindow = new TFileWin(NULL,"Процессоры");
  HAccTable = LoadAccelerators(hInstance, "CommandsAcc");
//HAccTable  = LoadAccelerators(GetApplication()->hInstance, MAKEINTRESOURCE("CommandsAcc"));
  if ( HAccTable == 0 )   Status = EM_INVALIDWINDOW;

}


// Run the MFileApp
int PASCAL WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance,LPSTR lpCmd, int nCmdShow)
{
 TFileApp MFileApp("PostProcessor's", hInstance, hPrevInstance,lpCmd, nCmdShow);
 MFileApp.Run();
 return (MFileApp.Status);
}


