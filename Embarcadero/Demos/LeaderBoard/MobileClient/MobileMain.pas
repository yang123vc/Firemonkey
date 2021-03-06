unit MobileMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, unitGame,
  FMX.StdCtrls, FMX.Edit, FMX.TabControl, FMX.Layouts, System.Rtti,
  System.Bindings.Outputs, Fmx.Bind.Editors, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, FMX.ListView.Types, Data.Bind.Components, FMX.ListView;

type
  TfrmMobileGuessGame = class(TForm)
    TabControl1: TTabControl;
    tabPlayer: TTabItem;
    tabGuess: TTabItem;
    tabLeaders: TTabItem;
    EditName: TEdit;
    LabelName: TLabel;
    EditScore: TEdit;
    LabelScore: TLabel;
    btnConnect: TButton;
    Layout2: TLayout;
    btnGuess: TButton;
    sbGuess: TSpinBox;
    lblResult: TLabel;
    ToolBar1: TToolBar;
    Label1: TLabel;
    ToolBar2: TToolBar;
    Label3: TLabel;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    ListView1: TListView;
    ToolBar3: TToolBar;
    Label4: TLabel;
    LinkListControlToField1: TLinkListControlToField;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    LinkPropertyToFieldText2: TLinkPropertyToField;
    LinkPropertyToFieldText3: TLinkPropertyToField;
    LinkPropertyToFieldText4: TLinkPropertyToField;
    procedure btnConnectClick(Sender: TObject);
    procedure btnGuessClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Game : TGuessingGame;
  end;

var
  frmMobileGuessGame: TfrmMobileGuessGame;

implementation

{$R *.fmx}

uses dmMain, unitGamePlayer;

procedure TfrmMobileGuessGame.btnConnectClick(Sender: TObject);
begin
  dmMain.dataMain.ConnectToScoreboard;
end;

procedure TfrmMobileGuessGame.btnGuessClick(Sender: TObject);
var
  R: TGuessResult;
begin
  if Game = nil then begin
    Game := TGuessingGame.Create(TGamePlayer(dmMain.dataMain.pbsPlayer.InternalAdapter.Current));
  end;

  R := Game.HaveAGuess(Trunc(sbGuess.Value));
  case R of
    Correct: begin
               lblResult.Text := 'Congratulations - you guessing in '+Game.Guesses.ToString+' guesses';
               Game.Player.Score := Game.Guesses;
               dataMain.pbsPlayer.ApplyUpdates;
               dataMain.SendScore;
               Game.Reset;
             end;
    ToHigh : lblResult.Text := 'To High';
    ToLow  : lblResult.Text := 'To Low';
  end;
end;

procedure TfrmMobileGuessGame.FormCreate(Sender: TObject);
begin
  TabControl1.ActiveTab := tabPlayer;
end;

end.
