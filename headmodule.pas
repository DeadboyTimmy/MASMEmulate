program headmodule;
{�������� �����}
uses crt, preparation,commands,datawork;    {����� �����⮢�� � ࠡ��}        {����� ����ன�� ��ࠬ��஢}

var i: integer;
    a: char;
begin
 intro;
 start(str1,str2,esi,edi,al,ecx,df,com);
 hint('0');
 repeat
   a:=readkey;
   hint(a);
   case a of
     {ࠡ�� � ��ப���}
     'v': inputstr(str1,str2); {��筮� ���� ��ப}
     '1': randstr(str1,1);       {���������� ��砩�묨 ᨬ������ 1 ��ப�}
     '2': randstr(str2,2) ;      {���������� ��砩�묨 ᨬ������ 2 ��ப�}
     {ࠡ�� � ॣ���ࠬ�}
     's': chreg(esi,a)  ;     {��������� esi}
     'd': chreg(edi,a) ;      {��������� edi}
     'a': chal(al) ;        {��������� al}
     'c': chreg(ecx,a) ;      {��������� ecx}
     'f': chDF(df)      ;   {��������� 䫠�� DF}
     {ࠡ�� � ���������}
     'k': newcom(com);   {�롮� ����� �������}
     'r': run(0,str1,str2,esi,edi,al,ecx,df,com);        {�믮������ �������}
     ' ': run(1,str1,str2,esi,edi,al,ecx,df,com);        {�믮������ 1 蠣� �������}

   end;
   hint('0')
 until ord(a)=27
end.
