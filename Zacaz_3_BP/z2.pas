{ ������� 2.
  ����������� �������� ��� ����������� ����� ����� �� ����������
  � ����������� ��������� .
}
program Z2;
uses
       Crt;
var
  l_subject:real; {����� ������������ ��������}
  l_udav:real; {����� �����}
  n:integer; { ��������� ����� }

{�������� ���������}
begin
    ClrScr;
    Writeln('������� 2 : ����������� ����� ����� �� ���������� � ����������� ���������. ');
    Writeln;
    Write('':5,'������� �������� ����� �������� (� ��) :='); Readln(l_subject);
    Writeln;
    Write('':5,'������� ��� ����� �������� (� ��) ��������� � ����� :='); Readln(n);
    l_udav:=l_subject*n ;
    Writeln;
    Writeln;
    Writeln('':5,'����� �����  :=' , l_udav :8:3 ,' (��) ' );
    Writeln;
    Writeln;
    Writeln('For Exit,Press any Key ');
    repeat until KeyPressed
end.