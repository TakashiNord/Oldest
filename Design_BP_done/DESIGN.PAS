program Design(input,output);
 uses
   Crt,Graph3;
type
  PatternType=array[0..7] of byte;

Const
xMin=8;yMin=14;
xMax=161;yMax=159;
xPad=25;yPad=9;
HexDigits:string[16]='0123456789ABCDEF';
Hor=319;Ver=199;
EmptyPattern:PatternType=(0,0,0,0,0,0,0,0);
var
PatternArray,Vector:PatternType;
Mask,Row,Color:byte;
x,y,xPix,yPix,i,j,FlagF,buf:integer;
Ch:char;

procedure DrawBorder(xMin,yMin,xMax,yMax:integer;Color:byte);
begin
 Draw(xMin,yMin,xMax,yMin,Color);  Draw(xMax,yMin,xMax,yMax,Color);
 Draw(xMax,yMax,xMin,yMax,Color);  Draw(xMin,yMax,xMin,yMin,Color);
end;

procedure InvertPixel;
 var Pixel:integer;
begin
 xPix:=(xPad-1)*8+x*8+4;    yPix:=(yPad-1)*8+y*8+4;
 Pixel:=GetDotColor(xPix,yPix);    Plot(xPix,yPix,3-Pixel);
end;

procedure ChangePad(Insert:integer);
begin
Mask:=128 shr x;  Row:=PatternArray[y];  Row:=Row and not Mask;
if (Insert=1) then Row:=Row or Mask;
PatternArray[y]:=Row;
xPix:=(xPad-1)*8+x*8+2;  yPix:=(yPad-1)*8+y*8+2;
FillShape(xPix,yPix,0,2);{FloodFill(xPix,yPix,3);}
if (Insert=1) then
 begin FillShape(xPix,yPix,3,2);
 {setfillstyle(SolidFill,2);FloodFill(xPix,yPix,3);}
 end;
 gotoxy(xPad+9,yPad+y);{outtextxy(xPad+9,yPad+y,HexDigits[(Row shr 4)+1]);}
 Write(HexDigits[(Row shr 4)+1],HexDigits[(Row and $F)+1]);{outtext(HexDigits[(Row and $F)+1]);}
end;

procedure DisplayVector;
begin
 gotoxy(2,23);Write('(');{outtextxy(2,23,'(');}
 for j:=0 to 7 do begin
 Row:=Vector[j];
 Write(HexDigits[(Row shr 4)+1],HexDigits[(Row and $F)+1]);
 {outtext(HexDigits[(Row shr 4)+1]);outtext(HexDigits[(Row and $F)+1]);}
 if (j<7) then Write(',');{outtext(',');}
 end;
 Write(')');{outtext(')');}
end;

procedure DrawGrid;
begin
 xPix:=(xPad-1)*8;  yPix:=(yPad-1)*8;
 for i:=0 to 8 do begin
  Draw(xPix,yPix+8*i,xPix+64,yPix+8*i,2); Draw(xPix+8*i,yPix,xPix+8*i,yPix+64,2);
  if (i<8) then begin gotoxy(xPad+9,yPad+i);Write('00'); end;{outtextxy(xPad+9,yPad+i,'00');}
  end;
end;

procedure DrawPattern;
const xPix=226;yPix=148;
begin
DrawBorder(xPix,yPix,xPix+11,yPix+11,2);
for i:=0 to 7 do
 for j:=0 to 7 do
  Plot(xPix+2+j,yPix+2+i,3*(Ord(PatternArray[i] and (128 shr j)<>0)));
end;

procedure FillSquare;
begin
GraphWindow(xMin+1,yMin+1,xMax-1,yMax-1);
ClearScreen;
GraphWindow(0,0,Hor,Ver);
for i:=0 to 7 do begin
 Row:=PatternArray[7-i];
 For j:=0 to 7 do begin
  Vector[j]:=(Vector[j] shl 1) + Row and 1;
  Row:=Row shr 1;
  end;
end;
 DisplayVector;
 Pattern(Vector);
 FillPattern(xMin+1,yMin+1,xMax-1,yMax-1,3);
 {SetFillPattern(Vector,White);}
 {floodfill((xMax-XMin)/2,(yMax-yMin)/2);}
end;

procedure Initialize;
begin
 ClearScreen;
 DrawBorder(0,0,Hor,ver,3);
 DrawBorder(xMin,yMin,xMax,yMax,2);
 DrawGrid;
 gotoxy(23,4);Write('PatternDesigner');{outtextxy(23,4,'PatternDesigner');}
 x:=0;y:=0;
 PatternArray:=EmptyPattern;
 InvertPixel;
end;

begin

  {GraphDriver := Detect;InitGraph(GraphDriver, GraphMode, '');  if GraphResult <> grOk then Halt(1);}
  GraphColorMode;
  Initialize;
  FlagF:=0;
  repeat
   DrawPattern;
   Ch:=readkey;
   InvertPixel;
   if ((Ord(Ch) and $0ff)=0) then
     case((Ord(Ch) shl 8) and $0ff) of
        71:{home} ;
        72:{Up} y:=y-1;
        73:{PgUp} ;
        75:{Left} x:=x-1;
        77:{Right} x:=x+1;
        79:{End} ;
        80:{Down} y:=y+1;
        81:{PgDn} ;
        82: {Ins}ChangePad(1);
        83:{Del} ChangePad(0);
        61: Initialize;
        60: FillSquare;
        end
      else  case((Ord(Ch) and $0ff)) of
         72:{Up} y:=y-1;
         80:{Down} y:=y+1;
         77:{Right} x:=x+1;
         75:{Left} x:=x-1;
         61:{F3} Initialize;
         60:{F2}FillSquare;
         43:{+} ChangePad(1);
         45:{-} ChangePad(0);
         27:{Esc} FlagF:=1;
         13:{Enter} ChangePad(1);
         32:{SpaceBar} ChangePad(1);
         end;

   x:=x and 7; y:=y and 7;
   if (Ord(Ch)<>61) then InvertPixel;
   until FlagF=1;
   TextMode(co80)
   {CloseGraph;}
end.
