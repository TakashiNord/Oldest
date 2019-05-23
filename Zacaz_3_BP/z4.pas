{ Задание 4.
 Программный комплекс по определению интеграла функции.
}
program Z4;
uses 
       Crt ;
var
   a,b,e:real;
   Summa:real; {Сумма}
   {Значения интеграла функции при числе интервалов  n и  2n  - соответственно}   
   Integral,I1,I2:real;
   Step:real; {шаг интегрирования}
   x,y,x1,x2:real; {промежуточные переменные }
   n:real; {число интервалов}
   i:real; { промежуточные переменные}

{основная программа}
begin
     ClrScr;
     Writeln('Задание 4 : определение интеграла функции. ');
     Writeln;
     Writeln('Введите параметры вычисления : ');
     Write('Нижний предел интегрирования -> a:= ') ; Readln(a);
     Write('Верхний предел интегрирования -> b:= ') ; Readln(b);
     Write('Tочность -> e:= ') ; Readln(e);
     Writeln;
     Writeln('Вычисление ...............');
     {Вычисление интеграла с заданной точностью e на отрезке [a,b] }
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
	  {Заданная функция}
          {y=( tg(x)+|ln(x^e)| ) / 93 =( tg(x)+e*|ln(x)| ) /93 }
          if (x<=0.0000) then 
           begin
             {По определению логарифма x>0 , y=Ln(x) }
             Writeln('Ошибка Ln(x) : параметр x<0. Вычисление будет прервано.....');
             Writeln('For Exit,Press any Key ');
             repeat until KeyPressed ;
             Halt(0);
           end;
          if (Abs(Cos(x))<=0.000000001) then 
           begin
             {по определению тангенса x<>Pi*n+Pi/2 , y=tg(x) }
             Writeln('Ошибка tg(x) : параметр x = Pi*n+Pi/2 . Вычисление будет прервано.....');
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
                Writeln('Ошибка вычисления интеграла : !');
                Writeln('Неправильно заданы пределы интегрирования. Вычисление будет прервано.....');
                Writeln('For Exit,Press any Key ');
                repeat until KeyPressed ;
                Halt(0);
          end;
     until Abs(I2-I1)<e;
     Integral:=I2 ; {Значение интеграла функции}
     Writeln(' Значение интеграла I:=',Integral:8:4);
     Writeln;
     Writeln('For Exit,Press any Key ');
     repeat until KeyPressed
end.