{ Задание 1.
 Программный комплекс для расчета функции.
 - на интервале [a,b], n - число значений
}
program Z1;
uses
       Crt;
const
       a=1; { начальная точка  }
       b=20; { конечная точка  }
       n=10; { Число интервалов } 
var
      x,y,h:real;
      i:integer;

{Основная программа}
begin
   ClrScr;
   Writeln('Задание 1 : Расчет значений функции на отрезке. ');
   Writeln;
   Writeln('#####  X  ########### Y ###');
   for i:=0 to n do
     begin
        x:=a+i*(b-a)/n;
        {Проверка аргумента х на принадлежность существования области задания функции}
        if (x<=0.0000) then
           begin
              {По определению логарифма x>0 , y=Ln(x) }
              Writeln(i:3,'#  ',x:8:3,' ### Ошибка Ln(x) : аргумент x<0. Значение функции не определено.....');
          end  else
             if (Abs(Cos(x))<=0.000000001) then
                 begin
                    {По определению тангенса x<>Pi*n+Pi/2 , y=tg(x) }
                    Write(i:3,'#  ',x:8:3);
                    Writeln(' ### Ошибка tg(x) : аргумент x = Pi*n+Pi/2 . Значение функции не определено.....');
                 end else
                  begin
                          {Вычисление функции}
                          {y=( tg(x)+|ln(x^e)| ) / 93 =( tg(x)+e*|ln(x)| ) /93 }
                           y:=(Sin(x)/Cos(x)+Exp(1.0) * Abs(Ln(x)))/93.0;
                           Writeln(i:3,'#  ',x:8:3,' ### ',y:8:3,' #');
                  end;
     end;
     Writeln('For Exit,Press any Key ');
     repeat until KeyPressed ;
end.