unit commands;

interface
uses crt,preparation;
var ZF: boolean;
    firstaction: boolean;

procedure newcom(var com: command);

procedure run(a: integer; var str1,str2: mas; var esi,edi: byte; var al: char; var ecx: byte; df: boolean; com: command);

implementation
procedure q(x1,y1,x2,y2,n: integer);
  begin
      window(x1,y1,x2,y2);
      Textbackground(n);
      Clrscr;
  end;

procedure newcom(var com: command);
var fstr: string;
    r: integer;
    i: integer;
    a: char;
    f,g: text;

  procedure sets(p,a,b: integer; l,r: char);
    begin
      window(a,p,a,p);
      write(l);
      window(b,p,b,p);
      write(r);
      window(a+1,p,b-1,p);
    end;

  procedure chose(var r: integer; d1,d2: integer; h1,h2: integer);
  var a: char;
   begin
    repeat
      sets(r,d1,d2,'>','<');
      a:=readkey;
      if ord(a)=0 then
        begin
          a:=readkey;
          if (ord(a)=72) and (r>h1) then {��५�� �����}
            begin
              sets(r,d1,d2,' ',' ');
              r:=r-1
            end
          else
          if (ord(a)=80) and (r<h2) then {��५�� ����}
            begin
              sets(r,d1,d2,' ',' ');
              r:=r+1
            end
        end
    until ord(a)=13;
   end;
begin
  q(46,13,60,13,0);
  assign(f,'/Users/timmy/Desktop/Pas/Prak2Sem/prak_pas_final/commands.txt');
  reset(f);
  q(15,13,19,17,3);
  readln(f,fstr);
  write(fstr);
  q(15,17,19,17,0);
  r:=13;
  chose(r,14,20,13,16);
  com.povt:=pref(r-13);
  q(14,13,20,17,0);
  q(15,12,19,12,1);
  write(com.povt);

  q(21,13,25,18,3);
  readln(f,fstr);
  write(fstr);
  q(21,18,25,18,0);
  r:=13;
  chose(r,20,26,13,17);
  com.strcom:=coms(r-13);
  q(20,13,26,18,0);
  q(21,12,25,12,1);
  write(com.strcom);
  assign(g,'/Users/timmy/Desktop/Pas/Prak2Sem/prak_pas_final/explain.txt');
  reset(g);

  i:=r-13;
  while i<>0 do
    begin
      i:=i-1;
      readln(g)
    end;
  readln(g,fstr);
  q(27,12,44,12,1);
  write(fstr);
  close(f);
  close(g)
end;

