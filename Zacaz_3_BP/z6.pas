{ ������� 6.
  ����������� �������� � �������� �������� ���������� ���������
  ������� ��������������� ��������� ��������� ������������.
}
program Z6;
uses
       Crt;
var
    a,b : real ;
    n : integer ;


{ ����� ������ ������� -> }
{ y=( tg(x)+|ln(x^e)| ) / 93 =( tg(x)+e*|ln(x)| ) /93 }
function Func (x:real) :real ;
begin
  if (x<=0.0000) then
   begin
    {�� ����������� ��������� x>0 , y=Ln(x) }
    Writeln('������ Ln(x) : �������� x - ������������� . ���������� ����� ��������.....');
    Writeln('For Exit,Press any Key ');
    repeat until KeyPressed ;
    Halt(0);
   end;
  if (Abs(Cos(x))<=0.000000001) then
   begin
    {�� ����������� �������� x<>Pi*n+Pi/2 , y=tg(x) }
    Writeln('������ tg(x) : �������� x = Pi*n+Pi/2 . ���������� ����� ��������.....');
    Writeln('For Exit,Press any Key ');
    repeat until KeyPressed ;
    Halt(0);
   end;
  Func:=(Sin(x)/Cos(x)+Exp(1.0) *Abs(Ln(x)))/93.0;
end;



{ ������� ���������� ��������� �� ������� [a,b] }
function Integral (a,b:real;n:integer):real;
var
   Sum:real; {�����}
   x:real ; {��������}
   y:real ; { �������� ������� }
   h:real; {��� ��������������}
   i:integer; { ������������� ����������}
begin
    Sum:=0;
    h:=Abs(b-a)/n;
    for i:=0 to (n-1) do
     begin
           x:=a+i*h;
           y:=Func(x);
           Sum:=Sum+y;
     end;
   {�������� ��������� �������}
   Integral:=h*Sum ;
end;



{�������� ���������}
begin
     ClrScr;
     Writeln('������� 6 : ���������� ��������� ������� ��������������� ');
     Writeln('            ��������� ��������� ������������.. ');
     Writeln;
     Writeln('������� ��������� ���������� : ');
     Writeln;
     Write('������ ������ ��������������  -> a:= ') ; Readln(a);
     Write('������� ������ �������������� -> b:= ') ; Readln(b);
     Write('����� ��������                -> n:= ') ; Readln(n);
     Writeln;
     Writeln(' �������� ��������� I:=',Integral(a,b,n):8:8);
     Writeln;
     Writeln('For Exit,Press any Key ');
     repeat until KeyPressed
end.
