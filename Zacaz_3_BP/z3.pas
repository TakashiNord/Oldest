{ ������� 3.
  ����������� �������� ��� ���������� ��������� �������������� ��� �����
  4-� ����� � ������������ �������� �� ��� ����� ��������� �������������� ��� 4-� ���������.
}
program Z3;
uses
       Crt;
var
      a0,a1,a2:real; { ������� �������������� }
      P:real; { �������� }
      i:integer;
      Ch:char;

{�������� ���������}
begin
  while (True) do
   begin
   ClrScr;
   Writeln('������� 3 : ���������� ��������� 4-� ���������. ');
   Writeln;
   Writeln;
   Writeln(' �������� ��� 4-� ���������. ->');
   Writeln;
   Writeln(' 1. �������������              -> 1');
   Writeln(' 2. ������������ 4-� ��������  -> 2');
   Writeln(' 3. ����� �� ���������         -> 3');
   Ch:=ReadKey;
    case Ord(Ch) of
      49 : begin
            ClrScr;
            Writeln ('���������� ��������� �������������� P' );
            Writeln ;
            Write ('������� ������ �������������� a=');  Readln(a1);
            Write ('������� ����� �������������� b=');  Readln(a2);
            P:=a1+a2;
            Writeln ;
            Writeln ('�������� �������������� P= ',P:8:3);
            Writeln;
            Writeln('����� � ���� ,Press any Key ');
            Ch:=ReadKey;
          end ;
      50 : begin
            ClrScr;
            Writeln ('���������� ��������� 4-� ��������a P' );
            Writeln ;
            P:=0;
            for i:=1 to 4 do
             begin
                 Write ('������� ����� ',i:3,' ������� 4-� ��������a =');  Readln(a0);
                 P:=P+a0;
             end;
            Writeln ;
            Writeln ('�������� 4-� ��������� P= ',P:8:3);
            Writeln;
            Writeln('����� � ���� ,Press any Key ');
            Ch:=ReadKey;
          end;
       51 : Halt(0);
       27 :  Halt(0);
     else begin  ; end ;
   end;
 end;
 repeat until KeyPressed
end.