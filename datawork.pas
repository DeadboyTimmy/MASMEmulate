Unit datawork;

Interface
uses crt;

Type
    mas = array[1..50] of byte;


procedure randstr(var str1: mas; num: integer);
procedure inputstr(var str1, str2: mas);
procedure chDF(var df: boolean);
procedure chreg(var r: byte; mode: char);
procedure chal(var al: char);
{procedure chDF(var df: boolean);}

var
    cursor: byte;

Implementation


procedure chal(var al: char);
var al1, al2: char;
    k: boolean;
begin
    Window(8,13,12,13);
    GOTOXY(1,1);
    TextBackGround(green);
    k := False;
    repeat
        al1 := ReadKey;
        if (not k) then
        begin
            k := not k;
            if (al1 <> #27) and (al1 <> #13) and (al1 <> #8) then
                al2 := al1;
        end;
        if al1 = #8 then
            begin
                clrscr;
                k := not k;
            end
        else
            begin
                clrscr;
                write('"', al2, '"');
            end;
    until (al1 = #27) or (al1 = #13);
    clrscr;
    write('"', al2, '"');
    al := al2;
end;

procedure chDF(var df: boolean);
begin
    df := not df;
    Window(8,12,12,12);
    TextBackGround(green);
    if df then
        write('1 <-')
    else
        write('0 ->');
end;

procedure randstr(var str1: mas; num: integer);
var i: integer;
    code: byte;
begin
    randomize;
    if num = 1 then
        Window(5,3,55,3)
    else
        Window(5,8,55,8);
    clrscr;
    TextBackGround(cyan);
    for i:= 1 to 50 do
    begin
        code := random(93) + 33;
        str1[i] := code;
        write(chr(code));
    end;
    Window(55,3,55,3);
    TextBackGround(black);
    clrscr;
    Window(55,8,55,8);
    TextBackGround(black);
    clrscr;
end;

procedure esiWindow(r: byte; mode: boolean);
begin
    Window(3, 1, 59, 2);
    TextBackGround(black);
    clrscr;
    Window(3, 6, 59, 7);
    TextBackGround(black);
    clrscr;
    if mode then
    begin
        Window(5, 2, 58, 2);
        TextBackGround(black);
        GOTOXY(r, 1);
        write('|');
        Window(3, 1, 58, 1);
        TextBackGround(black);
        GOTOXY(r+1, 1);
        write('esi');
        Window(5, 3, 58, 3);
        GOTOXY(r, 1);
        TextBackGround(cyan);
    end
    else
    begin
        Window(4, 7, 58, 7);
        TextBackGround(black);
        GOTOXY(r+1, 1);
        write('|');
        Window(3, 6, 58, 6);
        TextBackGround(black);
        GOTOXY(r+1, 1);
        write('esi');
        Window(5, 8, 58, 8);
        GOTOXY(r, 1);
        TextBackGround(cyan);
    end;
end;

procedure ediWindow(r: byte; mode: boolean);
begin
    Window(3, 9, 59, 10);
    TextBackGround(black);
    clrscr;
    Window(3, 4, 59, 5);
    TextBackGround(black);
    clrscr;
    if mode then
    begin
        Window(5, 9, 55, 9);
        TextBackGround(black);
        GOTOXY(r, 1);
        write('|');
        Window(3, 10, 59, 10);
        TextBackGround(black);
        GOTOXY(r+1, 1);
        write('edi');
        Window(5, 8, 59, 8);
        GOTOXY(r, 1);
        TextBackGround(cyan);
    end
    else
    begin
        Window(5, 4, 59, 4);
        TextBackGround(black);
        GOTOXY(r, 1);
        write('|');
        Window(3, 5, 59, 5);
        TextBackGround(black);
        GOTOXY(r+1, 1);
        write('edi');
        Window(5, 3, 59, 3);
        GOTOXY(r, 1);
        TextBackGround(cyan);
    end;
end;

procedure processKeyboard(num: integer; var r: byte);
{ up - 72, down - 80, right - 77, left - 75 }
begin
    case num of
        72: r := r + 50;
        80: r := r + 50;
        77: r := r + 1;
        75: r := r - 1;
    end;
    if r > 100 then
        r := r mod 100;
    if r < 0 then
        r := 100 - r;
    if r = 0 then
        r := 100;
end;


procedure inputstr(var str1, str2: mas);
var i: integer;
    character: char;
begin
    cursor := 0;
    i := 0;
    Window(5, 3, 55, 3);
    TextBackGround(cyan);
    repeat
        character := ReadKey;
        if ord(character) = 0 then
            character := Readkey;
        if (character = #72) or (character = #77) or (character = #75) or (character = #80) then
        begin
            processKeyBoard(ord(character), cursor);
            if cursor < 51 then
            begin
                Window(5, 3, 55, 3);
                GOTOXY(cursor, 1);
            end
            else
                if (cursor > 50) and (cursor <= 99) then
                begin
                    Window(5, 8, 55, 8);
                    GOTOXY(cursor mod 50, 1);
                end
                else if cursor = 100 then
                    GOTOXY(50, 1)
        end
        else
            if (character <> #13) and (character <> #27) then
            begin
                processKeyboard(77, cursor);
                if cursor < 51 then
                begin
                    Window(5, 3, 55, 3);
                    TextBackGround(cyan);
                    GOTOXY(cursor, 1);
                    write(character);
                    str1[cursor] := ord(character);
                end
                else
                    if (cursor > 50) and (cursor <= 99) then
                        begin
                            Window(5, 8, 55, 8);
                            TextBackGround(cyan);
                            GOTOXY(cursor mod 50, 1);
                            write(character);
                            str2[cursor mod 50] := ord(character);
                        end
                    else if cursor = 100 then
                    begin
                        GOTOXY(50, 1);
                        write(character);
                        str2[50] := ord(character);
                    end;
            end;
    until 
        (character = #27) or (character = #13);
end;


function getNumber(symbol: char): byte;
begin
    case ord(symbol) of 
        48: getNumber := 0;
        49: getNumber := 1;
        50: getNumber := 2;
        51: getNumber := 3;
        52: getNumber := 4;
        53: getNumber := 5;
        54: getNumber := 6;
        55: getNumber := 7;
        56: getNumber := 8;
        57: getNumber := 9;
    end;
end;


procedure chreg(var r: byte; mode: char);
var a, b, k: byte;
    command, symbol: char;
begin
    case mode of
    'c':
        begin
            Window(9,14,12,14);
            TextBackGround(green);
            TextColor(white);
            k := 0; a := 0;
            Repeat
                symbol := Readkey;
                IF ord(symbol) = 0 then
                    symbol := Readkey
                else
                Begin
                    IF (symbol >= '0') and (symbol <= '9') and (k < 2) then
                    begin
                        clrscr;
                        if k = 0 then
                            write(0, symbol)
                        else
                            write(a, symbol);
                        b := getNumber(symbol);
                        a := a * 10 * k + b; 
                        k := k + 1;
                    end;
                    If ord(symbol) = 8 Then
                    begin
                        If k > 0 Then
                            Begin
                                a := a div 10;
                                clrscr;
                                if k = 2 then
                                    write(a)
                                else
                                    write(0);
                                k := k - 1;
                            End;
                    end;
                End
            Until (ord(symbol) = 13) or (k = 3);
            clrscr;
            if a < 10 then
                write(0, a)
            else
                write(a);
            r := a;
        end;
    's':
        begin
            repeat
                command := ReadKey;    
                processKeyboard(ord(command), r);
                if (r >= 51) and (r <= 99) then
                    esiWindow(r mod 50, False)
                else
                    if r < 51 then
                        esiWindow(r, True)
                    else if r = 100 then
                        esiWindow(50, False);
            until (command = #27) or (command = #13);  
        end;
    'd':
        begin
            repeat
                command := ReadKey;    
                processKeyboard(ord(command), r);
                if (r >= 51) and (r <= 99) then
                    ediWindow(r mod 50, True)
                else
                    if r < 51 then
                        ediWindow(r, False)
                    else if r = 100 then
                        ediWindow(50, True);
            until (command = #27) or (command = #13);  
        end;
    end;
end;

begin
end.