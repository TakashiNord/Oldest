{ ������� 1.
 ����������� �������� ��� ������� �������.
 - �� ��������� ��������� x
}
program Z1;
uses
       Crt;
var
  x,y:real;
  ChMain:char;
  i:integer;


{�������� ���������}
begin
 ClrScr;
 Writeln('������� 1 : ������ �������� ������� �� ��������� ��������� x. ');
 Writeln;
 Writeln('===  X  ========= Y ===');

 { ����������� ���� - ���� ������������ �� ������ ESC }
 while true  do
  begin

   Write('':5,'������� �������� x:=');
   ChMain:=ReadKey;
    Case ChMain of
      #27: Halt(0);
       else
         if KeyPressed then
          begin
              Write(ChMain);
              if (ChMain=#27) then Halt(0);
          end ;
         Readln(x);
         {�������� ��������� � �� �������������� ������������� ������� ������� �������}
         if (x<=0.0000) then
           begin
              {�� ����������� ��������� x>0 , y=Ln(x) }
              Writeln('#  ',x:8:3,' ### ������ Ln(x) : �������� x<0. �������� ������� �� ����������.....');
           end  else
              if (Abs(Cos(x))<=0.000000001) then
                 begin
                    {�� ����������� �������� x<>Pi*n+Pi/2 , y=tg(x) }
                    Writeln('#  ',x:8:3,' ### ������ tg(x) : �������� x = Pi*n+Pi/2 . �������� ������� �� ����������.....');
                 end else
                  begin
                          {���������� �������}
                          {y=( tg(x)+|ln(x^e)| ) / 93 =( tg(x)+e*|ln(x)| ) /93 }
                           y:=(Sin(x)/Cos(x)+Exp(1.0) *Abs(Ln(x)))/93.0;
                           Writeln('#  ',x:8:3,' ### ',y:8:3,' #');
                  end;
      end ; {End Case }
    end ; {End while}

end.
