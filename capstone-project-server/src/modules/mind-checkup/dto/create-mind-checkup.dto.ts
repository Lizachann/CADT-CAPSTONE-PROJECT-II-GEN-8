import { ApiProperty } from '@nestjs/swagger';
import { IsEnum, IsNotEmpty, IsString } from 'class-validator';

export enum Gender {
  Female = 'Female',
  Male = 'Male',
}

export enum Occupation {
  Corporate = 'Corporate',
  Student = 'Student',
  Business = 'Business',
  Housewife = 'Housewife',
  Others = 'Others',
}

export enum YesNo {
  No = 'No',
  Yes = 'Yes',
}

export enum YesNoMaybe {
  No = 'No',
  Maybe = 'Maybe',
  Yes = 'Yes',
}

export enum Frequency {
  Days1to14 = '1-14 days',
  GoOutEveryDay = 'Go out Every day',
  MoreThan2Months = 'More than 2 months',
  Days15to30 = '15-30 days',
  Days31to60 = '31-60 days',
}

export enum Severity {
  Medium = 'Medium',
  Low = 'Low',
  High = 'High',
}

export enum NotSureNoYes {
  NotSure = 'Not sure',
  No = 'No',
  Yes = 'Yes',
}

export class CreateMindCheckupDto {
  @ApiProperty({})
  @IsNotEmpty()
  @IsString()
  patient: string;

  @ApiProperty({ enum: Gender })
  @IsEnum(Gender)
  @IsNotEmpty()
  Gender: 'Female' | 'Male';

  @ApiProperty({
    enum: ['Corporate', 'Student', 'Business', 'Housewife', 'Others'],
  })
  @IsEnum(Occupation)
  @IsNotEmpty()
  Occupation: 'Corporate' | 'Student' | 'Business' | 'Housewife' | 'Others';

  @ApiProperty({ enum: YesNo })
  @IsEnum(YesNo)
  @IsNotEmpty()
  self_employed: 'No' | 'Yes';

  @ApiProperty({ enum: YesNo })
  @IsEnum(YesNo)
  @IsNotEmpty()
  family_history: 'No' | 'Yes';

  @ApiProperty({ enum: YesNo })
  @IsEnum(YesNo)
  @IsNotEmpty()
  treatment: 'Yes' | 'No';

  @ApiProperty({
    enum: Frequency,
  })
  @IsEnum(Frequency)
  @IsNotEmpty()
  Days_Indoors:
    | '1-14 days'
    | 'Go out Every day'
    | 'More than 2 months'
    | '15-30days'
    | '31-60 days';

  @ApiProperty({ enum: YesNoMaybe })
  @IsEnum(YesNoMaybe)
  @IsNotEmpty()
  Growing_Stress: 'Yes' | 'No' | 'Maybe';

  @ApiProperty({ enum: YesNoMaybe })
  @IsEnum(YesNoMaybe)
  @IsNotEmpty()
  Changes_Habits: 'No' | 'Yes' | 'Maybe';

  @ApiProperty({ enum: Severity })
  @IsEnum(Severity)
  @IsNotEmpty()
  Mood_Swings: 'Medium' | 'Low' | 'High';

  @ApiProperty({ enum: YesNo })
  @IsEnum(YesNo)
  @IsNotEmpty()
  Coping_Struggles: 'No' | 'Yes';

  @ApiProperty({ enum: YesNoMaybe })
  @IsEnum(YesNoMaybe)
  @IsNotEmpty()
  Work_Interest: 'No' | 'Maybe' | 'Yes';

  @ApiProperty({ enum: YesNoMaybe })
  @IsEnum(YesNoMaybe)
  @IsNotEmpty()
  Social_Weakness: 'Yes' | 'No' | 'Maybe';

  @ApiProperty({ enum: YesNoMaybe })
  @IsEnum(YesNoMaybe)
  @IsNotEmpty()
  mental_health_interview: 'No' | 'Maybe' | 'Yes';

  @ApiProperty({ enum: NotSureNoYes })
  @IsEnum(NotSureNoYes)
  @IsNotEmpty()
  care_options: 'Not sure' | 'No' | 'Yes';
}