{����� �������}
procedure run(a: integer; var str1,str2: mas; var esi,edi: byte; var al: char; var ecx: byte; df: boolean; com: command);
var i: integer;
   m1,m2: integer;
   s1,s2: integer;
   err1,err2: boolean;

  procedure shift(df: boolean; var reg: byte; c: char; var err: boolean);
  var p,k: byte;
  begin
   err:=df and (reg mod 50 = 1) or (not df) and (reg mod 50 = 0);
   if df then
     p:=-1
   else
     p:=1;
   k:=reg mod 50;
   if not err then
    begin
     if (c='d') and (reg<=50) then  {edi �� 1 ��ப�}
       begin
         q(3+k,4,5+k,5,0);
         window(3+k+p,4,5+k+p+1,5);
         write(' |  edi');
         edi:=edi+p
       end
     else
     if (c='d') and (reg>50) then   {edi �� 2 ��ப�}
       begin
         q(3+k,9,5+k,10,0);
         window(3+k+p,9,5+k+p+1,10);
         write(' |  edi');
         edi:=edi+p
       end
     else
     if (c='s') and (reg<=50) then   {esi �� 1 ��ப�}
       begin
         q(3+k,1,5+k,2,0);
         window(3+k+p,1,5+k+p,2);
         write('esi |');
         esi:=esi+p
       end
     else
     if (c='s') and (reg>50) then    {esi �� 2 ��ப�}
       begin
         q(3+k,6,5+k,7,0);
         window(3+k+p,6,5+k+p,7);
         write('esi |');
         esi:=esi+p
       end
    end
  end;

  procedure error(err: boolean);
   begin
    if err then
      begin
        q(46,13,60,13,0);
        Textcolor(lightred);
        Textbackground(black);
        write('RANGE CHECK ERR');
        Textcolor(white)
      end
   end;

   procedure complete(firstaction: boolean);
   begin
     q(46,13,60,13,0);
     if firstaction then
       begin
         Textcolor(lightgreen);
         Textbackground(black);
         write('COM COMPLETED');
         Textcolor(white)
       end
   end;

   procedure pre(var m1,m2,s1,s2: integer);
   begin
     m1:=(esi-1) div 50;
     m2:=(edi-1) div 50;
     if m1=0 then
       s1:=str1[esi]
     else
       s1:=str2[esi-50];
     if m2=0 then
       s2:=str1[edi]
    else
       s2:=str2[edi-50];
    window(46,12,60,12);
    Textbackground(yellow);
    Clrscr;
   end;

   procedure cmp(var esi,edi: byte; df: boolean; var ZF: boolean);
   var m1,m2,s1,s2: integer;
   begin
     pre(m1,m2,s1,s2);
     ZF:=s1=s2;
     write('"',chr(s1),'"');
     if s1>s2 then
         write('>')
     else
     if s1<s2 then
       write('<')
     else
       write('=');
     write('"',chr(s2),'"');
     shift(df,esi,'s',err1);
     shift(df,edi,'d',err2);
   end;

   procedure mov(var esi,edi: byte; df: boolean);
   var m1,m2,s1,s2: integer;
     begin
       pre(m1,m2,s1,s2);
       write('[edi]:=','"',chr(s2),'"');
       if m2=0 then
         begin
           if m1=0 then
             str1[edi]:=str1[esi]
           else
             str1[edi]:=str2[esi-50];
           window(5,3,55,3);
           gotoxy((edi-1) mod 50+1,1);
           Textbackground(cyan);
           write(chr(str1[edi]))
         end
       else
         begin
           if m1=0 then
             str2[edi-50]:=str1[esi]
           else
             str2[edi-50]:=str2[esi-50];
           window(5,8,55,8);
           gotoxy((edi-1) mod 50+1,1);
           Textbackground(cyan);
           write(chr(str2[edi-50]))
         end;

       shift(df,esi,'s',err1);
       shift(df,edi,'d',err2)
     end;

     procedure sca(var edi: byte; al: char; df: boolean; var ZF: boolean);
     var s2: integer;
       begin
         window(46,12,60,12);
         Textbackground(yellow);
         Clrscr;
         if edi<=50 then
           s2:=str1[edi]
         else
           s2:=str2[edi-50];

         write('al');
         if ord(al)>s2 then
           write('>')
         else
         if ord(al)<s2 then
           write('<')
         else
           write('=');
         ZF:=ord(al)=s2;
         write('"',chr(s2),'"');
         shift(df,edi,'d',err2)
       end;

     procedure lod(var esi: byte; var al: char; df: boolean);
     var s1: integer;
       begin
         window(46,12,60,12);
         Textbackground(yellow);
         Clrscr;
         if esi<=50 then
           s1:=str1[esi]
         else
           s1:=str2[esi-50];
         write('al:=','"',chr(s1),'"');
         al:=chr(s1);
         q(8,13,12,13,2);
         write('"',al,'"');
         shift(df,esi,'s',err1)
       end;

     procedure sto(var edi: byte; al: char; df: boolean);
     var s2: integer;
       begin
         window(46,12,60,12);
         Textbackground(yellow);
         Clrscr;
         write('[edi]:=','"',al,'"');
         if edi<=50 then
           begin
             str1[edi]:=ord(al);
             window(5,3,55,3);
             gotoxy(edi,1)
           end
         else
           begin
             str2[edi-50]:=ord(al);
             window(5,8,55,8);
             gotoxy(edi-50,1)
           end;
         Textbackground(cyan);
         write(al);
         shift(df,edi,'d',err2);
       end;

     procedure decECX(var ecx: byte);
     begin
       ecx:=ecx-1;
       q(9,14,12,14,2);
       write(ecx)
     end;

     procedure execute(k: coms);
     begin
       case k of
         cmpsb: cmp(esi,edi,df,ZF);
         movsb: mov(esi,edi,df);
         scasb: sca(edi,al,df,ZF);
         lodsb: lod(esi,al,df);
         stosb: sto(edi,al,df);
       end
     end;
begin
 err1:=false;
 err2:=false;
 if a=0 then
   begin
    case com.povt of
     none: execute(com.strcom);
     rep:  while not (err1 or err2) and (ecx>0) do
             begin
               execute(com.strcom);;
               decECX(ecx)
             end;
     repe: begin
             ZF:=True;
             while not (err1 or err2) and (ecx>0) and ZF do
               begin
                 execute(com.strcom);
                 decECX(ecx)
               end
           end;
     repne: begin
              ZF:=false;
              while not (err1 or err2) and (ecx>0) and not ZF do
                begin
                  execute(com.strcom);
                  decECX(ecx)
                end;
            end
    end;
   firstaction:=True
   end
 else
   case com.povt of
     none: begin
             execute(com.strcom);
             firstaction:=true
           end;
     rep: begin
            if ecx>0 then
              begin
                execute(com.strcom);
                decECX(ecx);
                firstaction:=false
              end
            else
              firstaction:=true
          end;
     repe: begin
             if (ecx>0) and (ZF or firstaction) then
               begin
                 execute(com.strcom);
                 decECX(ecx);
                 firstaction:=false
               end
             else
               firstaction:=true
           end;
     repne: begin
              if (ecx>0) and (not ZF or firstaction) then
                begin
                  execute(com.strcom);
                  decECX(ecx);
                  firstaction:=false
                end
              else
                firstaction:=true
            end;
   end;
 complete(firstaction);
 error(err1 or err2)
end;

begin
 ZF:=False;
 firstaction:=True
end.
