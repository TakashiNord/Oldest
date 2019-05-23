program KeyBoard(input,output);
 uses
   Crt;
 var
  Ch:char;
  Flag:integer;
  X, Y: Byte;
begin
  TextMode(CO80);
  NormVideo; { Original attribute }
  TextColor(Blue);{RED}
  TextBackground(Yellow);{Black}
  ClrScr; { Clear screen }
  Writeln('Program NumCode KeyBoard.');
  Writeln('For exit Press ESC(Code=27)');
  Writeln('TurboPascal 7.0 18.07.2001');
  { Draw  windows } Window(20, 8, 50 , 12);
  Flag:=0;
    repeat
     Write('Press key:?->');
     Ch:=readkey;
     writeln;
     writeln('Ch= ',Ch,'  Code(ASCII value)=',Ord(Ch));
     if 27=Ord(Ch) then Flag:=1;
    until Flag=1;
  TextMode(Bw80);
end.
