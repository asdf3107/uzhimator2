unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.FileCtrl, Vcl.Menus,
  Vcl.ComCtrls, IOUtils, Vcl.ExtCtrls, jpeg, PNGImage;

type
  TForm2 = class(TForm)
    Button1: TButton;
    FileOpenDialog1: TFileOpenDialog;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Open1: TMenuItem;
    Exit1: TMenuItem;
    About1: TMenuItem;
    About2: TMenuItem;
    ListBox1: TListBox;
    Button2: TButton;
    Image1: TImage;
    Edit1: TEdit;
    Edit2: TEdit;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Label1: TLabel;
    TrackBar1: TTrackBar;
    Label3: TLabel;
    ProgressBar1: TProgressBar;
    Button3: TButton;
    Button4: TButton;
    RadioGroup1: TRadioGroup;
    Button5: TButton;
    Label2: TLabel;
    Label4: TLabel;
    Memo1: TMemo;
    procedure About2Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
  private
    procedure BuildTree (path:string);
    procedure resizejpeg(fname: string; sc: integer);
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  gPath : string;
implementation

{$R *.dfm}

function FileSize(const aFilename: String): Int64;
  var
    info: TWin32FileAttributeData;
  begin
    result := -1;

    if NOT GetFileAttributesEx(PWideChar(aFileName), GetFileExInfoStandard, @info) then
      EXIT;

    result := Int64(info.nFileSizeLow) or Int64(info.nFileSizeHigh shl 32);
  end;

procedure TForm2.resizejpeg (fname: string; sc : integer);
var
  jpg: TJPEGImage;
  bmp, tmp: TBitmap;
  png : TPNGImage;
  nw, nh : integer;
  qf : extended;
  ftype : string;
begin
  ftype := copy (ansilowercase(fname), length (fname)-3, 99);
//  showmessage (ftype);  exit();

  if (ftype <> '.jpg') and (ftype <> 'jpeg') and
  (ftype <> '.bmp') and (ftype <> '.png') then exit;

  progressbar1.Position := 0;
  application.ProcessMessages;

  bmp:=TBitmap.Create;
  tmp:=TBitmap.Create;

            // load to tmp
  if (ftype = '.jpg') or (ftype = 'jpeg') then
   begin
    try
      jpg:=TJPEGImage.Create;
      jpg.LoadFromFile(fname);
      jpg.Scale:=jsFullSize;
      jpg.DIBNeeded;
      jpg.CompressionQuality := TrackBar1.Position;
      tmp.Assign(jpg);
    except
      beep;
      memo1.Lines.Add(datetimetostr (now) + ' Не удалось обработать файл ' + edit1.Text + listbox1.Items [listbox1.ItemIndex]);
      exit;
    end;
   end;

  if ftype = '.png' then
   begin
    try
      png:=TPNGImage.Create;
      png.LoadFromFile(fname);
      tmp.assign(png);
    except
      beep;
      memo1.Lines.Add(datetimetostr (now) + ' Не удалось обработать файл ' + edit1.Text + listbox1.Items [listbox1.ItemIndex]);
      exit;
    end;
   end;

  if ftype = '.bmp' then
   begin
    try
     tmp.LoadFromFile(fname);
    except
      beep;
      memo1.Lines.Add(datetimetostr (now) + ' Не удалось обработать файл ' + edit1.Text + listbox1.Items [listbox1.ItemIndex]);
      exit;
    end;
   end;

           // tmp loaded - resizing
  progressbar1.Position := 20;
  application.ProcessMessages;

  if radiobutton2.Checked then    // percents
   begin
    nw := round (tmp.width / 100 * sc);
    nh := round (tmp.height / 100 * sc);
    bmp.Width:=nw;
    bmp.Height:=nh;
   end;

  if radiobutton1.Checked then   // pixels
   begin
    if radiogroup1.ItemIndex = 0 then qf := sc / tmp.Height;
    if radiogroup1.ItemIndex = 1 then qf := sc / tmp.width;
    if radiogroup1.ItemIndex = 2 then
     begin
       if tmp.width >= tmp.height then qf := sc / tmp.width else qf := sc / tmp.height;
     end;

    nw := round (tmp.width * qf);
    nh := round (tmp.height * qf);
    bmp.Width:=nw;
    bmp.Height:=nh;
   end;

  SetStretchBltMode(bmp.Canvas.Handle, HALFTONE);
  StretchBlt(bmp.Canvas.Handle, 0,0,bmp.Width,bmp.Height, tmp.Canvas.Handle, 0,0,tmp.Width,tmp.Height, SRCCOPY);

  progressbar1.Position := 50;
  application.ProcessMessages;

         // new image from bmp to container and save it
  if (ftype = '.jpg') or (ftype = 'jpeg') then
   begin
    jpg.Assign(bmp);
    jpg.SaveToFile(fname);
    jpg.Free;
   end;

  if ftype = '.png' then
   begin
    png.Assign(bmp);
    png.SaveToFile(fname);
    png.Free;
   end;

  if ftype = '.bmp' then bmp.SaveToFile(fname);

  label1.Caption := inttostr (nw) + ' ' + inttostr (nh) +
      ' | ' + IntToStr(FileSize(listbox1.Items [listbox1.ItemIndex]) div 1024) + ' KB';;

  application.ProcessMessages;
  progressbar1.Position := 90;
  application.ProcessMessages;

  tmp.Free;
  bmp.Free;

  application.ProcessMessages;
  progressbar1.Position := 0;
  application.ProcessMessages;

