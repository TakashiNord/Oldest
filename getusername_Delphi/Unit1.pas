unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
const
  MAX_SIZE=256;
var
   i: Cardinal;
   str : array [0..MAX_SIZE] of char;
   S:string ;
begin
    i:= MAX_SIZE;
    GetUserName(str,i);
    S:=str;
    Label1.Caption:=S;
  end;

end.
