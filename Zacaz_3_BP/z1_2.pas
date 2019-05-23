{ Задание 1.
 Программный комплекс для расчета функции.
 - по введенным значениям x
}
program Z1;
uses
       Crt;
var
  x,y:real;
  ChMain:char;
  i:integer;


{Основная программа}
begin
 ClrScr;
 Writeln('Задание 1 : Расчет значений функции по введенным значениям x. ');
 Writeln;
 Writeln('===  X  ========= Y ===');

 { Бесконечный цикл - пока пользователь не нажмет ESC }
 while true  do
  begin

   Write('':5,'Введите значение x:=');
   ChMain:=ReadKey;
    Case ChMain of
      #27: Halt(0);
       else
         if KeyPressed then
          begin
              Write(ChMain);
              if (ChMain=#27) then Halt(0);
          end ;
         Readln(x);
         {Проверка аргумента х на принадлежность существования области задания функции}
         if (x<=0.0000) then
           begin
              {По определению логарифма x>0 , y=Ln(x) }
              Writeln('#  ',x:8:3,' ### Ошибка Ln(x) : аргумент x<0. Значение функции не определено.....');
           end  else
              if (Abs(Cos(x))<=0.000000001) then
                 begin
                    {По определению тангенса x<>Pi*n+Pi/2 , y=tg(x) }
                    Writeln('#  ',x:8:3,' ### Ошибка tg(x) : аргумент x = Pi*n+Pi/2 . Значение функции не определено.....');
                 end else
                  begin
                          {Вычисление функции}
                          {y=( tg(x)+|ln(x^e)| ) / 93 =( tg(x)+e*|ln(x)| ) /93 }
                           y:=(Sin(x)/Cos(x)+Exp(1.0) *Abs(Ln(x)))/93.0;
                           Writeln('#  ',x:8:3,' ### ',y:8:3,' #');
                  end;
      end ; {End Case }
    end ; {End while}

end.