end;


procedure TForm2.TrackBar1Change(Sender: TObject);
begin
  label3.Caption := inttostr (TrackBar1.Position);
end;

procedure TForm2.BuildTree (path:string);
var
  s, res:string;
begin
  for s in TDirectory.GetFiles(path, '*.*', TSearchOption.soAllDirectories) do
    begin
      if (pos('.jpg', ansilowercase(s)) <> 0) or (pos('.png', ansilowercase(s)) <> 0) or
         (pos('.jpeg', ansilowercase(s)) <> 0) or (pos('.bmp', ansilowercase(s)) <> 0)
       then ListBox1.Items.Add(StringReplace(s, path, '', [rfReplaceAll])); //выводим результат
    end;
end;



procedure TForm2.Button1Click(Sender: TObject);
begin
  if fileopendialog1.Execute then
   begin
    edit1.text := fileopendialog1.FileName + '\';
    listbox1.clear;
    BuildTree (fileopendialog1.FileName + '\');
   end;
end;

procedure TForm2.Button2Click(Sender: TObject);
var
  i, temp: Integer;
begin
  temp:=MessageBox(handle, PChar('Данное действие перезапишет все файлы. Убедитесь, что у вас есть копии файлов.' + #10#13 + 'Нажмите "Нет", чтобы отменить операцию.' + #10#13 + 'Продолжить?'), PChar('Осторожно!'), MB_YESNO+MB_ICONWARNING);
  case temp of
   idno:exit;// выключаем прогу
  end;

   for i := 0  to listbox1.Items.Count-1 do
      begin
        listbox1.ItemIndex := i;

        listbox1.OnClick(Listbox1);

        label1.Caption := inttostr (image1.picture.Width) + ' ' + inttostr (image1.picture.Height) +
                  ' | ' + IntToStr(FileSize(listbox1.Items [listbox1.ItemIndex]) div 1024) + ' KB';

        application.ProcessMessages;
        button3.Click;
        application.ProcessMessages;
      end;
   beep;
   showmessage ('Done!');

end;

procedure TForm2.Button3Click(Sender: TObject);
begin
     resizejpeg (edit1.Text + Listbox1.Items [listbox1.ItemIndex], strtoint (edit2.text));
end;

procedure TForm2.Button4Click(Sender: TObject);
begin
  listbox1.Items.Delete(listbox1.ItemIndex);
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
  listbox1.Clear;
  image1.Picture.Bitmap := nil;
  Label1.Caption := '';
end;

procedure TForm2.Exit1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  edit1.Text := ExtractFilePath(Application.ExeName);
  BuildTree (edit1.Text);
end;

procedure TForm2.About2Click(Sender: TObject);
begin
  Showmessage ('Картинко-ужиматор' + #10#13 +
                'by: Иван Бурьянов' + #10#13 +
                'Лицензия для личного и коммерческого использования: ' + #10#13 +
                'Freeware' + #10#13 + #10#13 +
                'Здорово, Серёга!');
end;

procedure TForm2.ListBox1Click(Sender: TObject);
begin
 if listbox1.ItemIndex = -1 then exit;
 if FileSize(edit1.Text + listbox1.Items [listbox1.ItemIndex]) = 0 then
   begin
     beep;
     memo1.Lines.Add(datetimetostr (now) + ' Файл ' + edit1.Text + listbox1.Items [listbox1.ItemIndex] + ' повержден. Размер 0 байт');
     exit;
   end;

 try
  image1.Picture.LoadFromFile (edit1.Text + listbox1.Items [listbox1.ItemIndex]);
 except
  beep;
  memo1.Lines.Add(datetimetostr (now) + ' Не удалось открыть файл ' + edit1.Text + listbox1.Items [listbox1.ItemIndex]);
  exit;
 end;

 label1.Caption := inttostr (image1.picture.Width) + ' ' + inttostr (image1.picture.Height) +
          ' | ' + IntToStr(FileSize(edit1.Text + listbox1.Items [listbox1.ItemIndex]) div 1024) + ' KB';

end;

procedure TForm2.Open1Click(Sender: TObject);
begin
  Button1.Click;
end;

procedure TForm2.RadioButton1Click(Sender: TObject);
begin
  radiogroup1.Visible := true;

end;

procedure TForm2.RadioButton2Click(Sender: TObject);
begin
  radiogroup1.Visible := false;

end;

end.
