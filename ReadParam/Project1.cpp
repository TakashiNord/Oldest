//---------------------------------------------------------------------------
#include <vcl\vcl.h>
//#include <vcl.h>
#pragma hdrstop
USERES("Project1.res");
USEFORM("Unit1.cpp", Form1);
//---------------------------------------------------------------------------
WINAPI WinMain(HINSTANCE, HINSTANCE, LPSTR p3, int)
{
        //Application->MessageBox(p3,"new_gpm", MB_OK);
        try
        {
                 Application->Initialize();
                 Application->CreateForm(__classid(TForm1), &Form1);
                 //Form1->StatusBar1->SimpleText= p3;
                 //                 StatusBar1->SimpleText= p3 ;
                 Application->Run();
        }
        catch (Exception &exception)
        {
                 Application->ShowException(&exception);
        }
        return 0;
}
//---------------------------------------------------------------------------
