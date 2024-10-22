unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, ComObj,
  Vcl.Buttons, Vcl.ComCtrls, Vcl.ToolWin, Vcl.ExtCtrls, System.ImageList,
  Vcl.ImgList;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    OpenDialog1: TOpenDialog;
    StringGrid1: TStringGrid;
    ImageList1: TImageList;
    ProgressBar1: TProgressBar;
    procedure ToolButton1Click(Sender: TObject);
  private
    { Private declarations }
    function XlsToStringGrid(XStringGrid: TStringGrid; xFileXLS: string): Boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    XlsToStringGrid(StringGrid1,OpenDialog1.FileName)
end;

function TForm1.XlsToStringGrid(XStringGrid: TStringGrid;
  xFileXLS: string): Boolean;
const
  xlCellTypeLastCell = $0000000B;
var
  XLSAplicacao, AbaXLS: OleVariant;
  RangeMatrix: Variant;
  x, y, k, r: Integer;
  StringList: TStringList;
  StringListSQL: TStringList;
  Text: String;
  I: TObject;
begin

  StringList := TStringList.Create;
  StringListSQL := TStringList.Create;
  Result := False;
  // Cria Excel- OLE Object
  XLSAplicacao := CreateOleObject('Excel.Application');
  try
  // Esconde Excel
    XLSAplicacao.Visible := False;
    // Abre o Workbook
    XLSAplicacao.Workbooks.Open(xFileXLS);

    {Selecione aqui a aba que voc� deseja abrir primeiro - 1,2,3,4....}
    XLSAplicacao.WorkSheets[1].Activate;
    {Selecione aqui a aba que voc� deseja ativar - come�ando sempre no 1 (1,2,3,4) }
    AbaXLS := XLSAplicacao.Workbooks[ExtractFileName(xFileXLS)].WorkSheets[1];

    AbaXLS.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;
    // Pegar o n�mero da �ltima linha
    x := XLSAplicacao.ActiveCell.Row;
    // Pegar o n�mero da �ltima coluna
    y := XLSAplicacao.ActiveCell.Column;
    // Seta xStringGrid linha e coluna
    XStringGrid.RowCount := x;
    XStringGrid.ColCount := y;
    // Associaca a variant WorkSheet com a variant do Delphi
    RangeMatrix := XLSAplicacao.Range['A1', XLSAplicacao.Cells.Item[x, y]].Value;
    // Cria o loop para listar os registros no TStringGrid
    k := 1;
    repeat
       for r := 1 to y do
        begin
          //Text := Text +  RangeMatrix[k, r] +', ' ;
          XStringGrid.Cells[(r - 1), (k - 1)] := RangeMatrix[k, r];
          StringList.Add(RangeMatrix[k, r]);
        end;
       Inc(k, 1);
       Text := 'UPDATE OR INSERT INTO '+{Nome da Tabela}+' (BDCODCID,BDREFATVM,BDCODMUNATVM,BDDESCATVM,BDALIQATVM,BDCODSER,BDIDCNAE,BDCODTRIBATVM) VALUES (4991,202103,'+QuotedStr(StringList[3])+','+QuotedStr(StringList[4])+','+StringList[5]+','+StringList[6]+','+StringList[7]+','+StringList[8]+') MATCHING (BDCODCID,BDCODMUNATVM);';
       StringListSQL.Add(Text);
       StringList.Clear;
       ProgressBar1.Position := ProgressBar1.Position + 1;
       Text := emptystr;
    until k > x;
    RangeMatrix := Unassigned;
  finally
    // Fecha o Microsoft Excel
    if not VarIsEmpty(XLSAplicacao) then
    begin
          XLSAplicacao.Quit;
          XLSAplicacao := Unassigned;
          AbaXLS := Unassigned;
          Result := True;
    end;
    ShowMessage('Arquivos importados com sucesso!') ;
    StringListSQL.SaveToFile('C:\SQL.sql');
  end;

end;

end.
