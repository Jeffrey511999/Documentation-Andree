unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ExtCtrls, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    BtnTranslasi: TButton;
    BtnScalling: TButton;
    BtnRotasi: TButton;
    BtnHapus: TButton;
    BtnGambar: TButton;
    BtnKomposit: TButton;
    TFormTX: TEdit;
    TFormSX: TEdit;
    TFormTY: TEdit;
    TFormSY: TEdit;
    TFormRotasi: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure BtnGambarClick(Sender: TObject);
    procedure BtnHapusClick(Sender: TObject);
    procedure BtnRotasiClick(Sender: TObject);
    procedure BtnScallingClick(Sender: TObject);
    procedure BtnTranslasiClick(Sender: TObject);
    procedure BtnKompositClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SetVar;
    procedure cleanScreen;

  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}
{ TForm1 }

Uses Math;

type
  limas = Record
    x: integer;
    y: integer;
end;

var
  x1 : integer;
  y1 : integer;
  x2 : integer;
  y2 : integer;
  lebar : integer;
  tinggi : integer;
  kolomP : integer;
  barisP : integer;
  tx,ty,sx,sy : Double;
  rotasi : Integer;
  bangun : Array[1..5] of limas;

procedure TForm1.FormShow(Sender: TObject);
begin
  lebar := Image1.Width;
  tinggi := Image1.Height;
  kolomP := lebar div 2;
  barisP := tinggi div 2;
  BtnHapusClick(NIL);
  SetVar();
end;


procedure TForm1.BtnHapusClick(Sender: TObject);
begin
  image1.Canvas.Pen.Color:=clWhite;
  image1.Canvas.Pen.Style:=psSolid;
  image1.Canvas.Brush.Color:=clWhite;
  image1.Canvas.Brush.Style:=bsSolid;
  image1.Canvas.Rectangle(0,0,lebar,tinggi);

  image1.Canvas.Pen.Color:=clRed;
  image1.Canvas.Pen.Style:=psDot;
  image1.Canvas.MoveTo(kolomP, 0);
  image1.Canvas.LineTo(kolomP, tinggi);
  image1.Canvas.MoveTo(0, barisP);
  image1.Canvas.LineTo(lebar, barisP);
  SetVar();
end;

procedure TForm1.BtnRotasiClick(Sender: TObject);
var 
  // Indentified Var here
  i : integer;
  temp : Array[1..5] of limas;
begin
  rotasi := Round(StrToFloat(TFormRotasi.Text));
  for i:= 1 To 5 do 
  begin 
    temp[i].x := bangun[i].x;
    bangun[i].x := Round((bangun[i].x * Cos(rotasi*pi/180)) - (bangun[i].y*sin(rotasi*pi/180)));
    bangun[i].y := Round((temp[i].x * Sin(rotasi*pi/180)) + (bangun[i].y*Cos(rotasi*pi/180)));
  end;
  cleanScreen();
  BtnGambarClick(NIL);
end;

procedure TForm1.BtnScallingClick(Sender: TObject); //Need to be check (Public var bangun)
var
  i : integer;
begin
  sx := Round(StrToFloat(TFormSX.Text));
  sy := Round(StrToFloat(TFormSY.Text));
    for i:= 1 to 5 do
    begin
      bangun[i].x := Round(bangun[i].x * sx);
      bangun[i].y := Round(bangun[i].y * sy);
    end;
    cleanScreen();
    BtnGambarClick(NIL);
end;

procedure TForm1.BtnTranslasiClick(Sender: TObject); //Need Recheck (Public var bangun)
var
  i : integer;
begin
  tx := Round(StrToFloat(TFormTX.Text));
  ty := Round(StrToFloat(TFormTY.Text));
    for i:= 1 to 5 do
    begin
      bangun[i].x := Round(bangun[i].x + tx);
      bangun[i].y := Round(bangun[i].y + ty);
    end;
    cleanScreen();
    BtnGambarClick(NIL);
end;

procedure TForm1.BtnKompositClick(Sender : TObject); // Komposit Rotasi dengan Scalling
var
  // Initialize var here
  i : integer;
  tempkomposit : Array[1..5] of limas;
begin
  // Code Here
  sx := Round(StrToFloat(TFormSX.Text));
  sy := Round(StrToFloat(TFormSY.Text));
  rotasi := Round(StrToFloat(TFormRotasi.Text));
  
    for i:= 1 To 5 do 
    begin
      tempkomposit[i].x := bangun[i].x;
      bangun[i].x := Round((bangun[i].x * Cos(rotasi*pi/180)) - (bangun[i].y*sin(rotasi*pi/180)));
      bangun[i].y := Round((tempkomposit[i].x * Sin(rotasi*pi/180)) + (bangun[i].y*Cos(rotasi*pi/180)));
      bangun[i].x := Round(bangun[i].x * sx);
      bangun[i].y := Round(bangun[i].y * sy);
    end;
  cleanScreen();
  BtnGambarClick(NIL);
end;

procedure TForm1.BtnGambarClick(Sender: TObject);
var
  i : integer;
begin
  image1.Canvas.Pen.Color:= clBlack;
  image1.Canvas.Pen.Style:= psSolid;

  image1.Canvas.MoveTo(kolomP + bangun[5].x, barisP - bangun[5].y);
  for i:=2 to 5 do
    begin
    image1.Canvas.LineTo(kolomP + bangun[i].x, barisP - bangun[i].y);
    image1.Canvas.MoveTo(kolomP + bangun[1].x, barisP - bangun[1].y);
    image1.Canvas.LineTo(kolomP + bangun[i].x, barisP - bangun[i].y);
    end;
end;

procedure TForm1.cleanScreen;
begin
  image1.Canvas.Pen.Color:=clWhite;
  image1.Canvas.Pen.Style:=psSolid;
  image1.Canvas.Brush.Color:=clWhite;
  image1.Canvas.Brush.Style:=bsSolid;
  image1.Canvas.Rectangle(0,0,lebar,tinggi);

  image1.Canvas.Pen.Color:=clRed;
  image1.Canvas.Pen.Style:=psDot;
  image1.Canvas.MoveTo(kolomP, 0);
  image1.Canvas.LineTo(kolomP, tinggi);
  image1.Canvas.MoveTo(0, barisP);
  image1.Canvas.LineTo(lebar, barisP);
end;

Procedure TForm1.SetVar;
begin
   tx := 0;
   ty := 0;
   sx := 0;
   sy := 0;
   rotasi := 0;

   bangun[1].x := 0;
   bangun[1].y := 50;
   bangun[2].x := -25;
   bangun[2].y := -50;
   bangun[3].x := 25;
   bangun[3].y := -50;
   bangun[4].x := 0;
   bangun[4].y := 0;
   bangun[5].x := -50;
   bangun[5].y := 0;
end;



end.
