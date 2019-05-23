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
  m=10;  {основание исходной системы счисления}
  name1='num10.txt'; { файл с исходными числами }

  n=2 ; {основание системы счисления в которую надо перевести}
  name2='num2.txt'; { файл с преобразованными числами }
  
  dmax=8; {При преобразовании - max число разрядов в дробной части ,
           для предотвращения зацикливания }

var
   rf1,rf2:text;  {указатели на файл}
   P:longint ;
   Sum1,Sum2,Sum:extended ; {real double extended}
   Multiply:extended;
   Num:double ; {число}
   NumInt : longint ; {целая часть числа}
   NumReal : extended ; {дробная часть числа}
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
     Writeln;

     {Открываем исходный файл с числами}
     {$I-} Assign(rf1,name1);Reset(rf1); {$I+}
     if (IOResult<>0) then
       begin
         Writeln('Невозможно открыть файл с числами');
         Writeln('Имя файла:',name1);
         Writeln('для выхода из программы - нажмите любую клавишу ....');
         ReadKey;
         Exit;
       end;

     {Открываем файл для записи преобразованных чисел}
     {$I-} Assign(rf2,name2);Rewrite(rf2);{$I+}
     if (IOResult<>0) then
       begin
         Writeln('Невозможно создать файл для записи');
         Writeln('Имя файла:',name2);
         Writeln('для выхода из программы - нажмите любую клавишу ....');
         ReadKey;
         Exit;
     end;

{Основной алгоритм преобразования}
 Read(rf1,Num);
 while (not Eof(rf1)) do
 begin
     
     NumInt:=Trunc(Num);
     NumReal:=Frac(Num);

     {Перевод целой части числа}
     Head:=nil;
     i:=0;  Multiply :=1;
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

    {Перевод дробной части числа}
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

    {Обьединение обоих частей}
    Sum:=Sum1 ;
    if Not(Sum2=0.0) then Sum:=Sum1+Sum2 ;

    Writeln (rf2,Sum:10:10);
    Read(rf1,Num);
 end ;

 {Закрываем указатели на файлы}
 Close(rf1);
 Close(rf2);

 Writeln('Файл =',name2,' создан. Преобразование завершено ..... ');

 Writeln;
 Writeln('For Exit,Press any Key ');
 repeat until KeyPressed
end.