Unit preparation;

Interface
Uses crt;
Type
 mas = array[1..50] of byte;
 pref = (none,rep,repe,repne);
 coms = (cmpsb,movsb,scasb,lodsb,stosb);
 command = Record
  povt: pref;
  strcom: coms;
 end;
procedure intro;
procedure start(var str1,str2: mas; var esi,edi: byte; var al: char; var ecx: byte; var df: boolean; var com: command);
procedure hint(c: char);



var
    str1,str2: mas;
    esi,edi: byte;
    al: char;
    df: boolean;
    ecx: byte;
    com: command;

Implementation

var F: text;

procedure intro;
  var Symbol: char;
     SpecialStroka: string;
 begin
  clrscr;
  TextBackGround(White);
  clrscr;
  TextColor(Red);
  GOTOXY(30,6);
  readln(f,SpecialStroka);
  writeln(SpecialStroka);
  GOTOXY(27,7);
  TextColor(darkgray);
  readln(f,SpecialStroka);
  writeln(SpecialStroka);
  TextColor(blue);
  GOTOXY(31,8);
  readln(f,SpecialStroka);
  writeln(SpecialStroka);
  GOTOXY(31,9);
  readln(f,SpecialStroka);
  writeln(SpecialStroka);
  GOTOXY(31,10);
  readln(f,SpecialStroka);
  writeln(SpecialStroka);
  TextBackGround(Red);
  TextColor(lightgreen);
  GOTOXY(28,11);
  readln(f,SpecialStroka);
  writeln(SpecialStroka);
  TextBackGround(White);
  TextColor(magenta);
  GOTOXY(17,12);
  readln(f,SpecialStroka);
  writeln(SpecialStroka);
  TextBackGround(Red);
  TextColor(lightgreen);
  GOTOXY(22,13);
  readln(f,SpecialStroka);
  writeln(SpecialStroka);
  TextBackGround(White);
  TEXTCOLOR(black);
  GOTOXY(1,15);
  readln(f,SpecialStroka);
  writeln(SpecialStroka);
  GOTOXY(1,16);
  readln(f,SpecialStroka);
  writeln(SpecialStroka);
  GOTOXY(1,17);
  readln(f,SpecialStroka);
  writeln(SpecialStroka);
  GOTOXY(1,18);
  readln(f,SpecialStroka);
  writeln(SpecialStroka);
  GOTOXY(1,19);
  readln(f,SpecialStroka);
  writeln(SpecialStroka);
  GOTOXY(1,20);
  readln(f,SpecialStroka);
  writeln(SpecialStroka);
  GOTOXY(1,21);
  readln(f,SpecialStroka);
  writeln(SpecialStroka);
  GOTOXY(1,22);
  readln(f,SpecialStroka);
  writeln(SpecialStroka);
  GOTOXY(30,25);
  TextColor(RED);
  writeln('<Press any key>');
  Symbol:= Readkey;
 end;


procedure start(var str1,str2: mas; var esi,edi: byte; var al: char; var ecx: byte; var df: boolean; var com: command);
 var i: integer;
     Symbol: char;
     SpecialSymbol: string;
 begin
  TextBackGround(Black);
  clrscr;
  for i:= 1 to 50 do
   str1[i]:= ord('0');
  for i:= 1 to 50 do
   str2[i]:= ord('0');
  esi:= 1;
  edi:= 51;
  al:= 'a';
  ecx:= 0;
  df:= False;
  com.povt:= none;
  com.strcom:= cmpsb;
  TextBackGround(cyan);
  TextColor(white);
  Window(5,3,54,3);
  clrscr;
  for i:= 1 to 50 do
   write(0);
  Window(5,8,54,8);
  clrscr;
  for i:= 1 to 50 do
   write(0);
  Window(1,1,80,24);
  TextBackGround(black);
  GOTOXY(esi + 3,1);
  write('esi');
  GOTOXY(esi + 4,2);
  write('|');
  GOTOXY(edi - 50 + 3, 10);
  write('edi');
  GOTOXY(edi - 50 + 4, 9);
  write('|');
  TextBackGround(green);
  Window(5,12,12,14);
  clrscr;
  write('DF=');
  if DF then
   write('1')
  else
   write('0');
  writeln(' ->');
  write('AL="');
  write(al);
  writeln('"');
  write('ECX=');
  if ecx < 10 then
   write('0');
  write(ecx);
  TextBackGround(black);
  Window(1,1,80,24);
  TextColor(yellow);
  GOTOXY(5,11);
  write('Setting');
  GOTOXY(15,11);
  write('Command');
  TextBackGround(blue);
  Window(15,12,25,12);
  clrscr;
  TextColor(white);
  write(com.povt,'  ', com.strcom);
  Window(1,1,80,24);
  GOTOXY(27,11);
  TextColor(yellow);
  TextBackGround(black);
  write('Explanation');
  TextBackGround(blue);
  Window(27,12,44,12);
  clrscr;
  TextColor(white);
  write('cmp [edi],[esi]');
  Window(1,1,80,24);
  GOTOXY(25,25);
  GOTOXY(46,11);
  TextColor(yellow);
  TextBackGround(black);
  write('Last action');
  TextBackGround(yellow);
  Window(46,12,60,12);
  clrscr;
  TextColor(white);
  Window(1,1,80,24);
  TextColor(yellow);
  TextBackGround(black);
  GOTOXY(62,7);
  write('Instructions');
  TextBackGround(green);
  TextColor(white);
  Window(62,8,76,19);
  clrscr;
  for i:= 1 to 10 do
   begin
    readln(f,SpecialSymbol);
    writeln(SpecialSymbol);
   end;
  readln(f,SpecialSymbol);
  write(SpecialSymbol);
  TextBackGround(black);
  window(62,19,76,20);
  clrscr;
  TextColor(yellow);
  window(1,1,80,24);
  GOTOXY(62,2);
  write('Hint');
  TextColoR(white);
  TextBackGround(green);
  Window(62,3,76,5);
  clrscr;
  Window(1,1,80,24);
 end;




 procedure hint(c: char);
  var i: integer;
      SpecialSymbol: string;
      g: text;
  begin
   assign(g,'/Users/timmy/Desktop/Pas/Prak2Sem/prak_pas_final/hint.txt');
   reset(g);
   i:= 0;
   case c of
    '0': i:= 1;
    'v': i:= 2;
    's': i:= 3;
    'd': i:= 4;
    'a': i:= 5;
    'c': i:= 6;
    'k': i:= 7;
   end;
   if i <> 0 then
    begin
     while i <> 1 do
      begin
       readln(g,SpecialSymbol);
       i:= i - 1;
      end;
     readln(g,SpecialSymbol);
     TextColor(white);
     TextBackGround(green);
     Window(62,3,76,5);
     writeln(SpecialSymbol);
     Window(1,1,80,24);
     GOTOXY(1,1);
    end;
   close(g);
  end;


begin
 assign(f,'/Users/timmy/Desktop/Pas/Prak2Sem/prak_pas_final/open.txt');
 reset(f);
end.
