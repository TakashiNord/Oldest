{ Задание 7.
  Программный комплекс для изображения коровы.
}
program Z7;
uses
       Crt, Graph;
var
    Driver,GraphMode,Detect,Mode:integer;

begin
     ClrScr;
     Writeln('Задание 7. - Изображение коровы');
     Writeln;
     {Инициализация графического режима}
     Driver:=Detect;
     GraphMode:=Mode;
     InitGraph(Driver,GraphMode,''); {'D:\BP\BGI'} {E:\TP7\BGI}
     if GraphResult <> grOk then
       begin
        Writeln ('Графический режим не установлен - файл EGAVGA.BGI не найден' );
        Writeln ('для продолжения - нажмите любую клавишу ......' );
        repeat until KeyPressed ;
        Halt(1);
       end;

    {Установка экрана}
    ClearDevice;
    SetViewPort(1,1,GetMaxX,GetMaxY,True);
    SetColor(RED);
    OutTextXY(2,2, 'Задание 7. - Изображение коровы');
    
    SetColor(WHITE);

{   Заготовка функций
     Line(25,400,635,400);
     SetPalette(15,3);
     SetColor(3);
     SetBkColor(4);
     SetTextStyle(0,0,2);
     OutTextXY(400,50,'"р ?   ');
     Bar(60,60,100,399);
     PieSlice(140,140,0,360,2);
     SetLineStyle(0,0,1);
     SetFillStyle(15,i);
     Bar(1,1,GetMaxX-1,GetMaxY-1);
     SetColor(BLACK);
     SetTextStyle(0,0,1);
 }


    SetColor(YELLOW);
    SettextJustify(CenterText, CenterText);
    OutTextXY(Trunc(GetMaxX/2),GetMaxY-20, 'P r e s s   a n y   k e y');
    repeat until KeyPressed;
    { ClearDevice;}
    CloseGraph;{  }

end.
