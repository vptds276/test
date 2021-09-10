unit TQuestionHelper;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TQuestion = class
  public
    question: string;
    answers: TStringList;
    correct: integer;
    constructor Create(Name: string); overload;
  end;

implementation

constructor TQuestion.Create(Name: string);
begin
  question := Name;
end;

end.
