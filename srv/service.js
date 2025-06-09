const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
    const { Projects, Tasks, ProjectTeams } = this.entities;

    this.on('READ', Projects, async (req) => {
        const tx = cds.tx(req);
        let projects = await tx.run(SELECT.from(Projects));

        const today = new Date();

        for (let project of projects) {
            // Calculate project status
            const endDate = new Date(project.endDate);
            project.status = (today > endDate) ? 'Delayed' : 'On-Time';

            // Calculate project cost
            const tasks = await tx.run(
                SELECT.from(Tasks).where({ project_ID: project.ID })
            );

            let totalCost = 0;
            for (let task of tasks) {
                // Get team member hourly rate
                const teamMember = await tx.run(
                    SELECT.one.from(ProjectTeams).where({ ID: task.workedUponBy_ID })
                );
                if (teamMember && task.estimatedHours) {
                    totalCost += task.estimatedHours * teamMember.hourlyRate;
                }
            }
            project.cost = totalCost;
        }
        return projects;
    });
});
