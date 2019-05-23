{ Задание 2.
  Программный комплекс для определения длины удава по фотографии
  с посторонним предметом .
}
program Z2;
uses
       Crt;
var
  l_subject:real; {длина постороннего предмета}
  l_udav:real; {длина удава}
  n:integer; { кратность длины }

{Основная программа}
begin
    ClrScr;
    Writeln('Задание 2 : Определение длины удава по фотографии с посторонним предметом. ');
    Writeln;
    Write('':5,'Введите значение длины предмета (в см) :='); Readln(l_subject);
    Writeln;
    Write('':5,'Сколько раз длина предмета (в см) умещается в удаве :='); Readln(n);
    l_udav:=l_subject*n ;
    Writeln;
    Writeln;
    Writeln('':5,'Длина удава  :=' , l_udav :8:3 ,' (см) ' );
    Writeln;
    Writeln;
    Writeln('For Exit,Press any Key ');
    repeat until KeyPressed
end.