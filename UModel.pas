unit UModel;

interface


type
  Exam = class
  private
    FExam_No:string;
    FTitle1:string;
    FTitle2:string;
    FTitle3:string;
    FMem1:string;
   { private declarations }
  public
    property Exam_No : string read FExam_No;
    property Title1 : string read FTitle1;
    property Title2 : string read FTitle2;
    property Title3 : string read FTitle3;
    property Mem1 : string read FMem1;

    constructor Create(Exam_No, Title1, Title2, Title3, Mem1: string);
   { public declarations }
   end;

   ExamStruc = class
   private
   var
     FExam_No:string;
     FSub_No:string;
     FStruc_No:Integer;
     FSer_No:Integer;
   public
     property Exam_No : string read FExam_No;
     property Sub_No : string read FSub_No;
     property Ser_No : Integer read FSer_No;
     property Struc_No : Integer read FStruc_No;

     constructor Create(Exam_No, Sub_No: string; Ser_No, Struc_No: Integer);
   end;

  ExamSub = class
  private
    FExam_No:string;
    FGrade:string;
    FSub_No:string;
    FSub_Name:string;
    Ford:Integer;
    Fweight:Integer;
  public
    property Exam_No : string read FExam_No;
    property Grade : string read FGrade;
    property Sub_No : string read FSub_No;
    property Sub_Name : string read FSub_Name;
    property ord : Integer read Ford;
    property weight : Integer read Fweight;

    constructor Create(Exam_No, Grade, Sub_No, Sub_Name: string; ord, weight: Integer);
  end;

   Student = class
   private
   var
    FStudent_No:String;
    FX_No:string;
    FSch_Code:string;
    FSch_Name:string;
    FGrade:string;
    FClass_No:string;
    FSeat_No:String;
    FStudent_Name:string;
    FGroup_No:string;
    FRemark:string;
   public
     property Student_No : String read FStudent_No;
     property X_No : string read FX_No;
     property Sch_Code : string read FSch_Code;
     property Grade : string read FGrade;
     property Class_No : string read FClass_No;
     property Seat_No : String read FSeat_No;
     property Student_Name : string read FStudent_Name;
     property Group_No : string read FGroup_No;
     property Remark : string read FRemark;
     property Sch_Name : string read FSch_Name;

     constructor Create(Student_No, X_No, Sch_Code, Sch_Name, Grade, Class_No,
      Seat_No, Student_Name, Group_No, Remark: string);
   end;

   Sub_Score = class
   private
   var
    FStudent_No:String;
    FSub01Right_Count:string;
    FSub01_No:string;
    FSub01_Name:string;
    FSub01_Sum_Sub:String;
    FSub01_Ans_Status2:string;
    FSub02Right_Count:string;
    FSub02_No:string;
    FSub02_Name:string;
    FSub02_Sum_Sub:String;
    FSub02_Ans_Status2:string;   public
     property Student_No : String read FStudent_No;
     property Sub01Right_Count : string read FSub01Right_Count;
     property Sub01_No : string read FSub01_No;
     property Sub01_Name : string read FSub01_Name;
     property Sub01_Sum_Sub : string read FSub01_Sum_Sub;
     property Sub01_Status2 : string read FSub01_Ans_Status2;
     property Sub02Right_Count : string read FSub02Right_Count;
     property Sub02_No : string read FSub02_No;
     property Sub02_Name : string read FSub02_Name;
     property Sub02_Sum_Sub : string read FSub02_Sum_Sub;
     property Sub02_Status2 : string read FSub02_Ans_Status2;

     constructor Create(Student_No, Sub01Right_Count, Sub01_No, Sub01_Name, Sub01_Sum_Sub, Sub01_Status2,
     Sub02Right_Count, Sub02_No, Sub02_Name, Sub02_Sum_Sub, Sub02_Status2: string);
   end;

  StudentDetail = class
    private
      FStudent_Name: string;
      FStudent_No: String;
      FSchool_Name: String;
      FGrade: String;
      FClass_No: String;
      FSub01Name: string;
      FSub02Name: string;
      FSub01Score: string;
      FSub02Score: string;
      FSub01RightCount: string;
      FSub02RightCount: string;
      FSumSub: string;
      FAverage: string;
      FArrange: string;
      FSub01Ans: string;
      FSub02Ans: string;
      FGroup_No: string;
  public
    property Student_No : string read FStudent_No write FStudent_No;
    property StudentName : string read FStudent_Name write FStudent_Name;
    property School_Name : string read FSchool_Name write FSchool_Name;
    property Grade : string read FGrade write FGrade;
    property Class_No : string read FClass_No write FClass_No;
    property Sub01Name : string read FSub01Name write FSub01Name;
    property Sub02Name : string read FSub02Name write FSub02Name;
    property Sub01Score : string read FSub01Score write FSub01Score;
    property Sub02Score : string read FSub02Score write FSub02Score;
    property Sub01RightCount : string read FSub01RightCount write FSub01RightCount;
    property Sub02RightCount : string read FSub02RightCount write FSub02RightCount;
    property SumSub : string read FSumSub write FSumSub;
    property Average : string read FAverage write FAverage;
    property Arrange : string read FArrange write FArrange;
    property Sub01Ans : string read FSub01Ans write FSub01Ans;
    property Sub02Ans : string read FSub02Ans write FSub02Ans;
    property Group_No : string read FGroup_No write FGroup_No;
    constructor Create(Student_No, StudentName, School_Name, Grade, Class_No, Sub01Name,
     Sub02Name, Sub01Score, Sub02Score, Sub01RightCount, Sub02RightCount, SumSub,
     Average, Arrange, Sub01Ans, Sub02Ans, Group_No: string);
  end;




