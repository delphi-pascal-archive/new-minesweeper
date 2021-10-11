 unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Menus, ExtCtrls, ImgList;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    Panel1: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    ImageList1: TImageList;
    Timer1: TTimer;
    N3: TMenuItem;
    N4: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    SpeedButton1: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
    procedure Knopka(Sender: TObject);
  public
    { Public declarations }
    razmer //сколько клеток в доске
    ,kwidth //размер клетки
    ,bomb   //кол-во бомб всего
    ,fb     //остаток флагов
    ,bx,by  //коор взорваной бомбы
    :integer;
    mass,nass,flag:array [1..200,1..200] of integer;
  end;

var
  Form1: TForm1;

implementation

uses Unit2, Unit3;

{$R *.dfm}

procedure TForm1.Knopka(Sender: TObject);
var kborder:integer;
    i,j,kleft,ktop:integer;
begin
  Label1.Caption:=IntToStr(fb);
  kborder:=trunc(kwidth/10);
  image1.Canvas.Font.Style:=[fsBold];
  image1.Canvas.Font.Size:=trunc(kwidth/2.5);
  for i:=1 to razmer do
  begin
    for j:=1 to razmer do
    begin
      kleft:=(i-1)*kWidth;
      ktop:=(j-1)*kwidth;
      if nass[i][j]=0 then
      begin
        //рисуем не нажатую кнопку
        image1.Canvas.Brush.Color:=clWhite;
        image1.Canvas.Pen.Color:=clBlack;
        image1.Canvas.Rectangle(kleft,ktop,kleft+kwidth,ktop+kwidth);
        image1.Canvas.Brush.Color:=clGray;
        image1.Canvas.Pen.Color:=clGray;
        image1.Canvas.Rectangle(kleft+kborder,ktop+kborder,kleft+kwidth,ktop+kwidth);
        image1.Canvas.Brush.Color:=clBtnFace;
        image1.Canvas.Rectangle(kleft+kborder,ktop+kborder,kleft+kwidth-kborder,ktop+kwidth-kborder);
        image1.Canvas.Font.Color:=clGray;
        //рисуем флаг
        if flag[i][j]=1 then ImageList1.Draw(image1.Canvas, kleft+kborder,ktop+kborder, 0);
        {//блок для отладки
        if mass[i][j]=9 then
        begin
          image1.Canvas.Brush.Color:=clBlack;
          image1.Canvas.Ellipse(kleft+kborder,ktop+kborder,kleft+kwidth-kborder,ktop+kwidth-kborder)
        end;
        if mass[i][j]=0 then image1.Canvas.Font.Color:=clBtnFace;
        if mass[i][j]=1 then image1.Canvas.Font.Color:=clBlue;
        if mass[i][j]=2 then image1.Canvas.Font.Color:=clGreen;
        if mass[i][j]=3 then image1.Canvas.Font.Color:=clRed;
        if mass[i][j]=4 then image1.Canvas.Font.Color:=clNavy;
        if mass[i][j]=5 then image1.Canvas.Font.Color:=clMaroon;
        if mass[i][j]=6 then image1.Canvas.Font.Color:=clOlive;
        if mass[i][j]=7 then image1.Canvas.Font.Color:=clTeal;
        if mass[i][j]=8 then image1.Canvas.Font.Color:=clPurple;
        image1.Canvas.TextOut(kleft+trunc(kwidth/3),ktop+trunc(kwidth/5),IntToStr(mass[i][j]));
         }
      end else begin
        image1.Canvas.Brush.Color:=clBtnFace;
        image1.Canvas.Pen.Color:=clBtnFace;
        image1.Canvas.Rectangle(kleft+1,ktop+1,kleft+kwidth,ktop+kwidth);
        if mass[i][j]=0 then image1.Canvas.Font.Color:=clBtnFace;
        if mass[i][j]=1 then image1.Canvas.Font.Color:=clBlue;
        if mass[i][j]=2 then image1.Canvas.Font.Color:=clGreen;
        if mass[i][j]=3 then image1.Canvas.Font.Color:=clRed;
        if mass[i][j]=4 then image1.Canvas.Font.Color:=clNavy;
        if mass[i][j]=5 then image1.Canvas.Font.Color:=clMaroon;
        if mass[i][j]=6 then image1.Canvas.Font.Color:=clOlive;
        if mass[i][j]=7 then image1.Canvas.Font.Color:=clTeal;
        if mass[i][j]=8 then image1.Canvas.Font.Color:=clPurple;
        image1.Canvas.TextOut(kleft+trunc(kwidth/3),ktop+trunc(kwidth/5),IntToStr(mass[i][j]));
        if mass[i][j]=9 then
        begin
          image1.Canvas.Brush.Color:=clRed;
          if bx=i then if by=j then image1.Canvas.Rectangle(kleft,ktop,kleft+kwidth,ktop+kwidth);
          image1.Canvas.Brush.Color:=clBlack;
          image1.Canvas.Ellipse(kleft+kborder,ktop+kborder,kleft+kwidth-kborder,ktop+kwidth-kborder);
          image1.Canvas.Pixels[kleft+kborder+trunc(kwidth/4),ktop+kborder+trunc(kwidth/4)]:=clwhite;
        end;
      end;
    end;
  end;
  form1.Canvas.Draw(0,form1.Panel1.Height,image1.Picture.Graphic);
