unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, DateUtils, TQuestionHelper;

type

  { TForm1 }

  TForm1 = class(TForm)
    BackBtn: TButton;
    TimeLeft: TLabel;
    NextBtn: TButton;
    QuestionNumber: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    QuestionDisplay: TLabel;
    RadioGroup1: TRadioGroup;
    StartBtn: TButton;
    TestSelectBox: TComboBox;
    FirstNameField: TEdit;
    MainTitle: TLabel;
    LastNameField: TEdit;
    CountdownUpdater: TTimer;
    procedure CountdownUpdaterTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NextBtnClick(Sender: TObject);
    procedure StartBtnClick(Sender: TObject);
  private

  public
    function NewQuestion(strFix: string): TQuestion;
  end;

  //QuestionList = specialize TFPGObjectList<TQuestion>;

var
  Form1: TForm1;
  startTime: TDateTime;
  //qstList: QuestionList;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.StartBtnClick(Sender: TObject);
var
  loadedTest: TStringList;
  i: integer;
  str, strFix: string;
begin
  //todo: load up the test
  loadedTest.Create;
  //loadedTest.LoadFromFile(TestSelectBox.Items[TestSelectBox.ItemIndex]);
  loadedTest.LoadFromFile('tests');
  {for i := 0 to loadedTest.Count do
  begin
    str := loadedTest.Strings[i];
    strFix := str.Substring(2).Trim;
    case loadedTest.Strings[i].Substring(0, 2).ToLower of
      'q>':
      begin
        qstList.Add(NewQuestion(strFix));
      end;
      'a>': qstList[qstList.Count].answers.Add(strFix);
      'c>':
      begin
        qstList[qstList.Count].correct := qstList[qstList.Count].answers.Count;
        qstList[qstList.Count].answers.Add(strFix);
      end;
      else
        Continue;
    end;
  end;
  Panel1.Visible := False;
  Panel2.Visible := True;
  startTime := Now;
  CountdownUpdater.Enabled := True;}
end;

function TForm1.NewQuestion(strFix: string): TQuestion;
var
  q:TQuestion;
begin
  q.Create(strFix);
  Result:=q;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  testDir: TSearchRec;
begin
  if not DirectoryExists('tests') then
  begin
    //todo: load up the list of tests
    CreateDir('tests');
    MessageDlg(Caption + ' - Внимание',
      'Папка "tests" не найдена, создаю новую...',
      mtInformation, [mbOK], 0);
  end;

  if FindFirst('*', faAnyFile, testDir) = 0 then
  begin
    repeat
      with testDir do
      begin
        if (Attr and faDirectory) = faDirectory then
          TestSelectBox.Items.Add(testDir.Name);
      end;
    until FindNext(testDir) <> 0;
    FindClose(testDir);
  end;
end;

procedure TForm1.NextBtnClick(Sender: TObject);
begin
  //todo: write answer and switch to next question otherwise, finish the test
end;

procedure TForm1.CountdownUpdaterTimer(Sender: TObject);
var
  secondsLeft: integer;
begin
  secondsLeft := 300 - SecondsBetween(Now, startTime);
  if secondsLeft > 0 then
    TimeLeft.Caption := 'Время: ' + IntToStr(secondsLeft)
  else
  begin
    CountdownUpdater.Enabled := False;
    Panel2.Visible := False;
  end;
end;

end.
