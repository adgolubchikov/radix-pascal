program countsys;
uses crt;

function intpower(what,exp:integer):longint;
  var i:integer; res:longint;
  begin
  res:=1;
  for i:=1 to exp do
    begin
    res:=res*what;
    end;
  intpower:=res;
  end;

function floor(floatnum:real):longint;
  begin
  floor:=round(floatnum-0.499);
  end;

function removezeros(inp:string):string;
  var i:integer; str:string;
  begin
  str:=inp;
  for i:=1 to length(str) do
    begin
    if (str[1]='0') then delete(str,1,1);
    end;
  removezeros:=str;
  end;

function cleanup(inp:string):string;
  var i:integer; str:string;
  begin
  for i:=length(str) downto 1 do
    begin
    if (str[i]='0') then delete(str,length(str)-1,1);
    end;
  cleanup:=str;
  end;

function tonum(input:char):integer;
  var temp:integer;
  begin
  temp:=0;
    case input of
    '0': temp:=0;
    '1': temp:=1;
    '2': temp:=2;
    '3': temp:=3;
    '4': temp:=4;
    '5': temp:=5;
    '6': temp:=6;
    '7': temp:=7;
    '8': temp:=8;
    '9': temp:=9;
    'a': temp:=10;
    'A': temp:=10;
    'b': temp:=11;
    'B': temp:=11;
    'c': temp:=12;
    'C': temp:=12;
    'd': temp:=13;
    'D': temp:=13;
    'e': temp:=14;
    'E': temp:=14;
    'f': temp:=15;
    'F': temp:=15;
    'g': temp:=16;
    'G': temp:=16;
    'h': temp:=17;
    'H': temp:=17;
    'i': temp:=18;
    'I': temp:=18;
    'j': temp:=19;
    'J': temp:=19;
    'k': temp:=20;
    'K': temp:=20;
    'l': temp:=21;
    'L': temp:=21;
    'm': temp:=22;
    'M': temp:=22;
    'n': temp:=23;
    'N': temp:=23;
    'o': temp:=24;
    'O': temp:=24;
    'p': temp:=25;
    'P': temp:=25;
    'q': temp:=26;
    'Q': temp:=26;
    'r': temp:=27;
    'R': temp:=27;
    's': temp:=28;
    'S': temp:=28;
    't': temp:=29;
    'T': temp:=29;
    'u': temp:=30;
    'U': temp:=30;
    'v': temp:=31;
    'V': temp:=31;
    'w': temp:=32;
    'W': temp:=32;
    'x': temp:=33;
    'X': temp:=33;
    'y': temp:=34;
    'Y': temp:=34;
    'z': temp:=35;
    'Z': temp:=35;
    end;
  tonum:=temp;
  end;

function tosym(input:integer):char;
  var temp:char;
  begin
  temp:='0';
    case input of
    0: temp:='0';
    1: temp:='1';
    2: temp:='2';
    3: temp:='3';
    4: temp:='4';
    5: temp:='5';
    6: temp:='6';
    7: temp:='7';
    8: temp:='8';
    9: temp:='9';
    10: temp:='A';
    11: temp:='B';
    12: temp:='C';
    13: temp:='D';
    14: temp:='E';
    15: temp:='F';
    16: temp:='G';
    17: temp:='H';
    18: temp:='I';
    19: temp:='J';
    20: temp:='K';
    21: temp:='L';
    22: temp:='M';
    23: temp:='N';
    24: temp:='O';
    25: temp:='P';
    26: temp:='Q';
    27: temp:='R';
    28: temp:='S';
    29: temp:='T';
    30: temp:='U';
    31: temp:='V';
    32: temp:='W';
    33: temp:='X';
    34: temp:='Y';
    35: temp:='Z';
    end;
  tosym:=temp;
  end;

function to10(num:string;from:integer):longint;
  var str:string; res:longint; i:integer;
  begin
  str:=num;
  res:=0;
  for i:=length(str) downto 1 do
    begin
    res:=res+tonum(str[i])*intpower(from,length(str)-i);
    end;
  to10:=res;
  end;

function from10(num:longint;tobase:integer):string;
  var res:string; i:integer; inp:longint;
  begin
  res:='000000000000000';
  inp:=num;
  for i:=15 downto 1 do
    begin
    res[i]:=tosym(inp mod tobase);
    inp:=inp div tobase;
    end;
  res:=removezeros(res);
  from10:=res;
  end;

function base_convert(num:string;from:integer;tobase:integer):string;
  var decimal:longint; res,inp:string;
  begin
  inp:=num;
  decimal:=to10(inp,from);
  res:=from10(decimal,tobase);
  base_convert:=res;
  end;

function base_convert_float(num:string;from:integer;tobase:integer):string;
  var intpart,floatpart,res:string;
      dotpos,i,floatpartlength:integer;
      decimal:real;
      a1:array[1..10] of string;
  label finish;
  begin
  res:=num;
  dotpos:=pos('.',res);
  if dotpos=0 then
    begin
    res:=base_convert(num,from,tobase);
    goto finish;
    end;
  intpart:=res;
  delete(intpart,dotpos,length(res)-dotpos+1);

  floatpart:=res;
  delete(floatpart,1,dotpos);

  floatpartlength:=length(floatpart);

  res:='';

  for i:=1 to length(floatpart) do
    begin
    a1[i]:=floatpart[i];
    end;

  decimal:=0;

  for i:=1 to length(floatpart) do
    begin
    decimal:=decimal+to10(a1[i],from)*(1/intpower(from,i));
    end;
  floatpart:='';
  for i:=1 to 8 do
    begin
    floatpart:=concat(floatpart,from10(floor(10*decimal),tobase));
    decimal:=decimal*10;
    decimal:=decimal-floor(decimal);
    end;
  intpart:=base_convert(intpart,from,tobase);
  res:=concat(concat(intpart,'.'),floatpart);
  {res:=cleanup(res);}
  finish:
  base_convert_float:=res;
  end;


{-----------------------------------------------------------------------}
{program::main}
var inp:string;
    frombase:integer;
    tobase:integer;
    key: char;
label fromlabel, tolabel,fromerror,toerror,start,main;
begin
clrscr;
writeln('Number Systems');
goto main;
start:
clrscr;
main:
write('Enter number: ');
readln(inp);
goto fromlabel;

fromerror: writeln('Error source base: it should be integer from 2 to 36.');
fromlabel: write('Enter source base: ');
readln(frombase);
if ((frombase<2) or (frombase>36)) then goto fromerror;

goto tolabel;

toerror: writeln('Error result base: it should be integer from 2 to 36.');
tolabel: write('Enter result base: ');
readln(tobase);
if ((tobase<2) or (tobase>36)) then goto toerror;

writeln('----------------------');
writeln(inp,'[',frombase,'] = ',base_convert_float(inp,frombase,tobase),'[',tobase,']');
writeln('----------------------');
writeln('Press any key to calculate one more, Esc to exit');
key:=readkey;
if (key <> #27) then goto start;

end.