end;


procedure TForm1.SpeedButton1Click(Sender: TObject);
var i,j,xb,yb,summ:integer;
    za:boolean;
begin
  if bomb>razmer*razmer-10 then bomb:=razmer*razmer-10 ;
  if razmer*kwidth>800 then razmer:=trunc(800/kwidth);
  if kwidth>100 then kwidth:=100;
  timer1.Enabled:=true;
  Timer1.Tag:=0;
  label2.Caption:=IntToStr(timer1.Tag);
  bx:=0;
  by:=0;


  //подбор размеров формы
  fb:=bomb;
  form1.ClientWidth:=kwidth*razmer;
  form1.ClientHeight:=form1.ClientWidth+form1.Panel1.Height;
  form1.Position:=poScreenCenter;

  label2.Left:=form1.ClientWidth-label2.Width*4;
  speedbutton1.Left:=trunc(form1.ClientWidth/2-speedbutton1.Width/2);
  randomize;

  //обнуление массива
  for i:=1 to razmer+10 do
  begin
    for j:=1 to razmer+10 do
    begin
      nass[i][j]:=0;
      mass[i][j]:=0;
      flag[i][j]:=0;
    end;
  end;

  //расстановка мин в массиве
  for i:=1 to bomb do
  begin
    za:=true;
    while za do
    begin
      xb:=trunc(random*(razmer)+1);
      yb:=trunc(random*(razmer)+1);
      if mass[xb][yb]=0 then
      begin
        za:=false;
        mass[xb][yb]:=9;
      end;
    end;
  end;

  //расстановка цифр
  for i:=1 to razmer do
  begin
    for j:=1 to razmer do
    begin
      if mass[i][j]<9 then
      begin
        summ:=0;
        if mass[i-1][j-1]=9 then summ:=summ+1;
        if mass[i][j-1]=9 then summ:=summ+1;
        if mass[i+1][j-1]=9 then summ:=summ+1;
        if mass[i-1][j]=9 then summ:=summ+1;
        if mass[i+1][j]=9 then summ:=summ+1;
        if mass[i-1][j+1]=9 then summ:=summ+1;
        if mass[i][j+1]=9 then summ:=summ+1;
        if mass[i+1][j+1]=9 then summ:=summ+1;
        mass[i][j]:=summ;
      end;
    end;
  end;
  Knopka(Sender);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Timer1.Tag:=Timer1.Tag+1;
  label2.Caption:=IntToStr(timer1.Tag);
end;

