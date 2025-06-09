using projectmanager from '../db/schema';

service ProjectService {
    entity Projects     as projection on projectmanager.Project;
    entity ProjectTeams as projection on projectmanager.ProjectTeam;
    entity Tasks        as projection on projectmanager.Task;
}
