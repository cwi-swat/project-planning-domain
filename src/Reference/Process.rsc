module Reference::Process

import Meta::Domain;


public BehaviorRelations ProjectBehavior = {
	*processActivityMultiple("initiate phase", "specify", {"expected result", "allowed result"}, {34})
	, processActivity("requirement", "Planning Process Group", "define", "scope", {47})
	, *processActivityMultiple("Planning Process Group", "define", {"activity", "activity sequence", "activity resource", "activity duration", "schedule"}, {48})
	, *processActivityMultiple("Planning Process Group", "estimate", {"costs", "budget"}, {49})
	, processActivity("Planning Process Group", "plans", "quality", {50})
	, processActivity("Planning Process Group", "plans", "communications plan", {51})
	, processActivity("Planning Process Group", "plans", "risk management", {52})
	, processActivity("Planning Process Group", "identifies", "risk", {52})
	, *processActivityMultiple("Planning Process Group", "performs", {"qualitative analysis", "quantitative analysis"}, {52})
	, processActivity("Planning Process Group", "plans", "risk responses", {52})
	, processActivity("Planning Process Group", "plans", "procurement", {53})
	, processActivity("Planning Process Group", "establish", "scope of the effort", {54})
	, processActivity("Planning Process Group", "(re)define", "objective", {54})
	, processActivity("Planning Process Group", "develop", "course of action", {54}) // blergh
	, actorActivity("change", "Project Management","implement", "change process", {17})
	, *actorActivityMultiple("Project Management", "generates", {"change request", "work performance information", "project plan updates", "project documentation updates"}, {72})
	, *actorActivityMultiple("Project Management", "performs", {"quality audit", "quality control measurements"}, {73})
	, actorActivity("Project Management", "assigns", "staff", {74})
	, actorActivity("Project Management", "arranges", "resource calendar", {74})
	, *actorActivityMultiple("Project Management", "develops", {"team competencies", "team interaction", "team environment"}, {75})
	, actorActivity("Project Management", "track", "team performance", {76})
	, actorActivity("Project Management", "provide", "feedback", {76})
	, actorActivity("Project Management", "solve", "issue", {76})
	, actorActivity("Project Management", "optimize", "project performance", {76})
	, actorActivity("Project Management", "distribute", "information", {77}) // to stakeholders? need another kind of activity perhaps?
	, actorActivity("Project Management", "communicate with", "stakeholder", {78})
	, actorActivity("Project Management", "work with", "stakeholder", {78})
	, *actorActivityMultiple("Stakeholder", "express", {"needs","issue"}, {78})
	, actorActivity("Stakeholder", "influence", "requirement", {39})
	, *processActivityMultiple("activity definition process", "define", {"activity list", "activity attribute", "milestone list"}, {91}) // blergh
	, composedOutOf("schedule", {"activity list", "activity attribute", "project schedule network diagram", 
		"activity resource requirement", "resource calendar", "activity duration estimates", "project scope statement",
		"enterprise environmental factors", "organizational process assets"}, {96})
	, processActivity("reality", "control schedule", "improve/adjust", "schedule", {98})
	, processActivity("control schedule", "generate", "change request", {98})
	, processActivity("control schedule", "generate", "performance measurements", {98})
	, composedOutOf("activity list", {"previous project"}, {100})	, processActivity("activity attribute", "schedule development", "review/revision", "estimates", {107,131})	, composedOutOf("project", {"previous project history"}, {121})
	, *processActivityMultiple({"estimated work effort", "estimated resources"}, "Estimate Activity Durations", "estimates", "activity duration", {125})
	, *processActivityMultiple({"activity sequence", "activity duration", "resource requirement", "schedule constraints"}, "Develop Schedule", "develops", "schedule", {129})	, composedOutOf("schedule", {"activity sequence", "activity duration", "resource requirement", "schedule constraints"}, {129})
	, *processActivityMultiple("Schedule development", "causes", {"estimate review", "estimate revision"}, {131}) 	, processActivity("performance previous tasks", "Control Schedule", "changes", "schedule", {138})	, processActivity("activity resource requirement", "Human resource planning", " determine", "human resource plan", {143})
	, processActivity("Risk monitoring", "create", "change request", {147})
	, processActivity("Procurement", "create", "change request", {148})	, actorActivity("Change Control Board", "approve/reject", "change request", {80})	, actorActivity("Project Management", "approve/reject", "change request", {80})};