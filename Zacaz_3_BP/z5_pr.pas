{ ������� 5.
  ����������� �������� ��� �������� ����� �� ����� ������� ���������� � ������
  ����� ���������� � �����.
}
program Z5;
uses
    Crt;
type
   Pointer=^Pair;
   Pair=record
         IntN:longint;
         Ref:Pointer;
        end;
const
  m=10 ;  {��������� �������� ������� ���������}
  name1='num1.txt'; { ���� � ��������� �������}

  n=2 ; {��������� ������� ��������� � ������� ���� ���������}
  name2='num2.txt'; { ���� � ���������������� ������� }
  
  dmax=8; {��� �������������� - max ����� �������� � ������� ����� ,
           ��� �������������� ������������ }

var
   rf1,rf2:text;  {��������� �� ����}
   P:longint ;
   Multiply:extended;
   Sum1,Sum2,Sum:extended ;
   Num:real ; {�����}
   NumInt : longint ; {����� ����� �����}
   NumReal : real ; {������� ����� �����}
   i:longint; {������� �����}
   Head,Tail:Pointer;

{�������� ���������}
begin
     ClrScr;
     Writeln('������� 6 : ������� ����� �� ����� ������� ���������� � ������');
     Writeln('            ����� ���������� � ����� .. ');
     Writeln;
     Writeln('����  : ');
     Writeln('���� =',name1, '  � �������  �  ',m, ' ������� ���������. ');
     Writeln('��������� ����� � -> ');
     Writeln('���� =',name2, '  � �������  �  ',n, ' ������� ���������. ');
     Writeln;

     Writeln(' ');

{�������� �������� ��������������}

     Num:=0.78960;
     NumInt:=Trunc(Num);
     NumReal:=Frac(Num);
     {������� ����� ����� �����}
     Head:=nil;
     i:=0; Multiply :=1;
     while (NumInt>=1) do
     begin
           P:=NumInt mod n ; {������� �� �������}
           NumInt:=NumInt div n ; {����� ����� �� �������}
           New(Tail);
           Tail^.IntN:=P;
           Tail^.Ref:=Head;
           Head:=Tail;
           i:=i+1 ; {������� ����� ��������}
           Multiply:=Multiply*10;
           Writeln('    NumInt ' ,NumInt , ' i =',i);
     end;
    Tail:=Head;
    Sum1:=0;
    while(Tail<>nil) do begin
       P:=Tail^.IntN;
       i:=i-1;
       Multiply:=Multiply/10.;
       Writeln(' P = ' ,P , ' i =',i);
       {Sum1:=Sum1+ Exp( i *Ln (10) ) *  P ;}
       Sum1:=Sum1+ Multiply *  P ;
       Tail:=Tail^.Ref;
    end;
    Sum1:=Int(Sum1);
    Writeln('Sum1==',Sum1:15:8);

    {������� ������� ����� �����}
    Sum2:=0;
    i:=0; Multiply:=1 ;
    while ((NumReal<>0) And (i<>dmax)) do
    begin
         i:=i+1; Multiply:=Multiply *10 ;
         NumReal:=NumReal*n;
         P:=Trunc(NumReal);
         NumReal:=Frac(NumReal);
         {Sum2:=Sum2+ P / Exp( i *Ln (10) ) ;}
         Sum2:=Sum2+ P * Multiply ;
         Writeln('NumReal =',NumReal,'    P=' ,P, '  i =',i);
     end;
    Multiply:=Multiply *10 ;
    Sum2:=Sum2 / Multiply ;
    Writeln('Sum2==',Sum2:15:8);

    Sum:=Sum1+Sum2 ;
    Writeln('Sum==',Sum:15:15);

 Writeln;
 Writeln('For Exit,Press any Key ');
 repeat until KeyPressed
end.