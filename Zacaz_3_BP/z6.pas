{ Задание 6.
  Программный комплекс и алгоритм перехода вычисления интеграла
  методом прямоугольников используя вложенные подпрограммы.
}
program Z6;
uses
       Crt;
var
    a,b : real ;
    n : integer ;


{ Пусть задана функция -> }
{ y=( tg(x)+|ln(x^e)| ) / 93 =( tg(x)+e*|ln(x)| ) /93 }
function Func (x:real) :real ;
begin
  if (x<=0.0000) then
   begin
    {По определению логарифма x>0 , y=Ln(x) }
    Writeln('Ошибка Ln(x) : параметр x - отрицательный . Вычисление будет прервано.....');
    Writeln('For Exit,Press any Key ');
    repeat until KeyPressed ;
    Halt(0);
   end;
  if (Abs(Cos(x))<=0.000000001) then
   begin
    {По определению тангенса x<>Pi*n+Pi/2 , y=tg(x) }
    Writeln('Ошибка tg(x) : параметр x = Pi*n+Pi/2 . Вычисление будет прервано.....');
    Writeln('For Exit,Press any Key ');
    repeat until KeyPressed ;
    Halt(0);
   end;
  Func:=(Sin(x)/Cos(x)+Exp(1.0) *Abs(Ln(x)))/93.0;
end;



{ Функция вычисления интеграла на отрезке [a,b] }
function Integral (a,b:real;n:integer):real;
var
   Sum:real; {Сумма}
   x:real ; {Аргумент}
   y:real ; { Значение функции }
   h:real; {шаг интегрирования}
   i:integer; { промежуточные переменные}
begin
    Sum:=0;
    h:=Abs(b-a)/n;
    for i:=0 to (n-1) do
     begin
           x:=a+i*h;
           y:=Func(x);
           Sum:=Sum+y;
     end;
   {Значение интеграла функции}
   Integral:=h*Sum ;
end;



{основная программа}
begin
     ClrScr;
     Writeln('Задание 6 : Вычисление интеграла методом прямоугольников ');
     Writeln('            используя вложенные подпрограммы.. ');
     Writeln;
     Writeln('Введите параметры вычисления : ');
     Writeln;
     Write('Нижний предел интегрирования  -> a:= ') ; Readln(a);
     Write('Верхний предел интегрирования -> b:= ') ; Readln(b);
     Write('Число отрезков                -> n:= ') ; Readln(n);
     Writeln;
     Writeln(' Значение интеграла I:=',Integral(a,b,n):8:8);
     Writeln;
     Writeln('For Exit,Press any Key ');
     repeat until KeyPressed
end.
