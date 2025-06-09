namespace projectmanager;

using {
    managed,
    cuid
} from '@sap/cds/common';

entity Project : cuid, managed {
    name        : String;
    description : String;
    startDate   : Date;
    endDate     : Date; // planned end date
    status      : String; // calculated: "On-Time", "Delayed"

    cost        : Decimal(15, 2); // total cost of project
}

entity ProjectTeam : cuid, managed {
    name       : String;
    role       : String;
    skillLevel : String; // e.g. Junior, Mid, Senior

    hourlyRate : Decimal(10, 2); // cost/hour based on skill level

    project    : Association to Project;
}

entity Task : cuid, managed {
    title        : String;
    status       : String;
    startDate    : Date;
    endDate      : Date; // planned end date for task

    project      : Association to Project;
    workedUponBy : Association to ProjectTeam;
}
