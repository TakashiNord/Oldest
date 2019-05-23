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
  m=10;  {��������� �������� ������� ���������}
  name1='num10.txt'; { ���� � ��������� �������}

  n=2 ; {��������� ������� ��������� � ������� ���� ���������}
  name2='num2.txt'; { ���� � ���������������� ������� }
  
  dmax=8; {��� �������������� - max ����� �������� � ������� ����� ,
           ��� �������������� ������������ }

var
   rf1,rf2:text;  {��������� �� ����}
   P:longint ;
   Sum1,Sum2,Sum:extended ; {real double extended}
   Multiply:extended;
   Num:double ; {�����}
   NumInt : longint ; {����� ����� �����}
   NumReal : extended ; {������� ����� �����}
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
     Writeln;

     {��������� �������� ���� � �������}
     {$I-} Assign(rf1,name1);Reset(rf1); {$I+}
     if (IOResult<>0) then
       begin
         Writeln('���������� ������� ���� � �������');
         Writeln('��� �����:',name1);
         Writeln('��� ������ �� ��������� - ������� ����� ������� ....');
         ReadKey;
         Exit;
       end;

     {��������� ���� ��� ������ ��������������� �����}
     {$I-} Assign(rf2,name2);Rewrite(rf2);{$I+}
     if (IOResult<>0) then
       begin
         Writeln('���������� ������� ���� ��� ������');
         Writeln('��� �����:',name2);
         Writeln('��� ������ �� ��������� - ������� ����� ������� ....');
         ReadKey;
         Exit;
     end;

{�������� �������� ��������������}
 Read(rf1,Num);
 while (not Eof(rf1)) do
 begin
     
     NumInt:=Trunc(Num);
     NumReal:=Frac(Num);

     {������� ����� ����� �����}
     Head:=nil;
     i:=0;  Multiply :=1;
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
     end;
    Tail:=Head;
    Sum1:=0;
    while(Tail<>nil) do begin
       P:=Tail^.IntN;
       i:=i-1; Multiply:=Multiply/10.;
       {Sum1:=Sum1+ Exp( i *Ln (10) ) *  P ;}
       Sum1:=Sum1+ Multiply *  P ;
       Tail:=Tail^.Ref;
    end;
    Sum1:=Int(Sum1);

    {������� ������� ����� �����}
    Sum2:=0;
    i:=0; Multiply :=1;
    while ((NumReal<>0) And (i<>dmax)) do
    begin
         i:=i+1; Multiply:=Multiply *10 ;
         NumReal:=NumReal*n;
         P:=Trunc(NumReal);
         NumReal:=Frac(NumReal);
         {Sum2:=Sum2+ P / Exp( i *Ln (10) ) ;}
         Sum2:=Sum2+ P * Multiply ;
     end;
    Multiply:=Multiply *10 ;
    Sum2:=Int(Sum2);
    Sum2:=Sum2 / Multiply ;

    {����������� ����� ������}
    Sum:=Sum1 ;
    if Not(Sum2=0.0) then Sum:=Sum1+Sum2 ;

    Writeln (rf2,Sum:10:10);
    Read(rf1,Num);
 end ;

 {��������� ��������� �� �����}
 Close(rf1);
 Close(rf2);

 Writeln('���� =',name2,' ������. �������������� ��������� ..... ');

 Writeln;
 Writeln('For Exit,Press any Key ');
 repeat until KeyPressed
end.