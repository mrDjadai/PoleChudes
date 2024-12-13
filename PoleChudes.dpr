program PoleChudes;
{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils;

const
  baraban: array[1..11] of integer = (100,125,150,175,200,225,250,275,300,0,1);

var
  f: TextFile;
  dict: array[1..40] of ansistring;
  balance: array[1..3] of integer;
  strmyst, strvis, strques: ansistring;
  len, k, i, r, curbar, open, player: integer;
  letter: char;
  already: boolean;



begin
  AssignFile(f, '���� �� txt\questionbase.txt');
  Reset(f);
  i := 1;
  while (not EOF(f)) do begin
    readln(f, dict[i]);
    inc(i);
  end;
  Randomize;
  r := random(20)+1;
  strmyst := dict[r*2-1];
  strques := dict[r*2];
  balance[1] := 0;
  balance[2] := 0;
  balance[3] := 0;



  len := length(strmyst);
  strvis := strmyst;
  for i := 1 to len do
    strvis[i] := '_';
  player := 0;
  writeln(strques);
  writeln(len,' ����');
  writeln;writeln;writeln;
  while (pos('_',strvis)<>0)do begin
    writeln(strvis);
    writeln('������ �������:      1 �����      2 �����      3 �����');
    writeln('               ',balance[1]:11,balance[2]:13,balance[3]:13);
    r := random(11)+1;
    curbar := baraban[r];
    write('��� ',player+1,'-�� ������          �� ��������          ');



    if (curbar>2)then begin
      writeln(curbar);
      write('�����                         ');
      readln(letter);
      if (letter>='�')and(letter<='�') then
        letter := char(ord(letter)-32);
      already := false;
      for i := 1 to len do
        if (copy(strvis,i,1)=letter)then
          already := true;
      if (letter<'�') or (letter>'�') or (already) then begin
        writeln('���� ���� ������������');
        player := (player+1)mod 3;
      end
      else begin
        k := 0;
        for i := 1 to len do
          if (copy(strmyst,i,1)=letter)then begin
            strvis[i] := strmyst[i];
            inc(k);
          end;
        if (k=0)then begin
          writeln('��� ����� �����');
          player := (player+1)mod 3;
        end
        else begin
          writeln('�������� ��� �����');
          inc(balance[player+1],k*curbar);
        end;
      end;
    end;



    if (curbar=0)then begin
      writeln('������� ����');
      player := (player+1)mod 3;
    end;



    if (curbar=1)then begin
      writeln('+');
      write('����� �����              ');
      readln(open);
      if (open<1) or (open>len) or (strvis[open]<>'_')then begin
        writeln('���� ���� ������������');
        player := (player+1)mod 3;
      end
      else begin
        writeln('�������� ��� �����');
        strvis[open] := strmyst[open];
      end;
    end;

    writeln;
    writeln;
    writeln;
  end;



  writeln('������� ',player+1,'-� �����. ������ ������ ',balance[player+1],' �����');
  readln;
  CloseFile(f);
end.