implementation

constructor Exam.Create(Exam_No, Title1, Title2, Title3, Mem1: string);
begin
	inherited Create;
  Self.FExam_No:= Exam_No;
  Self.FTitle1:= Title1;
  Self.FTitle2:= Title2;
  Self.FTitle3:= Title3;
  Self.FMem1:= Mem1;
end;

constructor ExamStruc.Create(Exam_No, Sub_No: string; Ser_No, Struc_No: Integer);
begin
	inherited Create;
  Self.FExam_No:= Exam_No;
  Self.FSub_No:= Sub_No;
  Self.FSer_No:= Ser_No;
  Self.FStruc_No:= Struc_No;
end;

constructor Student.Create(Student_No, X_No, Sch_Code, Sch_Name, Grade, Class_No,
 Seat_No, Student_Name, Group_No, Remark: string);
begin
	inherited Create;
  Self.FStudent_No:= Student_No;
  Self.FX_No:= X_No;
  Self.FSch_Code:= Sch_Code;
  Self.FSch_Name:= Sch_Name;
  Self.FGrade:= Grade;
  Self.FClass_No:= Class_No;
  Self.FSeat_No:= Seat_No;
  Self.FStudent_Name:= Student_Name;
  Self.FGroup_No:= Group_No;
  Self.FRemark:= Remark;
end;

constructor ExamSub.Create(Exam_No, Grade, Sub_No, Sub_Name: string; ord, weight: Integer);
begin
	inherited Create;
  Self.FExam_No:= Exam_No;
  Self.FGrade:= Grade;
  Self.FSub_No:= Sub_No;
  Self.FSub_Name:= Sub_Name;
  Self.Ford:= ord;
  Self.Fweight:= weight;
end;

constructor Sub_Score.Create(Student_No, Sub01Right_Count, Sub01_No, Sub01_Name,
     Sub01_Sum_Sub, Sub01_Status2, Sub02Right_Count, Sub02_No, Sub02_Name,
     Sub02_Sum_Sub, Sub02_Status2: string);
begin
	inherited Create;
  Self.FStudent_No:= Student_No;
  Self.FSub01Right_Count:= Sub01Right_Count;
  Self.FSub01_No:= Sub01_No;
  Self.FSub01_Name:= Sub01_Name;
  Self.FSub01_Sum_Sub:= Sub01_Sum_Sub;
  Self.FSub01_Ans_Status2:= Sub01_Status2;
  Self.FSub02Right_Count:= Sub02Right_Count;
  Self.FSub02_No:= Sub02_No;
  Self.FSub02_Name:= Sub02_Name;
  Self.FSub02_Sum_Sub:= Sub02_Sum_Sub;
  Self.FSub02_Ans_Status2:= Sub02_Status2;
end;

constructor StudentDetail.Create(Student_No, StudentName, School_Name, Grade, Class_No, Sub01Name,
     Sub02Name, Sub01Score, Sub02Score, Sub01RightCount, Sub02RightCount, SumSub,
     Average, Arrange, Sub01Ans, Sub02Ans, Group_No: string);
begin
  inherited Create;
  Self.FStudent_No:= Student_No;
  Self.FStudent_Name:= StudentName;
  Self.FSchool_Name:= School_Name;
  Self.FGrade:= Grade;
  Self.FClass_No:= Class_No;
  Self.FSub01Name:= Sub01Name;
  Self.FSub02Name:= Sub02Name;
  Self.FSub01Score:= Sub01Score;
  Self.FSub02Score:= Sub02Score;
  Self.FSub01RightCount:= Sub01RightCount;
  Self.FSub02RightCount:= Sub02RightCount;
  Self.FSumSub:= SumSub;
  Self.FAverage:= Average;
  Self.FArrange:= Arrange;
  Self.FSub01Ans:= Sub01Ans;
  Self.FSub02Ans:= Sub02Ans;
  Self.FGroup_No:= Group_No;
end;

function Sum(Collection: IEnumerable): Integer;
var
  Enumerator: IEnumerator;
begin
  Result:= 0;
  Enumerator:= Collection.GetEnumerator;
  while Enumerator.MoveNext do
  begin
    Inc(Result, Integer(Enumerator.Current));
  end;
end;

end.
