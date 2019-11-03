//---------------------------------------------------------------------------

#ifndef MainH
#define MainH
//---------------------------------------------------------------------------
#include <Classes.hpp>
#include <Controls.hpp>
#include <StdCtrls.hpp>
#include <Forms.hpp>
#include <ComCtrls.hpp>
#include <ExtCtrls.hpp>
#include <ToolWin.hpp>
#include <FileCtrl.hpp>
#include <ImgList.hpp>
//---------------------------------------------------------------------------
class TFormMain : public TForm
{
__published:	// IDE-managed Components
        TPanel *Panel1;
        TToolBar *ToolBar1;
        TPanel *Panel3;
        TPanel *Panel4;
        TToolButton *ToolButton1;
        TToolButton *ToolButton2;
        TToolButton *ToolButton3;
        TToolButton *ToolButton4;
        TDriveComboBox *DriveComboBox1;
        TDirectoryListBox *DirectoryListBox1;
        TFilterComboBox *FilterComboBox1;
        TFileListBox *FileListBox1;
        TMemo *MemoStr;
        TPanel *Panel5;
        TImageList *ImageListMainTool;
        TGroupBox *GroupBox1;
        TComboBox *ComboBoxFormat;
        TGroupBox *GroupBox2;
        TComboBox *ComboBoxInterval;
        TEdit *EditStartNumber;
        TEdit *EditStartLine;
        TEdit *EditRestartLine;
        TEdit *EditString;
        TLabel *Label1;
        TLabel *Label2;
        TLabel *Label3;
        TToolBar *ToolBarMet;
        TLabel *Label4;
        TLabel *Label5;
        TCheckBox *CheckBoxFileFilter;
        TCheckBox *CheckBoxN;
        TToolButton *ToolButton5;
        TToolButton *ToolButton6;
        void __fastcall ToolButton3Click(TObject *Sender);
        void __fastcall ToolButton4Click(TObject *Sender);
        void __fastcall FormCreate(TObject *Sender);
        void __fastcall ToolButton2Click(TObject *Sender);
        void __fastcall ToolButton1Click(TObject *Sender);
private:	// User declarations
public:		// User declarations
        __fastcall TFormMain(TComponent* Owner);
        void MessageOutput(AnsiString S);
};
//---------------------------------------------------------------------------
extern PACKAGE TFormMain *FormMain;
//---------------------------------------------------------------------------
#endif
