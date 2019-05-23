{ Задание 3.
  Программный комплекс для вычисления периметра прямоугольника при вводе
  4-х чисел с определением является ли эти числа сторонами прямоугольника или 4-х угольника.
}
program Z3;
uses
       Crt;
var
      a0,a1,a2:real; { Стороны прямоугольника }
      P:real; { Периметр }
      i:integer;
      Ch:char;

{Основная программа}
begin
  while (True) do
   begin
   ClrScr;
   Writeln('Задание 3 : Вычисление периметра 4-х угольника. ');
   Writeln;
   Writeln;
   Writeln(' Выберите вид 4-х угольника. ->');
   Writeln;
   Writeln(' 1. Прямоугольник              -> 1');
   Writeln(' 2. Произвольный 4-х угольник  -> 2');
   Writeln(' 3. Выход из программы         -> 3');
   Ch:=ReadKey;
    case Ord(Ch) of
      49 : begin
            ClrScr;
            Writeln ('Вычисление периметра прямоугольника P' );
            Writeln ;
            Write ('Введите ширину прямоугольника a=');  Readln(a1);
            Write ('Введите длину прямоугольника b=');  Readln(a2);
            P:=a1+a2;
            Writeln ;
            Writeln ('Периметр прямоугольника P= ',P:8:3);
            Writeln;
            Writeln('выход в меню ,Press any Key ');
            Ch:=ReadKey;
          end ;
      50 : begin
            ClrScr;
            Writeln ('Вычисление периметра 4-х угольникa P' );
            Writeln ;
            P:=0;
            for i:=1 to 4 do
             begin
                 Write ('Введите длину ',i:3,' стороны 4-х угольникa =');  Readln(a0);
                 P:=P+a0;
             end;
            Writeln ;
            Writeln ('Периметр 4-х угольника P= ',P:8:3);
            Writeln;
            Writeln('выход в меню ,Press any Key ');
            Ch:=ReadKey;
          end;
       51 : Halt(0);
       27 :  Halt(0);
     else begin  ; end ;
   end;
 end;
 repeat until KeyPressed
end.