procedure TForm1.N3Click(Sender: TObject);
begin
  OKRightDlg.Edit1.Text:=IntToStr(razmer);
  OKRightDlg.Edit2.Text:=IntToStr(kwidth);
  OKRightDlg.Edit3.Text:=IntToStr(bomb);
  if OKRightDlg.ShowModal=1 then
  begin
    razmer:=StrToInt(OKRightDlg.Edit1.Text);
    kwidth:=StrToInt(OKRightDlg.Edit2.Text);
    bomb:=StrToInt(OKRightDlg.Edit3.Text);
    SpeedButton1Click(Sender);
  end;
end;

procedure TForm1.N6Click(Sender: TObject);
begin
  razmer:=9;
  SpeedButton1Click(Sender);
end;

procedure TForm1.N8Click(Sender: TObject);
begin
    razmer:=20;
    SpeedButton1Click(Sender);
end;

procedure TForm1.N7Click(Sender: TObject);
begin
    razmer:=40;
    SpeedButton1Click(Sender);
end;

procedure TForm1.N9Click(Sender: TObject);
begin
    bomb:=trunc(razmer*razmer/10);
    SpeedButton1Click(Sender);
end;

procedure TForm1.N10Click(Sender: TObject);
begin
    bomb:=trunc(razmer*razmer/5);
    SpeedButton1Click(Sender);
end;

procedure TForm1.N11Click(Sender: TObject);
begin
    bomb:=trunc(razmer*razmer/2.5);
    SpeedButton1Click(Sender);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  razmer:=9;
  kwidth:=20;
  bomb:=trunc(razmer*1.5);
  Image1.Align:=alClient;
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i,j,k,l:integer;

 //рекурсия для открывания пустышек
 procedure pust(Xa,Ya:Integer);
 begin
  //если не нажата кнопка
  if nass[xa][ya]=0 then
  begin
    nass[xa][ya]:=1;
    //если пусто
    if mass[xa][ya]=0 then
    begin
      //кнопки по кресту
      if xa>1 then if mass[xa-1][ya]<9 then pust(xa-1,ya);
      if ya>1 then if mass[xa][ya-1]<9 then pust(xa,ya-1);
      if xa<razmer then if mass[xa+1][ya]<9 then pust(xa+1,ya);
      if ya<razmer then if mass[xa][ya+1]<9 then pust(xa,ya+1);
      //кнопки по диагонали
      if mass[xa+1][ya+1]>0 then if mass[xa+1][ya+1]<9 then nass[xa+1][ya+1]:=1;
      if mass[xa-1][ya+1]>0 then if mass[xa-1][ya+1]<9 then nass[xa-1][ya+1]:=1;
      if mass[xa+1][ya-1]>0 then if mass[xa+1][ya-1]<9 then nass[xa+1][ya-1]:=1;
      if mass[xa-1][ya-1]>0 then if mass[xa-1][ya-1]<9 then nass[xa-1][ya-1]:=1;
    end;
  end;
 end;

begin
if bx=0 then
begin
 y:=y-panel1.Height;
 //номер нажатой кнопки
 i:=trunc(x/kwidth)+1;
 j:=trunc(y/kwidth)+1;
 if Button=mbLeft then
 begin
  //обработка нажатия
  if mass[i][j]=9 then
  begin
    bx:=i;
    by:=j;
    //бомба
    for k:=1 to razmer do
    begin
      for l:=1 to razmer do
      begin
        if mass[k][l]=9 then
        begin
          nass[k][l]:=1;
        end;
      end;
    end;

  end else begin
    pust(i,j);    //пусто
  end;
 end else begin
   if nass[i][j]=0 then
   begin
     if flag[i][j]=0 then
     begin
       if fb>0 then
       begin
         flag[i][j]:=1;
         fb:=fb-1;
       end;
     end else begin
       flag[i][j]:=0;
       fb:=fb+1;
     end;
   end;
 end;
 //рисуем доску
 Knopka(Sender);

end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Image1.Width:=2000;
  Image1.Height:=2000;
  Label2.Left:=-1000;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
  AboutBox.ShowModal;
end;

end.
