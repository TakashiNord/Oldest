{ ������� 4.
 ����������� �������� �� ����������� ��������� �������.
}
program Z4;
uses 
       Crt ;
var
   a,b,e:real;
   Summa:real; {�����}
   {�������� ��������� ������� ��� ����� ����������  n �  2n  - ��������������}   
   Integral,I1,I2:real;
   Step:real; {��� ��������������}
   x,y,x1,x2:real; {������������� ���������� }
   n:real; {����� ����������}
   i:real; { ������������� ����������}

{�������� ���������}
begin
     ClrScr;
     Writeln('������� 4 : ����������� ��������� �������. ');
     Writeln;
     Writeln('������� ��������� ���������� : ');
     Write('������ ������ �������������� -> a:= ') ; Readln(a);
     Write('������� ������ �������������� -> b:= ') ; Readln(b);
     Write('T������� -> e:= ') ; Readln(e);
     Writeln;
     Writeln('���������� ...............');
     {���������� ��������� � �������� ��������� e �� ������� [a,b] }
     I2:=0;
     n:=1;
     repeat
         I1:=I2;
         Summa:=0;
         Step:=(b-a)/n;
         x1:=a;
         i:=0;
         while (i<=n) do 
         begin 
	  x2:=x1+Step;
	  x:=(x1+x2)/2;
	  {�������� �������}
          {y=( tg(x)+|ln(x^e)| ) / 93 =( tg(x)+e*|ln(x)| ) /93 }
          if (x<=0.0000) then 
           begin
             {�� ����������� ��������� x>0 , y=Ln(x) }
             Writeln('������ Ln(x) : �������� x<0. ���������� ����� ��������.....');
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
           y:=(Sin(x)/Cos(x)+Exp(1) *Abs(Ln(x)))/93.0;
           Summa:=y+Summa;
           x1:=x2 ;
           i:=i+1;
         end;
         I2:=Step*Summa;
         n:=2*n ;
         if (n>1000.0) then
          begin
                Writeln('������ ���������� ��������� : !');
                Writeln('����������� ������ ������� ��������������. ���������� ����� ��������.....');
                Writeln('For Exit,Press any Key ');
                repeat until KeyPressed ;
                Halt(0);
          end;
     until Abs(I2-I1)<e;
     Integral:=I2 ; {�������� ��������� �������}
     Writeln(' �������� ��������� I:=',Integral:8:4);
     Writeln;
     Writeln('For Exit,Press any Key ');
     repeat until KeyPressed
end.