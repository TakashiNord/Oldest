{ ������� 1.
 ����������� �������� ��� ������� �������.
 - �� ��������� [a,b], n - ����� ��������
}
program Z1;
uses
       Crt;
const
       a=1; { ��������� �����  }
       b=20; { �������� �����  }
       n=10; { ����� ���������� } 
var
      x,y,h:real;
      i:integer;

{�������� ���������}
begin
   ClrScr;
   Writeln('������� 1 : ������ �������� ������� �� �������. ');
   Writeln;
   Writeln('#####  X  ########### Y ###');
   for i:=0 to n do
     begin
        x:=a+i*(b-a)/n;
        {�������� ��������� � �� �������������� ������������� ������� ������� �������}
        if (x<=0.0000) then
           begin
              {�� ����������� ��������� x>0 , y=Ln(x) }
              Writeln(i:3,'#  ',x:8:3,' ### ������ Ln(x) : �������� x<0. �������� ������� �� ����������.....');
          end  else
             if (Abs(Cos(x))<=0.000000001) then
                 begin
                    {�� ����������� �������� x<>Pi*n+Pi/2 , y=tg(x) }
                    Write(i:3,'#  ',x:8:3);
                    Writeln(' ### ������ tg(x) : �������� x = Pi*n+Pi/2 . �������� ������� �� ����������.....');
                 end else
                  begin
                          {���������� �������}
                          {y=( tg(x)+|ln(x^e)| ) / 93 =( tg(x)+e*|ln(x)| ) /93 }
                           y:=(Sin(x)/Cos(x)+Exp(1.0) * Abs(Ln(x)))/93.0;
                           Writeln(i:3,'#  ',x:8:3,' ### ',y:8:3,' #');
                  end;
     end;
     Writeln('For Exit,Press any Key ');
     repeat until KeyPressed ;
end.