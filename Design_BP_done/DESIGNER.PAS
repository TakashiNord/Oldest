program PatternDesigner(input,output);
uses
Crt,Graph;

type
patternType=array[1..8] of byte;

Const
xMin=8;yMin=14;
xMax=161;yMax=159;
xPad=25;yPad=9;
HexDigits:string[16]='0123456789ABCDEF';
Hor=319;Ver=199;
EmptyPattern:patternType=(0,0,0,0,0,0,0,0);
var
PatternArray,Vector:patternType;
Row:byte;
x,y,xPix,yPix,i,j,FlagF:integer;
Color:Word;
Ch:char;
GraphDriver, GraphMode : Integer;

procedure InvertPixel;
var Pixel:integer;
begin
xPix:=(xPad-1)*8+x*8+4;yPix:=(yPad-1)*8+x*8+4;
Pixel:=GetPixel(xPix,yPix);PutPixel(xPix,yPix,3-Pixel);
end;

procedure ChangePad(Insert:integer);
var Mask:byte;
begin
Mask:=128 shr x;
Row:=PatternArray[y];
Row:=Row and (not Mask);
if (Insert=1) then Row:=Row or Mask;
PatternArray[y]:=Row;
xPix:=(xPad-1)*8+x*8+2;yPix:=(yPad-1)*8+x*8+2;
setfillstyle(EmptyFill,2);FloodFill(xPix,yPix,3);
if (Insert=1) then
 begin setfillstyle(SolidFill,2);FloodFill(xPix,yPix,3);end;
 outtextxy(xPad+9,yPad+y,HexDigits[(Row shr 4)+1]);
 outtext(HexDigits[(Row and $F)+1]);
end;

procedure DisplayVector;
begin
 outtextxy(2,23,'(');
 for j:=0 to 7 do begin
 Row:=Vector[j];
 outtext(HexDigits[(Row shr 4)+1]);outtext(HexDigits[(Row and $F)+1]);
 if (j<7) then outtext(',');
 end;
 outtext(')');
end;

procedure DrawGrid;
begin
 setcolor(Color);
 xPix:=(xPad-1)*8;yPix:=(yPad-1)*8;
 for i:=0 to 8 do begin
  line(xPix,yPix+8*i,xPix+64,yPix+8*i);
  line(xPix+8*i,yPix,xPix+8*i,yPix+64);
  if (i<8) then outtextxy(xPad+9,yPad+i,'00');
  end;
end;

procedure DrawPattern;
const xPix=226;yPix=148;
begin
setcolor(color);
Rectangle(xPix,yPix,xPix+11,ypix+11);
for i:=0 to 7 do
 for j:=0 to 7 do
  PutPixel(xPix+2+i,yPix+2+j,3*(Ord(PatternArray[j] and (128 shr i)<>0)));
end;

procedure FillSquare;
begin
setviewPort(xMin+1,yMin+1,xMax-1,yMax-1,ClipOn);
ClearViewPort;
setviewPort(0,0,Hor,Ver,ClipON);
for i:=0 to 7 do begin
 Row:=PatternArray[7-i];
 For j:=0 to 7 do begin
  Vector[j]:=vector[j] shl 1 +Row and 1;
  Row:=Row shr 1;
  end;
end;
 DisplayVector;
 {SetFillPattern(Vector,White);}
 {floodfill((xMax-XMin)/2,(yMax-yMin)/2);}
end;

procedure Initialize;
begin
Cleardevice;ClearViewPort;
SetColor(Color);
Rectangle(0,0,Hor,ver);
SetColor(Color-1);
Rectangle(xMin,yMin,xMax,yMax);
DrawGrid;
outtextxy(23,4,'PatternDesigner');
x:=0;y:=0;
PatternArray:=EmptyPattern;
InvertPixel;
end;

begin

  GraphDriver := Detect;
  InitGraph(GraphDriver, GraphMode, '');
  if GraphResult <> grOk then Halt(1);
  Initialize;
  FlagF:=0;
  repeat
   DrawPattern;
   Ch:=readkey;
   Invertpixel;
   case Ord(Ch) of
   75: x:=x-1;
   77: x:=x+1;
   72: y:=y-1;
   80: y:=y+1;
   82: ChangePad(1);
   83:ChangePad(0);
   61:Initialize;
   60:FillSquare;
   59,27:FlagF:=1;
   end;
   x:=x and 7; y:=y and 7;
   if (Ord(Ch)<>61) then InvertPixel;
   until FlagF=1;
   TextMode(BW80);
   CloseGraph;
end.
