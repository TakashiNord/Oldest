{ Задание 5.
  Программный комплекс для перевода чисел из одной системы исчисления в другую
  чисел записанных в файле.
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
  m=10 ;  {основание исходной системы счисления}
  name1='num1.txt'; { файл с исходными числами }

  n=2 ; {основание системы счисления в которую надо перевести}
  name2='num2.txt'; { файл с преобразованными числами }
  
  dmax=8; {При преобразовании - max число разрядов в дробной части ,
           для предотвращения зацикливания }

var
   rf1,rf2:text;  {указатели на файл}
   P:longint ;
   Multiply:extended;
   Sum1,Sum2,Sum:extended ;
   Num:real ; {число}
   NumInt : longint ; {целая часть числа}
   NumReal : real ; {дробная часть числа}
   i:longint; {степень числа}
   Head,Tail:Pointer;

{основная программа}
begin
     ClrScr;
     Writeln('Задание 6 : Перевод чисел из одной системы исчисления в другую');
     Writeln('            чисел записанных в файле .. ');
     Writeln;
     Writeln('Дано  : ');
     Writeln('Файл =',name1, '  с числами  в  ',m, ' системе счисления. ');
     Writeln('Переведем числа в -> ');
     Writeln('Файл =',name2, '  с числами  в  ',n, ' системе счисления. ');
     Writeln;

     Writeln(' ');

{Основной алгоритм преобразования}

     Num:=0.78960;
     NumInt:=Trunc(Num);
     NumReal:=Frac(Num);
     {Перевод целой части числа}
     Head:=nil;
     i:=0; Multiply :=1;
     while (NumInt>=1) do
     begin
           P:=NumInt mod n ; {остаток от деления}
           NumInt:=NumInt div n ; {целая часть от деления}
           New(Tail);
           Tail^.IntN:=P;
           Tail^.Ref:=Head;
           Head:=Tail;
           i:=i+1 ; {подсчет числа степеней}
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

    {Перевод дробной части числа}
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